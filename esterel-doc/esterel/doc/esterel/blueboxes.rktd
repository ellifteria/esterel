3042
((3) 0 () 5 ((q lib "esterel/kernel.rhm") (q lib "esterel/kernel.rkt") (q lib "esterel/full.rkt") (q lib "esterel/full.rhm") (q 3925 . 7)) () (h ! (equal) ((c def c (c (? . 1) q react!)) q (94 . 12)) ((c def c (c (? . 2) q halt)) q (3008 . 2)) ((c def c (c (? . 0) q esterel)) q (3720 . 8)) ((c def c (c (? . 0) q \|\|\|)) q (4392 . 3)) ((c def c (c (? . 0) q def_signal rhombus/defn)) c (? . 4)) ((c def c (c (? . 1) q make-global-signal)) q (1241 . 9)) ((c def c (c (? . 0) q react)) q (3783 . 3)) ((c def c (c (? . 1) q signal?)) q (1631 . 3)) ((c def c (c (? . 0) q signal_name)) q (4104 . 3)) ((c form c (c (? . 1) q with-trap)) q (2361 . 2)) ((c def c (c (? . 0) q par)) q (4361 . 5)) ((c def c (c (? . 0) q is_esterel)) q (3832 . 3)) ((c def c (c (? . 0) q is_trap)) q (4548 . 3)) ((c def c (c (? . 1) q in-esterel?)) q (704 . 2)) ((c def c (c (? . 1) q signal-value)) q (2023 . 5)) ((c def c (c (? . 1) q present?)) q (1926 . 4)) ((c form c (c (? . 1) q define-signal)) q (1205 . 2)) ((c form c (c (? . 1) q exec)) q (2540 . 16)) ((c form c (c (? . 2) q for/par)) q (3595 . 2)) ((c def c (c (? . 1) q exn:fail:not-constructive?)) q (742 . 3)) ((c form c (c (? . 1) q suspend)) q (2322 . 2)) ((c def c (c (? . 3) q abort)) q (4719 . 15)) ((c form c (c (? . 1) q par)) q (2269 . 2)) ((c def c (c (? . 0) q is_present)) q (4198 . 3)) ((c def c (c (? . 0) q signal_combine)) q (4165 . 3)) ((c form c (c (? . 1) q with-signal)) q (852 . 11)) ((c def c (c (? . 1) q trap?)) q (2489 . 3)) ((c form c (c (? . 2) q loop)) q (3107 . 3)) ((c def c (c (? . 0) q signal_value)) q (4246 . 3)) ((c form c (c (? . 2) q for*/par)) q (3657 . 2)) ((c def c (c (? . 0) q signal_index)) q (4134 . 3)) ((c def c (c (? . 1) q signal-name)) q (1684 . 3)) ((c def c (c (? . 3) q loop)) q (4646 . 10)) ((c def c (c (? . 1) q pause)) q (2293 . 2)) ((c def c (c (? . 3) q every)) q (4984 . 12)) ((c form c (c (? . 2) q await)) q (3346 . 4)) ((c def c (c (? . 3) q \|\|\| rhombus/reducer)) q (5100 . 3)) ((c def c (c (? . 3) q sustain)) q (4596 . 6)) ((c def c (c (? . 0) q with_signal)) c (? . 4)) ((c def c (c (? . 1) q signal-combine)) q (1835 . 3)) ((c form c (c (? . 2) q every)) q (3436 . 4)) ((c form c (c (? . 1) q esterel)) q (0 . 5)) ((c def c (c (? . 1) q exit-trap)) q (2405 . 4)) ((c form c (c (? . 2) q abort)) q (3181 . 4)) ((c def c (c (? . 1) q signal-index)) q (1763 . 3)) ((c def c (c (? . 1) q esterel?)) q (650 . 3)) ((c def c (c (? . 0) q in_esterel)) q (3861 . 3)) ((c def c (c (? . 0) q is_signal)) q (4076 . 3)) ((c def c (c (? . 0) q with_trap)) q (4485 . 4)) ((c def c (c (? . 0) q pause)) q (4421 . 3)) ((c form c (c (? . 1) q debug-when-must)) q (814 . 2)) ((c def c (c (? . 3) q await)) q (4889 . 9)) ((c def c (c (? . 0) q debug_when_must)) q (3889 . 3)) ((c def c (c (? . 0) q exit_trap)) q (4520 . 3)) ((c def c (c (? . 0) q suspend)) q (4439 . 5)) ((c def c (c (? . 0) q emit)) q (4317 . 6)) ((c def c (c (? . 1) q emit)) q (2158 . 6)) ((c def c (c (? . 3) q halt)) q (4574 . 3)) ((c def c (c (? . 2) q sustain)) q (3036 . 4))))
syntax
(esterel maybe-pre expr ...)
 
maybe-pre = 
          | #:pre pre-count-expr
