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
syn keyword txl_keyword contained apply aret ash asin
syn keyword txl_keyword contained assoc assql atan atan2
syn keyword txl_keyword contained atom bignump bit block
syn keyword txl_keyword contained boundp break-str call car
syn keyword txl_keyword contained caseq caseql casequal cat-str
syn keyword txl_keyword contained cat-streams cat-vec catch cdr
syn keyword txl_keyword contained ceil chain chand chdir
syn keyword txl_keyword contained chr-isalnum chr-isalpha chr-isascii chr-isblank
syn keyword txl_keyword contained chr-iscntrl chr-isdigit chr-isgraph chr-islower
syn keyword txl_keyword contained chr-isprint chr-ispunct chr-isspace chr-isunisp
syn keyword txl_keyword contained chr-isupper chr-isxdigit chr-num chr-str
syn keyword txl_keyword contained chr-str-set chr-tolower chr-toupper chrp
syn keyword txl_keyword contained close-stream closelog cmp-str collect-each
syn keyword txl_keyword contained collect-each* comb compl-span-str cond
syn keyword txl_keyword contained cons conses conses* consp
syn keyword txl_keyword contained copy copy-alist copy-cons copy-hash
syn keyword txl_keyword contained copy-list copy-str copy-vec cos
syn keyword txl_keyword contained count-if countq countql countqual
syn keyword txl_keyword contained cum-norm-dist daemon dec defmacro
syn keyword txl_keyword contained defsymacro defun defvar del
syn keyword txl_keyword contained delay delete-package do dohash
syn keyword txl_keyword contained downcase-str dwim each each*
syn keyword txl_keyword contained empty env env-fbind env-hash
syn keyword txl_keyword contained env-vbind eq eql equal
syn keyword txl_keyword contained errno error eval evenp
syn keyword txl_keyword contained exit exp expt exptmod
syn keyword txl_keyword contained false fbind fboundp fifth
syn keyword txl_keyword contained filter-equal filter-string-tree finalize find
syn keyword txl_keyword contained find-if find-max find-min find-package
syn keyword txl_keyword contained first fixnump flatten flatten*
syn keyword txl_keyword contained flet flip flo-int flo-str
syn keyword txl_keyword contained floatp floor flush-stream for
syn keyword txl_keyword contained for* force format fourth
syn keyword txl_keyword contained fun func-get-env func-get-form func-set-env
syn keyword txl_keyword contained functionp gcd gen generate
syn keyword txl_keyword contained gensym gequal get-byte get-char
syn keyword txl_keyword contained get-hash-userdata get-line get-lines get-list-from-stream
syn keyword txl_keyword contained get-sig-handler get-string get-string-from-stream gethash
syn keyword txl_keyword contained getitimer getpid getppid giterate
syn keyword txl_keyword contained glob glob-altdirfunc glob-brace glob-err
syn keyword txl_keyword contained glob-mark glob-nocheck glob-noescape glob-nomagic
syn keyword txl_keyword contained glob-nosort glob-onlydir glob-period glob-tilde
syn keyword txl_keyword contained glob-tilde-check greater group-by gun
syn keyword txl_keyword contained hash hash-alist hash-construct hash-count
syn keyword txl_keyword contained hash-diff hash-eql hash-equal hash-isec
syn keyword txl_keyword contained hash-keys hash-pairs hash-uni hash-update
syn keyword txl_keyword contained hash-update-1 hash-values hashp html-decode
syn keyword txl_keyword contained html-encode iapply identity ido
syn keyword txl_keyword contained if iff iffi in
syn keyword txl_keyword contained inc inhash int-flo int-str
syn keyword txl_keyword contained integerp intern interp-fun-p interpose
syn keyword txl_keyword contained ip ipf isqrt itimer-prov
syn keyword txl_keyword contained itimer-real itimer-virtual juxt keep-if
syn keyword txl_keyword contained keep-if* keywordp kill labels
syn keyword txl_keyword contained lambda last lazy-str lazy-str-force
syn keyword txl_keyword contained lazy-str-force-upto lazy-str-get-trailing-list lazy-stream-cons lazy-stringp
syn keyword txl_keyword contained lbind lcm lcons-fun lconsp
syn keyword txl_keyword contained ldiff length length-list length-str
syn keyword txl_keyword contained length-str-< length-str-<= length-str-> length-str->=
syn keyword txl_keyword contained length-vec lequal less let
syn keyword txl_keyword contained let* lexical-fun-p lexical-var-p link
syn keyword txl_keyword contained lisp-parse list list* list-str
syn keyword txl_keyword contained list-vector listp log log-alert
syn keyword txl_keyword contained log-auth log-authpriv log-cons log-crit
syn keyword txl_keyword contained log-daemon log-debug log-emerg log-err
syn keyword txl_keyword contained log-info log-ndelay log-notice log-nowait
syn keyword txl_keyword contained log-odelay log-perror log-pid log-user
syn keyword txl_keyword contained log-warning log10 log2 logand
syn keyword txl_keyword contained logior lognot logtest logtrunc
syn keyword txl_keyword contained logxor macro-form-p macro-time macroexpand
syn keyword txl_keyword contained macroexpand-1 macrolet major make-catenated-stream
syn keyword txl_keyword contained make-env make-hash make-lazy-cons make-like
syn keyword txl_keyword contained make-package make-random-state make-similar-hash make-string-byte-input-stream
syn keyword txl_keyword contained make-string-input-stream make-string-output-stream make-strlist-output-stream make-sym
syn keyword txl_keyword contained make-time make-time-utc make-trie makedev
syn keyword txl_keyword contained mapcar mapcar* mapdo maphash
syn keyword txl_keyword contained mappend mappend* mask match-fun
syn keyword txl_keyword contained match-regex match-regex-right match-str match-str-tree
syn keyword txl_keyword contained max member member-if memq
syn keyword txl_keyword contained memql memqual merge min
syn keyword txl_keyword contained minor minusp mkdir mknod
syn keyword txl_keyword contained mkstring mod multi multi-sort
syn keyword txl_keyword contained n-choose-k n-perm-k nconc nilf
syn keyword txl_keyword contained none not notf nreverse
syn keyword txl_keyword contained null nullify num-chr num-str
syn keyword txl_keyword contained numberp oand oddp op
syn keyword txl_keyword contained open-command open-directory open-file open-files
syn keyword txl_keyword contained open-files* open-pipe open-process open-tail
syn keyword txl_keyword contained openlog opip or orf
syn keyword txl_keyword contained packagep partition partition* partition-by
syn keyword txl_keyword contained perm plusp pop pos
syn keyword txl_keyword contained pos-if pos-max pos-min posq
syn keyword txl_keyword contained posql posqual pppred ppred
syn keyword txl_keyword contained pprinl pprint pprof pred
syn keyword txl_keyword contained prinl print prof prog1
syn keyword txl_keyword contained progn prop proper-listp push
syn keyword txl_keyword contained pushhash put-byte put-char put-line
syn keyword txl_keyword contained put-lines put-string put-strings pwd
syn keyword txl_keyword contained qquote quasi quasilist quote
syn keyword txl_keyword contained rand random random-fixnum random-state-p
syn keyword txl_keyword contained range range* range-regex rcomb
syn keyword txl_keyword contained read readlink real-time-stream-p reduce-left
syn keyword txl_keyword contained reduce-right ref refset regex-compile
syn keyword txl_keyword contained regex-parse regexp regsub rehome-sym
syn keyword txl_keyword contained remhash remove-if remove-if* remove-path
syn keyword txl_keyword contained remq remq* remql remql*
syn keyword txl_keyword contained remqual remqual* rename-path repeat
syn keyword txl_keyword contained replace replace-list replace-str replace-vec
syn keyword txl_keyword contained rest ret retf return
syn keyword txl_keyword contained return-from reverse rlcp rperm
syn keyword txl_keyword contained rplaca rplacd run s-ifblk
syn keyword txl_keyword contained s-ifchr s-ifdir s-ififo s-iflnk
syn keyword txl_keyword contained s-ifmt s-ifreg s-ifsock s-irgrp
syn keyword txl_keyword contained s-iroth s-irusr s-irwxg s-irwxo
syn keyword txl_keyword contained s-irwxu s-isgid s-isuid s-isvtx
syn keyword txl_keyword contained s-iwgrp s-iwoth s-iwusr s-ixgrp
syn keyword txl_keyword contained s-ixoth s-ixusr search search-regex
syn keyword txl_keyword contained search-str search-str-tree second seek-stream
syn keyword txl_keyword contained select seqp set set-diff
syn keyword txl_keyword contained set-hash-userdata set-sig-handler sethash setitimer
syn keyword txl_keyword contained setlogmask sh sig-abrt sig-alrm
syn keyword txl_keyword contained sig-bus sig-check sig-chld sig-cont
syn keyword txl_keyword contained sig-fpe sig-hup sig-ill sig-int
syn keyword txl_keyword contained sig-io sig-iot sig-kill sig-lost
syn keyword txl_keyword contained sig-pipe sig-poll sig-prof sig-pwr
syn keyword txl_keyword contained sig-quit sig-segv sig-stkflt sig-stop
syn keyword txl_keyword contained sig-sys sig-term sig-trap sig-tstp
syn keyword txl_keyword contained sig-ttin sig-ttou sig-urg sig-usr1
syn keyword txl_keyword contained sig-usr2 sig-vtalrm sig-winch sig-xcpu
syn keyword txl_keyword contained sig-xfsz sin sixth size-vec
syn keyword txl_keyword contained some sort sort-group source-loc
syn keyword txl_keyword contained source-loc-str span-str splice split-str
syn keyword txl_keyword contained split-str-set sqrt sssucc ssucc
syn keyword txl_keyword contained stat stdlib str< str<=
syn keyword txl_keyword contained str= str> str>= stream-get-prop
syn keyword txl_keyword contained stream-set-prop streamp string-extend string-lt
syn keyword txl_keyword contained stringp sub sub-list sub-str
syn keyword txl_keyword contained sub-vec succ symacrolet symbol-function
syn keyword txl_keyword contained symbol-name symbol-package symbol-value symbolp
syn keyword txl_keyword contained symlink sys-qquote sys-splice sys-unquote
syn keyword txl_keyword contained syslog tan tb tc
syn keyword txl_keyword contained tf third throw throwf
syn keyword txl_keyword contained time time-fields-local time-fields-utc time-string-local
syn keyword txl_keyword contained time-string-utc time-usec tofloat toint
syn keyword txl_keyword contained tok-str tok-where tostring tostringp
syn keyword txl_keyword contained transpose tree-bind tree-case tree-find
syn keyword txl_keyword contained trie-add trie-compress trie-lookup-begin trie-lookup-feed-char
syn keyword txl_keyword contained trie-value-at trim-str true trunc
syn keyword txl_keyword contained tuples txr-case txr-if txr-when
syn keyword txl_keyword contained typeof unget-byte unget-char uniq
syn keyword txl_keyword contained unique unless unquote until
syn keyword txl_keyword contained upcase-str update url-decode url-encode
syn keyword txl_keyword contained usleep uw-protect vec vec-push
syn keyword txl_keyword contained vec-set-length vecref vector vector-list
syn keyword txl_keyword contained vectorp when where while
syn keyword txl_keyword contained with-saved-vars wrap wrap* zerop
syn keyword txl_keyword contained zip
syn match txr_metanum "@[0-9]\+"
syn match txr_nested_error "[^\t `]\+" contained

