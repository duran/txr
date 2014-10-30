" VIM Syntax file for txr
" Kaz Kylheku <kaz@kylheku.com>

" INSTALL-HOWTO:
"
" 1. Create the directory .vim/syntax in your home directory and
"    put the files txr.vim and txl.vim into this directory.
" 2. In your .vimrc, add this command to associate *.txr and *.tl
"    files with the txr and txl filetypes:
"    :au BufRead,BufNewFile *.txr set filetype=txr | set lisp
"    :au BufRead,BufNewFile *.tl set filetype=txl | set lisp
"
" If you want syntax highlighting to be on automatically (for any language)
" you need to add ":syntax on" in your .vimrc also. But you knew that already!
"
" This file is generated by the genvim.txr script in the TXR source tree.

syn case match
syn spell toplevel

setlocal iskeyword=a-z,A-Z,48-57,!,$,&,*,+,-,<,=,>,?,\\,_,~,/

syn keyword txl_keyword contained * *args* *e* *flo-dig*
syn keyword txl_keyword contained *flo-epsilon* *flo-max* *flo-min* *full-args*
syn keyword txl_keyword contained *gensym-counter* *keyword-package* *pi* *random-state*
syn keyword txl_keyword contained *self-path* *stddebug* *stderr* *stdin*
syn keyword txl_keyword contained *stdlog* *stdnull* *stdout* *txr-version*
syn keyword txl_keyword contained *user-package* + - /
syn keyword txl_keyword contained /= < <= =
syn keyword txl_keyword contained > >= abs abs-path-p
syn keyword txl_keyword contained acons acons-new aconsql-new acos
syn keyword txl_keyword contained ado alist-nremove alist-remove all
syn keyword txl_keyword contained and andf ap apf
syn keyword txl_keyword contained append append* append-each append-each*
syn keyword txl_keyword contained apply ash asin assoc
syn keyword txl_keyword contained assql atan atan2 atom
syn keyword txl_keyword contained bignump bit block boundp
syn keyword txl_keyword contained break-str call car caseq
syn keyword txl_keyword contained caseql casequal cat-str cat-vec
syn keyword txl_keyword contained catch cdr ceil chain
syn keyword txl_keyword contained chdir chr-isalnum chr-isalpha chr-isascii
syn keyword txl_keyword contained chr-isblank chr-iscntrl chr-isdigit chr-isgraph
syn keyword txl_keyword contained chr-islower chr-isprint chr-ispunct chr-isspace
syn keyword txl_keyword contained chr-isunisp chr-isupper chr-isxdigit chr-num
syn keyword txl_keyword contained chr-str chr-str-set chr-tolower chr-toupper
syn keyword txl_keyword contained chrp close-stream closelog cmp-str
syn keyword txl_keyword contained collect-each collect-each* comb compl-span-str
syn keyword txl_keyword contained cond cons conses conses*
syn keyword txl_keyword contained consp copy copy-alist copy-cons
syn keyword txl_keyword contained copy-hash copy-list copy-str copy-vec
syn keyword txl_keyword contained cos count-if countq countql
syn keyword txl_keyword contained countqual cum-norm-dist daemon dec
syn keyword txl_keyword contained defmacro defsymacro defun defvar
syn keyword txl_keyword contained del delay delete-package do
syn keyword txl_keyword contained dohash downcase-str dwim each
syn keyword txl_keyword contained each* empty env env-fbind
syn keyword txl_keyword contained env-hash env-vbind eq eql
syn keyword txl_keyword contained equal errno error eval
syn keyword txl_keyword contained evenp exit exp expt
syn keyword txl_keyword contained exptmod false fbind fboundp
syn keyword txl_keyword contained fifth filter-equal filter-string-tree find
syn keyword txl_keyword contained find-if find-max find-min find-package
syn keyword txl_keyword contained first fixnump flatten flatten*
syn keyword txl_keyword contained flet flip flo-int flo-str
syn keyword txl_keyword contained floatp floor flush-stream for
syn keyword txl_keyword contained for* force format fourth
syn keyword txl_keyword contained fun func-get-env func-get-form func-set-env
syn keyword txl_keyword contained functionp gcd gen generate
syn keyword txl_keyword contained gensym get-byte get-char get-hash-userdata
syn keyword txl_keyword contained get-line get-lines get-list-from-stream get-sig-handler
syn keyword txl_keyword contained get-string get-string-from-stream gethash getitimer
syn keyword txl_keyword contained getpid getppid giterate greater
syn keyword txl_keyword contained group-by gun hash hash-alist
syn keyword txl_keyword contained hash-construct hash-count hash-diff hash-eql
syn keyword txl_keyword contained hash-equal hash-isec hash-keys hash-pairs
syn keyword txl_keyword contained hash-uni hash-update hash-update-1 hash-values
syn keyword txl_keyword contained hashp html-decode html-encode iapply
syn keyword txl_keyword contained identity ido if iff
syn keyword txl_keyword contained iffi inc inhash int-flo
syn keyword txl_keyword contained int-str integerp intern interp-fun-p
syn keyword txl_keyword contained interpose ip ipf isqrt
syn keyword txl_keyword contained itimer-prov itimer-real itimer-virtual juxt
syn keyword txl_keyword contained keep-if keep-if* keywordp kill
syn keyword txl_keyword contained labels lambda last lazy-str
syn keyword txl_keyword contained lazy-str-force lazy-str-force-upto lazy-str-get-trailing-list lazy-stream-cons
syn keyword txl_keyword contained lazy-stringp lbind lcm lcons-fun
syn keyword txl_keyword contained lconsp ldiff length length-list
syn keyword txl_keyword contained length-str length-str-< length-str-<= length-str->
syn keyword txl_keyword contained length-str->= length-vec less let
syn keyword txl_keyword contained let* link lisp-parse list
syn keyword txl_keyword contained list* list-str list-vector listp
syn keyword txl_keyword contained log log-alert log-auth log-authpriv
syn keyword txl_keyword contained log-cons log-crit log-daemon log-debug
syn keyword txl_keyword contained log-emerg log-err log-info log-ndelay
syn keyword txl_keyword contained log-notice log-nowait log-odelay log-perror
syn keyword txl_keyword contained log-pid log-user log-warning log10
syn keyword txl_keyword contained log2 logand logior lognot
syn keyword txl_keyword contained logtest logtrunc logxor macro-form-p
syn keyword txl_keyword contained macro-time macroexpand macroexpand-1 macrolet
syn keyword txl_keyword contained major make-catenated-stream make-env make-hash
syn keyword txl_keyword contained make-lazy-cons make-like make-package make-random-state
syn keyword txl_keyword contained make-similar-hash make-string-byte-input-stream make-string-input-stream make-string-output-stream
syn keyword txl_keyword contained make-strlist-output-stream make-sym make-time make-time-utc
syn keyword txl_keyword contained make-trie makedev mapcar mapcar*
syn keyword txl_keyword contained mapdo maphash mappend mappend*
syn keyword txl_keyword contained mask match-fun match-regex match-regex-right
syn keyword txl_keyword contained match-str match-str-tree max member
syn keyword txl_keyword contained member-if memq memql memqual
syn keyword txl_keyword contained merge min minor mkdir
syn keyword txl_keyword contained mknod mkstring mod multi
syn keyword txl_keyword contained multi-sort n-choose-k n-perm-k nconc
syn keyword txl_keyword contained nilf none not notf
syn keyword txl_keyword contained nreverse null nullify num-chr
syn keyword txl_keyword contained num-str numberp oddp op
syn keyword txl_keyword contained open-command open-directory open-file open-files
syn keyword txl_keyword contained open-files* open-pipe open-process open-tail
syn keyword txl_keyword contained openlog or orf packagep
syn keyword txl_keyword contained partition partition* partition-by perm
syn keyword txl_keyword contained pop pos pos-if pos-max
syn keyword txl_keyword contained pos-min posq posql posqual
syn keyword txl_keyword contained pprinl pprint pprof prinl
syn keyword txl_keyword contained print prof prog1 progn
syn keyword txl_keyword contained prop proper-listp push pushhash
syn keyword txl_keyword contained put-byte put-char put-line put-lines
syn keyword txl_keyword contained put-string put-strings pwd qquote
syn keyword txl_keyword contained quasi quasilist quote rand
syn keyword txl_keyword contained random random-fixnum random-state-p range
syn keyword txl_keyword contained range* range-regex rcomb read
syn keyword txl_keyword contained readlink real-time-stream-p reduce-left reduce-right
syn keyword txl_keyword contained ref refset regex-compile regex-parse
syn keyword txl_keyword contained regexp regsub rehome-sym remhash
syn keyword txl_keyword contained remove-if remove-if* remove-path remq
syn keyword txl_keyword contained remq* remql remql* remqual
syn keyword txl_keyword contained remqual* rename-path repeat replace
syn keyword txl_keyword contained replace-list replace-str replace-vec rest
syn keyword txl_keyword contained ret retf return return-from
syn keyword txl_keyword contained reverse rlcp rperm rplaca
syn keyword txl_keyword contained rplacd run s-ifblk s-ifchr
syn keyword txl_keyword contained s-ifdir s-ififo s-iflnk s-ifmt
syn keyword txl_keyword contained s-ifreg s-ifsock s-irgrp s-iroth
syn keyword txl_keyword contained s-irusr s-irwxg s-irwxo s-irwxu
syn keyword txl_keyword contained s-isgid s-isuid s-isvtx s-iwgrp
syn keyword txl_keyword contained s-iwoth s-iwusr s-ixgrp s-ixoth
syn keyword txl_keyword contained s-ixusr search search-regex search-str
syn keyword txl_keyword contained search-str-tree second seek-stream select
syn keyword txl_keyword contained seqp set set-diff set-hash-userdata
syn keyword txl_keyword contained set-sig-handler sethash setitimer setlogmask
syn keyword txl_keyword contained sh sig-abrt sig-alrm sig-bus
syn keyword txl_keyword contained sig-check sig-chld sig-cont sig-fpe
syn keyword txl_keyword contained sig-hup sig-ill sig-int sig-io
syn keyword txl_keyword contained sig-iot sig-kill sig-lost sig-pipe
syn keyword txl_keyword contained sig-poll sig-prof sig-pwr sig-quit
syn keyword txl_keyword contained sig-segv sig-stkflt sig-stop sig-sys
syn keyword txl_keyword contained sig-term sig-trap sig-tstp sig-ttin
syn keyword txl_keyword contained sig-ttou sig-urg sig-usr1 sig-usr2
syn keyword txl_keyword contained sig-vtalrm sig-winch sig-xcpu sig-xfsz
syn keyword txl_keyword contained sin sixth size-vec some
syn keyword txl_keyword contained sort source-loc source-loc-str span-str
syn keyword txl_keyword contained splice split-str split-str-set sqrt
syn keyword txl_keyword contained stat stdlib str< str<=
syn keyword txl_keyword contained str= str> str>= stream-get-prop
syn keyword txl_keyword contained stream-set-prop streamp string-extend string-lt
syn keyword txl_keyword contained stringp sub sub-list sub-str
syn keyword txl_keyword contained sub-vec symacrolet symbol-function symbol-name
syn keyword txl_keyword contained symbol-package symbol-value symbolp symlink
syn keyword txl_keyword contained sys-qquote sys-splice sys-unquote syslog
syn keyword txl_keyword contained tan tf third throw
syn keyword txl_keyword contained throwf time time-fields-local time-fields-utc
syn keyword txl_keyword contained time-string-local time-string-utc time-usec tofloat
syn keyword txl_keyword contained toint tok-str tok-where tostring
syn keyword txl_keyword contained tostringp transpose tree-bind tree-case
syn keyword txl_keyword contained tree-find trie-add trie-compress trie-lookup-begin
syn keyword txl_keyword contained trie-lookup-feed-char trie-value-at trim-str true
syn keyword txl_keyword contained trunc tuples txr-case txr-if
syn keyword txl_keyword contained txr-when typeof unget-byte unget-char
syn keyword txl_keyword contained uniq unless unquote until
syn keyword txl_keyword contained upcase-str update url-decode url-encode
syn keyword txl_keyword contained usleep uw-protect vec vec-push
syn keyword txl_keyword contained vec-set-length vecref vector vector-list
syn keyword txl_keyword contained vectorp when where while
syn keyword txl_keyword contained with-saved-vars zerop zip

