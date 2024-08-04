#lang scribble/rhombus/manual

@(import:
    meta_label:
      rhombus open
      esterel/full open)

@title{Rhombus Esterel Reference}

@docmodule(esterel/full)

The @rhombusmodname(esterel/full) Rhombus library is built on the Racket @racketmodname(esterel/full) library.
As in the Racket @racketmodname(esterel/full) library, it provides all of the names documented here as well as the names documented in @rhombusmodname(esterel/kernel).

@(def esterel_full_eval = make_rhombus_eval())

@examples(
    ~eval: esterel_full_eval
    ~hidden:
      import:
        esterel/full open
)

@doc(fun halt()){
Pauses in every instant, forever.
}

@doc(
    fun sustain(s)
    fun sustain(s, v)
){
Emits @rhombus(s) and pauses in every instant, forever.

As with @rhombus(emit), if @rhombus(s) is a valued signal,
two arguments must be supplied and if @rhombus(s) is not a
valued signal, two arguments may not be supplied.

@examples(
  ~eval: esterel_full_eval
  def_signal [S, T ~combine (fun (x, y): x + y)]
  def strl:
    esterel:
      sustain(S) ||| sustain(T, 8)   
  ~check:
    react(strl)
    ~is {S: #true, T: 8}
  ~check:
    react(strl)
    ~is {S: #true, T: 8}
  ~check:
    react(strl)
    ~is {S: #true, T: 8}
    )
}

@doc(
    expr.macro 'loop:
                  $body
                  ...
                  ~each $restart'
    expr.macro 'loop:
                  $body'
){
In the first form, runs @rhombus(body) over and over.
In the second form, starts by running @rhombus(body) and then @rhombus(halt)ing.
Restarts @rhombus(body) when @rhombus(restart) becomes true.

@examples(
  ~eval: esterel_full_eval
  def_signal [S1, S2]
  def strl:
    esterel:
      loop:
        emit(S1)
        ~each !is_present(S2)

  ~check:
    react(strl)
    ~is {S1: #true}
)
}


@doc(
    expr.macro 'abort:
                  $body ...
                  ~when $when ...'
    expr.macro 'abort ~weak:
                  $body ...
                  ~when $when ...'
    expr.macro 'abort ~weak:
                  $body ...
                  ~when_immediate $when ...'
){
Terminates when @rhombus(body) terminates or when @rhombus(when) returns a true value. If @rhombus(~weak) is present, the @rhombus(body)s are executed when @rhombus(when) is true; they are skipped if @rhombus(~weak) is not present.
If @rhombus(~when) is used, the @rhombus(body)s are executed at least once and the @rhombus(abort) runs for at least one instant; if @rhombus(~when_immediate) is used, the @rhombus(when) is tested in the first instant and the expression terminates in the first instant if @rhombus(when) returns a true value.
}


@doc(
    expr.macro 'await $when ...'
    expr.macro 'await $when ... ~n $n ...'
    expr.macro 'await ~immediate $when ...'
){
In the first form, @rhombus(pause)s until @rhombus(when) returns a true value, but at least one instant.
In the second form, @rhombus(pause) until @rhombus(when) returns a true value @rhombus(~n) times.
In the third form, the value of @rhombus(when) is tested in the first instant, and thus the @rhombus(await) might terminate immediately.
}

@doc(
    expr.macro 'every $s ...:
                  $body'
    expr.macro 'every $s ... ~n $n ...:
                  $body'
    expr.macro 'every ~immediate $s ...:
                  $body'
){
In the first form, @rhombus(await)s @rhombus(s) evaluating to a true value and then starts running the @rhombus(body); when whenever @rhombus(s) becomes true, restarts @rhombus(body).
The second form is similar to the first, except that it waits for @rhombus(s) to be true @rhombus(n) times before restarting @rhombus(body).
In the third form, if @rhombus(s) evaluates to a true value in the current instant, the @rhombus(body) is evaluated in the current instant.

For example, this program emits @rhombus(S2) whenever @rhombus(S1) is present.
@examples(
  ~eval: esterel_full_eval
  def_signal [S1, S2]
  def strl:
    esterel:
      every is_present(S1):
        emit(S2)
  ~check:
    react(strl, ~emit: [S1])
    ~is {S1: #true}
  ~check:
    react(strl, ~emit: [S1])
    ~is {S1: #true, S2: #true}
  ~check:
    react(strl, ~emit: [S1])
    ~is {S1: #true, S2: #true}
  ~check:
    react(strl)
    ~is {S1: #false}
  ~check:
    react(strl, ~emit: [S1])
    ~is {S1: #true, S2: #true}
  ~check:
    react(strl, ~emit: [S1])
    ~is {S1: #true, S2: #true}
)
}

@doc(reducer.macro '|||'){
A reducer used with @rhombus(for), passes values to @rhombus(par).

@examples(
  ~eval: esterel_full_eval
  def_signal [x, y, z]
  def signal_list: [x, y, z]
  def strl:
    esterel:
      for ||| (i: 0..3):
        emit(signal_list[i])
  react(strl)
)
}