syn match txr_chr "#\\x[A-Fa-f0-9]\+"
syn match txr_chr "#\\o[0-9]\+"
syn match txr_chr "#\\[^ \t\nA-Za-z0-9_]"
syn match txr_chr "#\\[A-Za-z0-9_]\+"
syn match txr_ncomment ";.*"

syn match txr_dot "\." contained
syn match txr_num "#x[+\-]\?[0-9A-Fa-f]\+"
syn match txr_num "#o[+\-]\?[0-7]\+"
syn match txr_num "#b[+\-]\?[0-1]\+"
syn match txr_ident "[A-Za-z0-9!$%&*+\-<=>?\\_~]*[A-Za-z!$#%&*+\-<=>?\\^_~][A-Za-z0-9!$#%&*+\-<=>?\\^_~]*" contained
syn match txl_ident "[:@][A-Za-z0-9!$%&*+\-<=>?\\\^_~/]\+"
syn match txr_braced_ident "[:][A-Za-z0-9!$%&*+\-<=>?\\\^_~/]\+" contained
syn match txl_ident "[A-Za-z0-9!$%&*+\-<=>?\\_~/]*[A-Za-z!$#%&*+\-<=>?\\^_~/][A-Za-z0-9!$#%&*+\-<=>?\\^_~/]*"
syn match txr_num "[+\-]\?[0-9]\+\([^A-Za-z0-9!$#%&*+\-<=>?\\^_~/]\|\n\)"me=e-1
syn match txr_badnum "[+\-]\?[0-9]*[.][0-9]\+\([eE][+\-]\?[0-9]\+\)\?[A-Za-z!$#%&*+\-<=>?\\^_~/]\+"
syn match txr_num "[+\-]\?[0-9]*[.][0-9]\+\([eE][+\-]\?[0-9]\+\)\?\([^A-Za-z0-9!$#%&*+\-<=>?\\^_~/]\|\n\)"me=e-1
syn match txr_num "[+\-]\?[0-9]\+\([eE][+\-]\?[0-9]\+\)\([^A-Za-z0-9!$#%&*+\-<=>?\\^_~/]\|\n\)"me=e-1
syn match txl_ident ":"
syn match txl_splice "[ \t,]\|,[*]"