syn keyword txr_keyword contained accept all and assert
syn keyword txr_keyword contained bind block cases cat
syn keyword txr_keyword contained catch choose chr close
syn keyword txr_keyword contained coll collect defex deffilter
syn keyword txr_keyword contained define do elif else
syn keyword txr_keyword contained end eof eol fail
syn keyword txr_keyword contained filter finally flatten forget
syn keyword txr_keyword contained freeform fuzz gather if
syn keyword txr_keyword contained include last line load
syn keyword txr_keyword contained local maybe merge next
syn keyword txr_keyword contained none or output rebind
syn keyword txr_keyword contained rep repeat require set
syn keyword txr_keyword contained skip some text throw
syn keyword txr_keyword contained trailer try until var
syn match txr_error "@[\t ]*[*]\?[\t ]*."
syn match txr_atat "@[ \t]*@"
syn match txr_comment "@[ \t]*[#;].*"
syn match txr_contin "@[ \t]*\\$"
syn match txr_char "@[ \t]*\\."
syn match txr_char "@[ \t]*\\x[0-9A-Fa-f]\+"
syn match txr_char "@[ \t]*\\[0-9]\+"
syn match txr_variable "@[ \t]*[*]\?[ \t]*[A-Za-z_][A-Za-z0-9_]*"
syn match txr_splicevar "@[ \t,*]*[A-Za-z_][A-Za-z0-9_]*"
syn match txr_regdir "@[ \t]*/\(\\/\|[^/]\|\\\n\)*/"
syn match txr_hashbang "^#!.*"
syn match txr_metanum "@[0-9]\+"
syn match txr_nested_error "[^\t `]\+" contained

