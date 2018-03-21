;; Copyright 2018
;; Kaz Kylheku <kaz@kylheku.com>
;; Vancouver, Canada
;; All rights reserved.
;;
;; Redistribution and use in source and binary forms, with or without
;; modification, are permitted provided that the following conditions are met:
;;
;; 1. Redistributions of source code must retain the above copyright notice, this
;;    list of conditions and the following disclaimer.
;;
;; 2. Redistributions in binary form must reproduce the above copyright notice,
;;    this list of conditions and the following disclaimer in the documentation
;;    and/or other materials provided with the distribution.
;;
;; THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
;; ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
;; WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
;; DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
;; FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
;; DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
;; SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
;; CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
;; OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
;; OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

(in-package :sys)

(defstruct oc-base nil
  (:method synerr (me fmt . args)
    (error `opcode @{me.symbol}: @fmt` . args))

  (:method chk-arg-count (me n syntax)
    (when (neq (length (rest syntax)) n)
      me.(synerr "~s arguments required; ~s is invalid"
                 n syntax)))

  (:method chk-arg-count-min (me n syntax)
    (when (< (length (rest syntax)) n)
      me.(synerr "~s arguments required; ~s is invalid"
                 n syntax)))

  (:method backpatch (me asm at offs)
    (error `assembler: @{me.symbol} doesn't backpatch`)))

(defstruct assembler nil
  buf
  bstr
  (labdef (hash))
  (labref (hash))
  (:static imm-width (relate '(si mi bi) '(10 16 32)))
  (:static sign-bits (relate '(fixnum bignum chr) '(1 1 0)))
  (:static operand-name (relate '(si mi bi l r rs d ds n o)
                                '("small immediate"
                                  "medium immediate"
                                  "big immediate"
                                  "label"
                                  "register operand"
                                  "register small operand"
                                  "register destination operand"
                                  "register small destination operand"
                                  "integer"
                                  "any object"))))

(defmeth assembler :postinit (me)
  (cond
    (me.buf (set me.bstr (make-buf-stream me.buf)))
    (me.bstr (set me.buf (get-buf-from-stream me.bstr)))
    (t (set me.bstr (make-buf-stream)
            me.buf (get-buf-from-stream me.bstr)))))

(defmeth assembler cur-pos (me)
  (seek-stream me.bstr 0 :from-current))

(defmeth assembler set-pos (me pos)
  (seek-stream me.bstr pos :from-start))

(defmeth assembler lookup-label (me sym oc)
  (condlet
    (((n [me.labdef sym])) n)
    (t (push (cons oc (trunc me.(cur-pos) 4)) [me.labref sym])
       0)))

(defmeth assembler define-label (me sym)
  (let* ((pos me.(cur-pos))
         (ins (trunc pos 4)))
    (set [me.labdef sym] ins)
    (each ((entry (del [me.labref sym])))
      (tree-bind (oc . offs) entry
        me.(set-pos (* 4 offs))
        oc.(backpatch me (* 4 offs) ins)))
    me.(set-pos pos)
    ins))

(defmeth assembler read-buf (me bytes)
  (let ((buf (make-buf bytes)))
    (when (neql (fill-buf buf 0 me.bstr) bytes)
      (error "assembler: read past instruction block"))
    buf))

(defmeth assembler put-word (me word)
  (let* ((buf (make-buf 0)))
    (buf-put-u32 buf 0 word)
    (put-buf buf 0 me.bstr)))

(defmeth assembler put-insn (me code extension operand)
  (let ((word (logior (ash code 26) (ash extension 16) operand))
        (buf (make-buf 0)))
    (buf-put-u32 buf 0 word)
    (put-buf buf 0 me.bstr)))

(defmeth assembler put-pair (me op1 op2)
  (let ((word (logior (ash op1 16) op2))
        (buf (make-buf 0)))
    (buf-put-u32 buf 0 word)
    (put-buf buf 0 me.bstr)))

(defmeth assembler get-word (me)
  (let* ((buf me.(read-buf (sizeof uint32))))
    (buf-get-u32 buf 0)))

(defmeth assembler get-insn (me)
  (let* ((buf me.(read-buf (sizeof uint32)))
         (word (buf-get-u32 buf 0)))
    (list (ash word -26)
          (logtrunc (ash word -16) 10)
          (logtrunc word 16))))

(defmeth assembler get-pair (me)
  (let* ((buf me.(read-buf (sizeof uint32)))
         (word (buf-get-u32 buf 0)))
    (list (ash word -16) (logtrunc word 16))))

