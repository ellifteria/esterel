#lang scribble/rhombus/manual

@(import:
    meta_label:
      rhombus open
      esterel/kernel open)

@title{Rhombus Kernel Esterel}

@docmodule(esterel/kernel)

The @rhombusmodname(esterel/kernel) Rhombus library is built on the Racket
@racketmodname(esterel/kernel) library.

@doc(
    defn.macro 'def_signal [$(signal_definition :: SignalDefinition), ...]'

    expr.macro 'with_signal [$(signal_definition :: SignalDefinition), ...]:
                $body':

    @;{I have absolutely no idea how to document syntax classes.}
)

@doc(
    expr.macro 'esterel:
        $body'
    | 'esterel ~pre $pre:
        $body'
)

@doc(operator ¿ x)

@doc(expr.macro '$left ||| $right':)

@doc(expr.macro 'par
            | $body
            | ...':)

@doc(
    fun emit(s)
    fun emit(s, v)
)

@doc(fun react(r, ~emit: signals = []))

@doc(expr.macro 'with_trap $t:
              $body':)

@doc(exit_trap(t))

@doc(expr.macro pause)

@doc(fun signal_name(s))

@doc(fun signal_index(s))

@doc(fun is_esterel(v))

@doc(fun in_esterel())

@doc(fun signal_value(s, ~pre: n = 0, ~can: can = Set()))

@doc(expr.macro 'suspend:
              $body
              ~when $when')

@doc(fun is_trap(v))

@doc(fun is_present(s, ~pre: pre = 0))

@doc(fun signal_combine(s))

@doc(fun debug_when_must(stx))

@doc(fun is_signal(v))