syn match txr_chr "#\\x[A-Fa-f0-9]\+" contained
syn match txr_chr "#\\o[0-9]\+" contained
syn match txr_chr "#\\[^ \t\nA-Za-z0-9_]" contained
syn match txr_chr "#\\[A-Za-z0-9_]\+" contained
syn match txr_ncomment ";.*" contained

syn match txr_dot "\." contained
syn match txr_num "#x[+\-]\?[0-9A-Fa-f]\+" contained
syn match txr_num "#o[+\-]\?[0-7]\+" contained
syn match txr_num "#b[+\-]\?[0-1]\+" contained
syn match txr_ident "[A-Za-z0-9!$%&*+\-<=>?\\_~]*[A-Za-z!$#%&*+\-<=>?\\^_~][A-Za-z0-9!$#%&*+\-<=>?\\^_~]*" contained
syn match txl_ident "[:@][A-Za-z0-9!$%&*+\-<=>?\\\^_~/]\+" contained
syn match txl_ident "[A-Za-z0-9!$%&*+\-<=>?\\_~/]*[A-Za-z!$#%&*+\-<=>?\\^_~/][A-Za-z0-9!$#%&*+\-<=>?\\^_~/]*" contained
syn match txr_num "[+\-]\?[0-9]\+\([^A-Za-z0-9!$#%&*+\-<=>?\\^_~/]\|\n\)"me=e-1 contained
syn match txr_badnum "[+\-]\?[0-9]*[.][0-9]\+\([eE][+\-]\?[0-9]\+\)\?[A-Za-z!$#%&*+\-<=>?\\^_~/]\+" contained
syn match txr_num "[+\-]\?[0-9]*[.][0-9]\+\([eE][+\-]\?[0-9]\+\)\?\([^A-Za-z0-9!$#%&*+\-<=>?\\^_~/]\|\n\)"me=e-1 contained
syn match txr_num "[+\-]\?[0-9]\+\([eE][+\-]\?[0-9]\+\)\([^A-Za-z0-9!$#%&*+\-<=>?\\^_~/]\|\n\)"me=e-1 contained
syn match txl_ident ":" contained
syn match txl_splice "[ \t,]\|,[*]" contained