syn match txr_unquote "," contained
syn match txr_splice ",\*" contained
syn match txr_quote "'" contained
syn match txr_quote "\^" contained
syn match txr_dotdot "\.\." contained
syn match txr_metaat "@" contained

syn region txr_list matchgroup=Delimiter start="#\?H\?(" matchgroup=Delimiter end=")" contains=txl_keyword,txr_string,txl_regex,txr_num,txr_badnum,txl_ident,txr_metanum,txr_list,txr_bracket,txr_mlist,txr_mbracket,txr_quasilit,txr_chr,txr_quote,txr_unquote,txr_splice,txr_dot,txr_dotdot,txr_metaat,txr_ncomment,txr_nested_error
syn region txr_bracket matchgroup=Delimiter start="\[" matchgroup=Delimiter end="\]" contains=txl_keyword,txr_string,txl_regex,txr_num,txr_badnum,txl_ident,txr_metanum,txr_list,txr_bracket,txr_mlist,txr_mbracket,txr_quasilit,txr_chr,txr_quote,txr_unquote,txr_splice,txr_dot,txr_dotdot,txr_metaat,txr_ncomment,txr_nested_error
syn region txr_mlist matchgroup=Delimiter start="@[ \t]*(" matchgroup=Delimiter end=")" contains=txl_keyword,txr_string,txl_regex,txr_num,txr_badnum,txl_ident,txr_metanum,txr_list,txr_bracket,txr_mlist,txr_mbracket,txr_quasilit,txr_chr,txr_quote,txr_unquote,txr_splice,txr_dot,txr_dotdot,txr_metaat,txr_ncomment,txr_nested_error
syn region txr_mbracket matchgroup=Delimiter start="@[ \t]*\[" matchgroup=Delimiter end="\]" contains=txl_keyword,txr_string,txl_regex,txr_num,txr_badnum,txl_ident,txr_metanum,txr_list,txr_bracket,txr_mlist,txr_mbracket,txr_quasilit,txr_chr,txr_quote,txr_unquote,txr_splice,txr_dot,txr_dotdot,txr_metaat,txr_ncomment,txr_nested_error
syn region txr_string start=+#\?\*\?"+ skip=+\\\\\|\\"\|\\\n+ end=+"\|\n+
syn region txr_quasilit start=+#\?\*\?`+ skip=+\\\\\|\\`\|\\\n+ end=+`\|\n+ contains=txr_splicevar,txr_metanum,txr_bracevar,txr_mlist,txr_mbracket
syn region txr_regex start="/" skip="\\\\\|\\/\|\\\n" end="/\|\n"
syn region txl_regex start="#/" skip="\\\\\|\\/\|\\\n" end="/\|\n"

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
