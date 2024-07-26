#lang scribble/rhombus/manual

@(import:
    meta_label:
      rhombus open
      esterel/kernel open)

@title{Rhombus Kernel Esterel Reference}

@docmodule(esterel/kernel)

The @rhombusmodname(esterel/kernel) Rhombus library is built on the Racket
@racketmodname(esterel/kernel) library.

@section(~tag: "rhombus-running-esterel-code"){Running Esterel Code}

@doc(
    expr.macro 'esterel:
                  $body'
    expr.macro 'esterel ~pre $pre:
                  $body'
){
    Returns a value that, when passes to @rhombus(react), will evaluate the @rhombus(body) in a context where @rhombus(in_esterel) returns @rhombus(#true).

    In the second form, the value of @rhombus(pre) is expected to be a natural number.
    It is a limit on the history that's saved for signals in previous instants.
    It defaults to @rhombus(0).
}

@doc(fun react(r, ~emit: signals = [])){
    Runs one instant of @rhombus(r).

    If @rhombus(signals) are supplied, they are emitted at the start of the instant; valued signals must be paired with values.

    The result has the values of the signals that were emitted.
    Additionally, if a signal is not a valued signal and the computation depends on it not being present (e.g., if it is pass to @rhombus(is_present)), it is included in the resulting hash, mapped to @rhombus(#false).

    If the code is not constructive, an exception is raised.
}

@doc(fun is_esterel(v)){
    Recognizes the result of @rhombus(esterel).
}

@doc(fun in_esterel()){
    Returns @rhombus(#true) if called within the dynamic extent of an expression in a @rhombus(esterel) form.
}

@doc(fun debug_when_must(stx)){
    Evaluates @rhombus(stx) when the entire @rhombus(debug_when_must) form must be executed.
    Raises an error if evaluated outside of an @rhombus(esterel) form.

    This can be used to debug Esterel in Racket programs.
    Sometimes, code inside @rhombus(esterel) is run as part of an exploration to determine if signal might be emitted and, in that case, we do not know that that code must run.
    In such situations, effectful code (such as @rhombus(printf)) can run multiple times, leading to confusing behavior.
    Wrapping such debugging IO operations in a @rhombus(debug_when_must) form can help to understand an Esterel in Racket program.
}

@section(~tag: "rhombus-signals"){Signals}

@doc(
    defn.macro 'def_signal [$(signal_definition :: SignalDefinition), ...]'

    expr.macro 'with_signal [$(signal_definition :: SignalDefinition), ...]:
                  $body'
){
    This is gonna be a nightmare.
}

@doc(fun is_signal(v)){
    Determines if @rhombus(v) is a signal, i.e. returned from @rhombus(signal).
}

@doc(fun signal_name(s)){
    Returns the name of the signal @rhombus(s).
}

@doc(fun signal_index(s)){
    Returns the index of signal @rhombus(s).
    This index counts the number of times the @rhombus(with_signal) that introduced @rhombus(s) has been executed to produce this particular signal.
    If @rhombus(s) was created outside the dynamic extent of @rhombus(esterel), @rhombus(signal_index) returns @rhombus(#false).
}

@doc(fun signal_combine(s)){
    Returns the combing operation for signal @rhombus(s) or @rhombus(#false) if @rhombus(s) is not a valued signal.
}

@doc(fun is_present(s, ~pre: pre = 0)){
    When @rhombus(pre) is @rhombus(0), returns @rhombus(#true) if @rhombus(s) is present in the current instant.

    If @rhombus(pre) is larger than @rhombus(0), returns whether or not @rhombus(s) was present in the @rhombus(pre)th previous instant.
    If @rhombus(pre) is larger than the value of @rhombus(pre) passed to @rhombus(esterel), an error is raised.
}

@doc(fun signal_value(s, ~pre: n = 0, ~can: can = Set())){
    If @rhombus(n) is @rhombus(0), returns the value of @rhombus(s) in the current instant, unless @rhombus(s) hasn't been emitted in the current instant.
    In that case, returns the value of @rhombus(s) in the previous instant.

    If @rhombus(n) is larger than @rhombus(0), returns the value of @rhombus(s) in the @rhombus(n)th previous instant.
    If @rhombus(n) is larger than the value of @rhombus(pre) passes to @rhombus(esterel), an error is raised.
    If the value has never been emitted and the signal's declaration did not have an @rhombus(~init) clause, an error is raised.

    The @rhombus(~can) argument indicates which signals can be emitted by the remaining computation and must be supplied if @rhombus(n) is @rhombus(0).
    That is, if it is possible that some signal can be emitted in the current instant after @rhombus(signal_value) returns, then that signal must be in the set @rhombus(can).
}

@doc(
    fun emit(s)
    fun emit(s, v)
){
    Emits @rhombus(s).
    If one argument is passed, then @rhombus(s) must not be a value-carrying signal.
    
    If two arguments are passed, then @rhombus(s) must be a value-carrying signal and the value @rhombus(v) is emitted.
}

@section(~tag: "rhombus-control-operations"){Control Operations}

@doc(expr.macro 'par
                 | $body
                 | ...'){
    Executes each @rhombus(body) in parallel, waiting for all of them to complete.
    The result is a set of all of the values of the @rhombus(body)s.
}

@doc(expr.macro '$left ||| $right'){
    Equivalent to @rhombus(par | left | right).

    Executes @rhombus(left) and @rhombus(right) in parallel, waiting for both to complete.
    The result is a set of the values of @rhombus(left) and @rhombus(right).
}

@doc(expr.macro 'pause'){
    Pauses the current thread.
    When all of the threads are paused (or canceled via @rhombus(exit_trap)), the instant is over.
    During the next instant, control picks up wherever the pause was.
}

@doc(expr.macro 'suspend:
                   $body
                   ~when $when'){
    When resuming from a @rhombus(pause) within @rhombus(body), suspends @rhombus(body) when @rhombus(when) returns a @rhombus(#true) value.
    In other words, if a @rhombus(pause) is encountered when evaluating @rhombus(body), upon resuming @rhombus(body), @rhombus(suspend) suspends @rhombus(body) if @rhombus(when) returns a @rhombus(#true) value.
    This suspension also affects any @rhombus(with_signal)s within (the dynamic extent of) @rhombus(when).
}

@doc(expr.macro 'with_trap $t:
                   $body'){
    Binds @rhombus(t) to a newly created trap and evaluates @rhombus(body).
    If the trap bound to @rhombus(t) is passed to @rhombus(exit_trap), the computation in the rest of @rhombus(body) is skipped and the result of @rhombus(with_trap) is the value passed to @rhombus(exit_trap).
}

@doc(fun exit_trap(t)){
    Exits to the trap @rhombus(t).
    Does not return.
}

@doc(fun is_trap(v)){
    Recognizes values bound by @rhombus(with_trap).
}