procedure
(react! r [#:emit signals])
 -> (hash/dc [s signal?]
             [v (s) (if (signal-combine s)
                        any/c
                        boolean?)]
             #:immutable #t #:kind 'flat)
  r : esterel?
  signals : (listof                                       = '()
             (or/c (and/c signal? (not/c signal-combine))
                   (cons/c (and/c signal? signal-combine)
                           any/c)))
procedure
(esterel? v) -> boolean?
  v : any/c
procedure
(in-esterel?) -> boolean?
procedure
(exn:fail:not-constructive? v) -> boolean?
  v : any/c
syntax
(debug-when-must e1 e2 ...)
syntax
(with-signal (signal ...)
  body-expr ...+)
 
       signal = signal-id maybe-combine
                 
maybe-combine = 
              | #:combine combine-expr
              | #:init init-expr #:combine combine-expr
              | #:memoryless #:init init-expr #:combine combine-expr
              | #:single
syntax
(define-signal signal ...)
procedure
(make-global-signal  name                          
                    [#:combine combine]            
                     #:init init                   
                    [#:memoryless memoryless]) -> signal?
  name : string?
  combine : #f = (or/c #f (procedure-arity-includes/c 2))
  init : any/c
  memoryless : #f = boolean?
procedure
(signal? v) -> boolean?
  v : any/c
procedure
(signal-name s) -> (and/c string? immutable?)
  s : signal?
procedure
(signal-index s) -> (or/c #f natural?)
  s : signal?
procedure
(signal-combine s) -> (or/c #f (-> any/c any/c any/c))
  s : signal?
procedure
(present? s [#:pre pre]) -> boolean?
  s : signal?
  pre : natural? = 0
procedure
(signal-value s [#:pre n] #:can can) -> any/c
  s : signal?
  n : natural? = 0
  can : (setof signal?)
procedure
(emit s) -> void?
  s : (signal?)
(emit s v) -> void?
  s : (signal?)
  v : any/c
syntax
(par expr ...)
procedure
(pause) -> void?
syntax
(suspend body-expr when-expr)
syntax
(with-trap trap-id body-expr ...)
procedure
(exit-trap t [v]) -> any/c
  t : trap?
  v : any/c = (void)
procedure
(trap? v) -> boolean?
  v : any/c
syntax
(exec esterel-id
      ([id id-expr] ...)
      exec-expr ...
      maybe-kill-exprs
      maybe-suspend-exprs
      maybe-resume-exprs)
 
   maybe-kill-exprs = 
                    | #:kill kill-expr ...
                       
maybe-suspend-exprs = 
                    | #:suspend suspend-expr ...
                       
 maybe-resume-exprs = 
                    | #:resume resume-expr ...
procedure
(halt) -> any/c
procedure
(sustain s v) -> any/c
  s : signal?
  v : any/c
syntax
(loop body-expr ...+)
(loop body-expr ...+ #:each test-expr)
syntax
(abort body-expr ...+ #:when when-expr)
(abort #:weak body-expr ...+ #:when when-expr)
(abort #:weak body-expr ...+ #:when-immediate when-expr)
syntax
(await when-expr)
(await when-expr #:n n-expr)
(await #:immediate when-expr)
syntax
(every test-expr #:do body-expr ...+)
(every test-expr #:n n-expr #:do body-expr ...+)
(every #:immediate test-expr #:do body-expr ...+)
syntax
(for/par (for-clause ...) body-or-break ... body)
syntax
(for*/par (for-clause ...) body-or-break ... body)
expression

esterel:
  body
 

esterel ~pre pre:
  body
function

fun react(r, ~emit: signals = [])
function

fun is_esterel(v)
function

fun in_esterel()
function

fun debug_when_must(stx)
definition

def_signal [(signal_definition :: SignalDefinition), ...]
 

with_signal [(signal_definition :: SignalDefinition), ...]:
  body
function

fun is_signal(v)
function

fun signal_name(s)
function

fun signal_index(s)
function

fun signal_combine(s)
function

fun is_present(s, ~pre: pre = 0)
function

fun signal_value(s, ~pre: n = 0, ~can: can = Set())
function

fun emit(s)
 

fun emit(s, v)
expression

par
| body
| ...
expression

left ||| right
expression

pause
expression

suspend:
  body
  ~when when
expression

with_trap t:
  body
function

fun exit_trap(t)
function

fun is_trap(v)
function

fun halt()
function

fun sustain(s)
 

fun sustain(s, v)
expression

loop:
  body
  ...
  ~each restart
 

loop:
  body
expression

abort:
  body ...
  ~when when ...
 

abort ~weak:
  body ...
  ~when when ...
 

abort ~weak:
  body ...
  ~when_immediate when ...
expression

await when ...
 

await when ... ~n n ...
 

await ~immediate when ...
expression

every s ...:
  body
 

every s ... ~n n ...:
  body
 

every ~immediate s ...:
  body
reducer

|||