syn match txr_unquote "," contained
syn match txr_splice ",\*" contained
syn match txr_quote "'" contained
syn match txr_quote "\^" contained
syn match txr_dotdot "\.\." contained
syn match txr_metaat "@" contained

syn region txr_bracevar matchgroup=Delimiter start="@[ \t]*[*]\?{" matchgroup=Delimiter end="}" contains=txr_num,txr_ident,txr_string,txr_list,txr_bracket,txr_mlist,txr_mbracket,txr_regex,txr_quasilit,txr_chr,txl_splice,txr_nested_error
syn region txr_directive matchgroup=Delimiter start="@[ \t]*(" matchgroup=Delimiter end=")" contains=txr_keyword,txr_string,txr_list,txr_bracket,txr_mlist,txr_mbracket,txr_quasilit,txr_num,txr_badnum,txl_ident,txl_regex,txr_string,txr_chr,txr_quote,txr_unquote,txr_splice,txr_dot,txr_dotdot,txr_metaat,txr_ncomment,txr_nested_error
syn region txr_list contained matchgroup=Delimiter start="#\?H\?(" matchgroup=Delimiter end=")" contains=txl_keyword,txr_string,txl_regex,txr_num,txr_badnum,txl_ident,txr_metanum,txr_list,txr_bracket,txr_mlist,txr_mbracket,txr_quasilit,txr_chr,txr_quote,txr_unquote,txr_splice,txr_dot,txr_dotdot,txr_metaat,txr_ncomment,txr_nested_error
syn region txr_bracket contained matchgroup=Delimiter start="\[" matchgroup=Delimiter end="\]" contains=txl_keyword,txr_string,txl_regex,txr_num,txr_badnum,txl_ident,txr_metanum,txr_list,txr_bracket,txr_mlist,txr_mbracket,txr_quasilit,txr_chr,txr_quote,txr_unquote,txr_splice,txr_dot,txr_dotdot,txr_metaat,txr_ncomment,txr_nested_error
syn region txr_mlist contained matchgroup=Delimiter start="@[ \t]*(" matchgroup=Delimiter end=")" contains=txl_keyword,txr_string,txl_regex,txr_num,txr_badnum,txl_ident,txr_metanum,txr_list,txr_bracket,txr_mlist,txr_mbracket,txr_quasilit,txr_chr,txr_quote,txr_unquote,txr_splice,txr_dot,txr_dotdot,txr_metaat,txr_ncomment,txr_nested_error
syn region txr_mbracket matchgroup=Delimiter start="@[ \t]*\[" matchgroup=Delimiter end="\]" contains=txl_keyword,txr_string,txl_regex,txr_num,txr_badnum,txl_ident,txr_metanum,txr_list,txr_bracket,txr_mlist,txr_mbracket,txr_quasilit,txr_chr,txr_quote,txr_unquote,txr_splice,txr_dot,txr_dotdot,txr_metaat,txr_ncomment,txr_nested_error
syn region txr_string contained start=+#\?\*\?"+ skip=+\\\\\|\\"\|\\\n+ end=+"\|\n+
syn region txr_quasilit contained start=+#\?\*\?`+ skip=+\\\\\|\\`\|\\\n+ end=+`\|\n+ contains=txr_splicevar,txr_metanum,txr_bracevar,txr_mlist,txr_mbracket
syn region txr_regex contained start="/" skip="\\\\\|\\/\|\\\n" end="/\|\n"
syn region txl_regex contained start="#/" skip="\\\\\|\\/\|\\\n" end="/\|\n"

hi def link txr_at Special
hi def link txr_atstar Special
hi def link txr_atat Special
hi def link txr_comment Comment
hi def link txr_ncomment Comment
hi def link txr_hashbang Preproc
hi def link txr_contin Preproc
hi def link txr_char String
hi def link txr_keyword Keyword
hi def link txl_keyword Type
hi def link txr_string String
hi def link txr_chr String
hi def link txr_quasilit String
hi def link txr_regex String
hi def link txl_regex String
hi def link txr_regdir String
hi def link txr_variable Identifier
hi def link txr_splicevar Identifier
hi def link txr_metanum Identifier
hi def link txr_ident Identifier
hi def link txl_ident Identifier
hi def link txr_num Number
hi def link txr_badnum Error
hi def link txr_quote Special
hi def link txr_unquote Special
hi def link txr_splice Special
hi def link txr_dot Special
hi def link txr_dotdot Special
hi def link txr_metaat Special
hi def link txr_munqspl Special
hi def link txl_splice Special
hi def link txr_error Error
hi def link txr_nested_error Error

let b:current_syntax = "lisp"