(defmeth assembler immediate-fits-type (me arg operand-type)
  (and (member (typeof arg)
               '(fixnum bignum chr))
       (<= (+ (width arg)
              [me.sign-bits (typeof arg)]
              2)
           [me.imm-width operand-type])))

(defmeth assembler parse-args (me oc syntax pattern)
  (mapcar (lambda (type arg n)
            (let ((parg (caseql type
                          ((si mi bi)
                           (when me.(immediate-fits-type arg type)
                             arg))
                          (l (cond
                               ((is-label arg) me.(lookup-label arg oc))
                               ((integerp arg) arg)))
                          (n (if (integerp arg) arg))
                          (o arg)
                          ((r rs d ds)
                           (cond
                             ((null arg) 0)
                             ((consp arg)
                              (parse-compound-operand arg))
                             ((symbolp arg)
                              (parse-operand (symbol-name arg)))))
                          (t (error "assembler: invalid arg type spec ~s"
                                    type)))))
              (unless (or parg (eq type 'o))
                oc.(synerr "argument ~a of ~s invalid; ~a expected"
                           n syntax [me.operand-name type]))
              (when (and (member type '(d ds))
                         (or (zerop parg) (<= 256 parg 511)))
                oc.(synerr "argument ~a of ~s cannot be destination"
                           n syntax))
              (when (and (member type '(rs ds))
                         (not (< parg 1024)))
                oc.(synerr "argument ~a of ~s isn't a small register"
                           n syntax))
              parg))
          pattern (rest syntax) (range 1)))

(defmeth assembler asm-one (me syntax)
  (let ((oc (cond
              ((is-label syntax) [%oc-hash% 'label])
              ((consp syntax) [%oc-hash% (car syntax)]))))
    (unless oc
      (error "assembler: invalid instruction ~s" syntax))
    oc.(asm me syntax)))

(defmeth assembler asm (me insns)
  (each ((i insns))
    me.(asm-one i))
  (unless (empty me.labref)
    (error "assembler: dangling label references"))
  (whenlet ((n (cdr [find-max me.labdef : cdr])))
    (unless (< -1 n (len me.buf))
      (error "assembler: labels outside of code"))))

(defmeth assembler dis-one (me)
  (tree-bind (code extension operand) me.(get-insn)
    (let ((oc [%oc-hash% code]))
      oc.(dis me extension operand))))

(defmeth assembler dis (me)
  me.(set-pos 0)
  (build
    (while (< me.(cur-pos) (len me.buf))
      (add me.(dis-one)))))

(defmeth assembler dis-listing (me : (stream *stdout*))
  (let ((p 0)
        (l (len me.buf)))
    me.(set-pos p)
    (while (< p l)
      (let* ((dis me.(dis-one))
             (dis-txt (cat-str [mapcar tostringp dis] " "))
             (q me.(cur-pos)))
        me.(set-pos p)
        (format t "~,5d: ~,08X ~a\n" (trunc p 4) me.(get-word) dis-txt)
        (while (< (inc p 4) q)
          (format t "~,5d: ~,08X\n" (trunc p 4) me.(get-word)))
        me.(set-pos q)
        (set p q)))))

(defvarl %oc-list-builder% (new list-builder))

(defsymacro %oc-list% %oc-list-builder%.(get))

(defvarl %oc-hash% (hash))

(defvarl %oc-code% 0)

(defun register-opcode (oc)
  %oc-list-builder%.(add oc)
  (set [%oc-hash% oc.symbol] oc)
  (set [%oc-hash% oc.code] oc))

(defun is-label (obj)
  (or (keywordp obj)
      (and (symbolp obj)
           (not (symbol-package obj)))))

(defun parse-compound-operand (cons)
  (tree-case cons
    ((sym arg)
     (when (<= 0 arg 255)
       (caseq sym
         ((t) arg)
         (d (+ arg 256)))))
    ((sym arg1 arg2)
     (when (and (<= 0 arg1 253)
                (<= 0 arg2 255))
       (caseq sym
         (v (+ (* (ssucc arg1) 256) arg2)))))))

(defun parse-operand (str)
  (cond
    ((r^$ #/t[0-9A-Fa-f][0-9A-Fa-f]?/ str)
     (int-str [str 1..:] 16))
    ((r^$ #/d[0-9A-Fa-f][0-9A-Fa-f]?/ str)
     (+ 256 (int-str [str 1..:] 16)))
    ((r^$ #/v[0-9A-Fa-f]?[0-9A-Fa-f][0-9A-Fa-f][0-9A-Fa-f]/ str)
       (let ((xn (int-str [`0@{str[1..:]}` -4..-2] 16))
             (yn (int-str [str -2..:] 16)))
         (+ (* 256 (+ 2 xn)) yn)))))

(defun operand-to-sym (val)
  (let ((xn (ash val -8))
        (yn (logtrunc val 8)))
    (caseql xn
      (0 (if (eql yn 0)
           nil
           (intern (fmt "t~,02X" yn))))
      (1 (intern (fmt "d~,02X" yn)))
      (t (intern (fmt "v~,02X~,02X" (- xn 2) yn))))))

(defun bits-to-obj (bits width)
  (let ((tag (logtrunc bits 2))
        (val (ash bits -2)))
    (caseq tag
      (1 (sign-extend val (- width 2)))
      (2 (chr-int val))
      (t (error "assembler: bad immediate operand: ~s" bits)))))

(defmacro defopcode (class symbol code . slot-defs)
  ^(symacrolet ((auto (pinc %oc-code%)))
     (defstruct ,class oc-base
       (:static symbol ',symbol)
       (:static code ,code)
       ,*slot-defs)
     (register-opcode (new ,class))))

(defmacro defopcode-derived (class symbol code orig-class)
  ^(symacrolet ((auto (pinc %oc-code%)))
     (defstruct ,class ,orig-class
       (:static symbol ',symbol)
       (:static code ,code))
     (register-opcode (new ,class))))

(defopcode op-label label nil
  (:method asm (me asm syntax)
    (unless (is-label syntax)
      asm.(synerr "label must be keyword or gensym"))
    asm.(define-label syntax))

  (:method dis (me asm extension operand)))

(defopcode op-noop noop auto
  (:method asm (me asm syntax)
    me.(chk-arg-count 0 syntax)
    asm.(put-insn me.code 0 0))

  (:method dis (me asm extension operand)
    ^(,me.symbol)))

(defopcode op-frame frame auto
  (:method asm (me asm syntax)
    me.(chk-arg-count 2 syntax)
    (tree-bind (lev size) asm.(parse-args me syntax '(n n))
      (unless (<= 1 lev 255)
        me.(synerr "level must range from 2 to 256"))
      (unless (<= 0 size 256)
        me.(synerr "size must range from 0 to 256"))
      asm.(put-insn me.code lev size)))
  (:method dis (me asm lev size)
    ^(,me.symbol ,lev ,size)))

(defopcode-derived op-sframe sframe auto op-frame)

(defopcode-derived op-dframe dframe auto op-frame)

(defopcode op-end end auto
  (:method asm (me asm syntax)
    me.(chk-arg-count 1 syntax)
    (let ((res (car asm.(parse-args me syntax '(r)))))
      asm.(put-insn me.code 0 res)))
  (:method dis (me asm extension res)
    ^(,me.symbol ,(operand-to-sym res))))

(defopcode-derived op-fin fin auto op-end)

(defopcode op-call call auto
  (:method asm (me asm syntax)
    me.(chk-arg-count-min 2 syntax)
    (let* ((nargs (pred (len syntax)))
           (syn-pat (repeat '(r) (succ nargs)))
           (funargs (ppred nargs))
           (args asm.(parse-args me syntax syn-pat)))
      asm.(put-insn me.code funargs (pop args))
      (while args
        (let ((x (pop args))
              (y (or (pop args) 0)))
          asm.(put-pair y x)))))

  (:method dis (me asm funargs arg0)
    (build
      (add me.symbol)
      (add (operand-to-sym arg0))
      (inc funargs 1)
      (while (> funargs 0)
        (dec funargs 2)
        (tree-bind (y x) asm.(get-pair)
          (add (operand-to-sym x))
          (unless (minusp funargs)
            (add (operand-to-sym y))))))))

(defopcode-derived op-apply apply auto op-call)

(defopcode op-gcall gcall auto
  (:method asm (me asm syntax)
    me.(chk-arg-count-min 2 syntax)
    (let* ((nargs (pred (len syntax)))
           (syn-pat (list* 'r 'n (repeat '(r) (sssucc nargs))))
           (funargs (ppred nargs))
           (args asm.(parse-args me syntax syn-pat)))
      asm.(put-insn me.code funargs (pop args))
      (while args
        (let ((x (pop args))
              (y (or (pop args) 0)))
          asm.(put-pair y x)))))

  (:method dis (me asm funargs arg0)
    (let ((first t))
      (build
        (add me.symbol)
        (add (operand-to-sym arg0))
        (inc funargs 1)
        (while (> funargs 0)
          (dec funargs 2)
          (tree-bind (y x) asm.(get-pair)
            (add (if (zap first) x (operand-to-sym x)))
            (unless (minusp funargs)
              (add (operand-to-sym y)))))))))

(defopcode-derived op-gapply gapply auto op-gcall)

(defopcode op-movrs movrs auto
  (:method asm (me asm syntax)
    me.(chk-arg-count 2 syntax)
    (tree-bind (dst src) asm.(parse-args me syntax '(d rs))
      asm.(put-insn me.code src dst)))

  (:method dis (me asm src dst)
    ^(,me.symbol ,(operand-to-sym dst) ,(operand-to-sym src))))

(defopcode op-movsr movsr auto
  (:method asm (me asm syntax)
    me.(chk-arg-count 2 syntax)
    (tree-bind (dst src) asm.(parse-args me syntax '(ds r))
      asm.(put-insn me.code dst src)))

  (:method dis (me asm dst src)
    ^(,me.symbol ,(operand-to-sym dst) ,(operand-to-sym src))))

(defopcode op-movrr movrr auto
  (:method asm (me asm syntax)
    me.(chk-arg-count 2 syntax)
    (tree-bind (dst src) asm.(parse-args me syntax '(d r))
      asm.(put-insn me.code 0 dst)
      asm.(put-pair 0 src)))

  (:method dis (me asm extension dst)
    (let ((src (cadr asm.(get-pair))))
      ^(,me.symbol ,(operand-to-sym dst) ,(operand-to-sym src)))))

(defopcode op-mov-pseudo mov nil
  (:method asm (me asm syntax)
    (tree-bind (dst src) asm.(parse-args me syntax '(d r))
      (let ((real [%oc-hash% (cond
                               ((< dst 1024) 'movsr)
                               ((< src 1024) 'movrs)
                               (t 'movrr))]))
        real.(asm asm syntax)))))

(defopcode op-movrsi movrsi auto
  (:method asm (me asm syntax)
    me.(chk-arg-count 2 syntax)
    (tree-bind (dst imm) asm.(parse-args me syntax '(d si))
      asm.(put-insn me.code (logtrunc (sys:bits imm) 10) dst)))

  (:method dis (me asm imm dst)
    ^(,me.symbol ,(operand-to-sym dst) ,(bits-to-obj imm 10))))

(defopcode op-movsmi movsmi auto
  (:method asm (me asm syntax)
    me.(chk-arg-count 2 syntax)
    (tree-bind (dst imm) asm.(parse-args me syntax '(ds mi))
      asm.(put-insn me.code dst (logtrunc (sys:bits imm) 16))))

  (:method dis (me asm dst imm )
    ^(,me.symbol ,(operand-to-sym dst) ,(bits-to-obj imm 16))))

(defopcode op-movrbi movrbi auto
  (:method asm (me asm syntax)
    me.(chk-arg-count 2 syntax)
    (tree-bind (dst imm) asm.(parse-args me syntax '(ds bi))
      asm.(put-insn me.code 0 dst)
      asm.(put-word (logtrunc (sys:bits imm) 32))))

  (:method dis (me asm extension dst)
    (let ((imm asm.(get-word)))
      ^(,me.symbol ,(operand-to-sym dst) ,(bits-to-obj imm 32)))))

(defopcode op-movi-pseudo movi nil
  (:method asm (me asm syntax)
    (tree-bind (dst src) asm.(parse-args me syntax '(d bi))
      (let ((real [%oc-hash% (cond
                               (asm.(immediate-fits-type src 'si) 'movrsi)
                               ((and asm.(immediate-fits-type src 'si)
                                     (< dst 1024)) 'movsmi)
                               (t 'movrbi))]))
        real.(asm asm syntax)))))

(defopcode op-jmp jmp auto
  (:method asm (me asm syntax)
    me.(chk-arg-count 1 syntax)
    (let ((dst (car asm.(parse-args me syntax '(l)))))
      asm.(put-insn me.code (ash dst -16) (logtrunc dst 16))))

  (:method backpatch (me asm at dst)
    asm.(put-insn me.code (ash dst -16) (logtrunc dst 16)))

  (:method dis (me asm high16 low16)
    ^(,me.symbol ,(logior (ash high16 16) low16))))

(defopcode op-if if auto
  (:method asm (me asm syntax)
    me.(chk-arg-count 2 syntax)
    (tree-bind (reg dst) asm.(parse-args me syntax '(r l))
      asm.(put-insn me.code (ash dst -16) (logtrunc dst 16))
      asm.(put-pair 0 reg)))

  (:method backpatch (me asm at dst)
    asm.(put-insn me.code (ash dst -16) (logtrunc dst 16)))

  (:method dis (me asm high16 low16)
    (let ((dst (logior (ash high16 16) low16))
          (reg (cadr asm.(get-pair))))
      ^(,me.symbol ,(operand-to-sym reg) ,dst))))

(defopcode op-ifq ifq auto
  (:method asm (me asm syntax)
    me.(chk-arg-count 3 syntax)
    (tree-bind (lreg rreg dst) asm.(parse-args me syntax '(r r l))
      asm.(put-insn me.code (ash dst -16) (logtrunc dst 16))
      asm.(put-pair lreg rreg)))

  (:method backpatch (me asm at dst)
    asm.(put-insn me.code (ash dst -16) (logtrunc dst 16)))

  (:method dis (me asm high16 low16)
    (let ((dst (logior (ash high16 16) low16)))
      (tree-bind (lreg rreg) asm.(get-pair)
      ^(,me.symbol ,(operand-to-sym lreg) ,(operand-to-sym rreg) ,dst)))))

(defopcode-derived op-ifql ifql auto op-ifq)

(defopcode-derived op-uwprot uwprot auto op-jmp)

(defopcode op-block block auto
  (:method asm (me asm syntax)
    me.(chk-arg-count 3 syntax)
    (tree-bind (outreg blname exitpt) asm.(parse-args me syntax '(d r l))
      asm.(put-insn me.code (ash exitpt -16) (logtrunc exitpt 16))
      asm.(put-pair outreg blname)))

  (:method backpatch (me asm at exitpt)
    asm.(put-insn me.code (ash exitpt -16) (logtrunc exitpt 16)))

 (:method dis (me asm high16 low16)
   (let ((exitpt (logior (ash high16 16) low16)))
     (tree-bind (outreg blname) asm.(get-pair)
       ^(,me.symbol ,(operand-to-sym outreg) ,(operand-to-sym blname)
                    ,exitpt)))))

(defopcode op-retsr retsr auto
  (:method asm (me asm syntax)
    me.(chk-arg-count 2 syntax)
    (tree-bind (name reg) asm.(parse-args me syntax '(rs r))
      asm.(put-insn me.code name reg)))

  (:method dis (me asm name reg)
    ^(,me.symbol ,(operand-to-sym name) ,(operand-to-sym reg))))

(defopcode op-retrs retrs auto
  (:method asm (me asm syntax)
    me.(chk-arg-count 2 syntax)
    (tree-bind (name reg) asm.(parse-args me syntax '(r rs))
      asm.(put-insn me.code reg name)))

  (:method dis (me asm reg name)
    ^(,me.symbol ,(operand-to-sym name) ,(operand-to-sym reg))))

(defopcode op-retrr retrr auto
  (:method asm (me asm syntax)
    me.(chk-arg-count 2 syntax)
    (tree-bind (name reg) asm.(parse-args me syntax '(r r))
      asm.(put-insn me.code 0 reg)
      asm.(put-pair 0 name)))

  (:method dis (me asm extension reg)
    (let ((name (cadr asm.(get-pair))))
      ^(,me.symbol ,(operand-to-sym name) ,(operand-to-sym reg)))))

(defopcode op-ret-pseudo ret nil
  (:method asm (me asm syntax)
    me.(chk-arg-count 2 syntax)
    (tree-bind (name reg) asm.(parse-args me syntax '(r r))
      (let ((real [%oc-hash% (cond
                               ((< name 1024) 'retsr)
                               ((< reg 1024) 'retrs)
                               (t 'retrr))]))
        real.(asm asm syntax)))))

(defopcode op-catch catch auto
  (:method asm (me asm syntax)
    me.(chk-arg-count 4 syntax)
    (tree-bind (sym args catch-syms dst) asm.(parse-args me syntax '(d d r l))
      asm.(put-insn me.code (ash dst -16) (logtrunc dst 16))
      asm.(put-pair sym args)
      asm.(put-pair 0 catch-syms)))

  (:method backpatch (me asm at dst)
    asm.(put-insn me.code (ash dst -16) (logtrunc dst 16)))

 (:method dis (me asm high16 low16)
   (let ((dst (logior (ash high16 16) low16)))
     (tree-bind (sym args) asm.(get-pair)
       (let ((catch-syms (cadr asm.(get-pair))))
         ^(,me.symbol ,(operand-to-sym sym) ,(operand-to-sym args)
                      ,(operand-to-sym catch-syms) ,dst))))))

(defopcode op-handle handle auto
  (:method asm (me asm syntax)
    me.(chk-arg-count 2 syntax)
    (tree-bind (fun handle-syms) asm.(parse-args me syntax '(r r))
      asm.(put-insn me.code 0 fun)
      asm.(put-pair fun handle-syms)))

 (:method dis (me asm extension fun)
     (let ((handle-syms (cadr asm.(get-pair))))
       ^(,me.symbol ,(operand-to-sym fun) ,(operand-to-sym handle-syms)))))

(defopcode op-getv getv auto
  (:method asm (me asm syntax)
    me.(chk-arg-count 2 syntax)
    (tree-bind (reg name) asm.(parse-args me syntax '(ds r))
      asm.(put-insn me.code reg name)))
  (:method dis (me asm reg name)
    ^(,me.symbol ,(operand-to-sym reg) ,(operand-to-sym name))))

(defopcode-derived op-getf getf auto op-getv)

(defopcode-derived op-getl1 getl1 auto op-getv)

(defopcode-derived op-getvb getvb auto op-getv)

(defopcode-derived op-getfb getfb auto op-getv)

(defopcode-derived op-getl1b getl1b auto op-getv)

(defopcode op-setv setv auto
  (:method asm (me asm syntax)
    me.(chk-arg-count 2 syntax)
    (tree-bind (reg name) asm.(parse-args me syntax '(rs r))
      asm.(put-insn me.code reg name)))
  (:method dis (me asm reg name)
    ^(,me.symbol ,(operand-to-sym reg) ,(operand-to-sym name))))

(defopcode-derived op-setl1 setl1 auto op-setv)

(defopcode-derived op-bindv bindv auto op-setv)

(defopcode op-close close auto
  (:method asm (me asm syntax)
    me.(chk-arg-count-min 6 syntax)
    (let* ((syn-pat (repeat '(d) (- (length syntax) 7))))
      (tree-bind (reg frsize dst fix req vari . regs)
                 asm.(parse-args me syntax ^(d n l n n o ,*syn-pat))
        (unless (<= 0 frsize 255)
          me.(synerr "frame size must be 0 to 255"))
        asm.(put-insn me.code (ash dst -16) (logtrunc dst 16))
        asm.(put-pair (logior (ash (if vari 1 0) 8) frsize) reg)
        asm.(put-pair req fix)
        (unless (eql fix (- (len regs) (if vari 1 0)))
          me.(synerr "wrong number of registers"))
        (while regs
          (let ((x (pop regs))
                (y (or (pop regs) 0)))
            asm.(put-pair y x))))))

  (:method backpatch (me asm at dst)
    asm.(put-insn me.code (ash dst -16) (logtrunc dst 16)))

  (:method dis (me asm high16 low16)
    (let ((dst (logior (ash high16 16) low16)))
      (tree-bind (vari-frsize reg) asm.(get-pair)
        (let ((vari (bit vari-frsize 8)))
          (tree-bind (req fix) asm.(get-pair)
            (build
              (add me.symbol (operand-to-sym reg) (logtrunc vari-frsize 8)
                   dst fix req vari)
              (when vari
                (inc fix))
              (while (> fix 0)
                (dec fix 2)
                (tree-bind (y x) asm.(get-pair)
                  (add (operand-to-sym x))
                  (unless (minusp fix)
                    (add (operand-to-sym y))))))))))))

(defun disassemble-c-d (code data funv *stdout*)
  (let ((asm (new assembler buf code)))
    (put-line "data:")
    (mapdo (do format t "  d~,02x: ~s\n" @1 @2) (range 0) data)
    (put-line "funs:")
    (mapdo (do format t "~5d: ~s\n" @1 @2) (range 0) funv)
    (put-line "code:")
    asm.(dis-listing)))

(defun usr:disassemble (obj : (stream *stdout*))
  (typecase obj
    (vm-desc (disassemble-c-d (vm-desc-bytecode obj)
                              (vm-desc-datavec obj)
                              (vm-desc-funvec obj)
                              stream))
    (t (error "~s: not a compiled object: ~s" 'vm-disassemble obj)))
  obj)