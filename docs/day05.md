\-\-- Day 5: Sunny with a Chance of Asteroids \-\--
---------------------------------------------------

You\'re starting to sweat as the ship makes its way toward Mercury. The
Elves suggest that you get the air conditioner working by upgrading your
ship computer to support the Thermal Environment Supervision Terminal.

The Thermal Environment Supervision Terminal (TEST) starts by running a
*diagnostic program* (your puzzle input). The TEST diagnostic program
will run on [your existing Intcode computer] after a few modifications:

*First*, you\'ll need to add *two new instructions*:

-   Opcode `3` takes a single integer as *input* and saves it to the
    position given by its only parameter. For example, the instruction
    `3,50` would take an input value and store it at address `50`.
-   Opcode `4` *outputs* the value of its only parameter. For example,
    the instruction `4,50` would output the value at address `50`.

Programs that use these instructions will come with documentation that
explains what should be connected to the input and output. The program
`3,0,4,0,99` outputs whatever it gets as input, then halts.

*Second*, you\'ll need to add support for *parameter modes*:

Each parameter of an instruction is handled based on its parameter mode.
Right now, your ship computer already understands parameter mode `0`,
*position mode*, which causes the parameter to be interpreted as a
*position* - if the parameter is `50`, its value is *the value stored at
address `50` in memory*. Until now, all parameters have been in position
mode.

Now, your ship computer will also need to handle parameters in mode `1`,
*immediate mode*. In immediate mode, a parameter is interpreted as a
*value* - if the parameter is `50`, its value is simply *`50`*.

Parameter modes are stored in the same value as the instruction\'s
opcode. The opcode is a two-digit number based only on the ones and tens
digit of the value, that is, the opcode is the rightmost two digits of
the first value in an instruction. Parameter modes are single digits,
one per parameter, read right-to-left from the opcode: the first
parameter\'s mode is in the hundreds digit, the second parameter\'s mode
is in the thousands digit, the third parameter\'s mode is in the
ten-thousands digit, and so on. Any missing modes are `0`.

For example, consider the program `1002,4,3,4,33`.

The first instruction, `1002,4,3,4`, is a *multiply* instruction - the
rightmost two digits of the first value, `02`, indicate opcode `2`,
multiplication. Then, going right to left, the parameter modes are `0`
(hundreds digit), `1` (thousands digit), and [your existing Intcode computer]: 2

\-\-- Part Two \-\-- {#part2}
--------------------

The air conditioner comes online! Its cold air feels good for a while,
but then the TEST alarms start to go off. Since the air conditioner
[can\'t vent its heat
anywhere]{title="Honestly, I'm not sure what you expected."} but back
into the spacecraft, it\'s actually making the air inside the ship
*warmer*.

Instead, you\'ll need to use the TEST to extend the [thermal radiators].
Fortunately, the diagnostic program (your puzzle input) is already
equipped for this. Unfortunately, your Intcode computer is not.

Your computer is only missing a few opcodes:

-   Opcode `5` is *jump-if-true*: if the first parameter is *non-zero*,
    it sets the instruction pointer to the value from the second
    parameter. Otherwise, it does nothing.
-   Opcode `6` is *jump-if-false*: if the first parameter *is zero*, it
    sets the instruction pointer to the value from the second parameter.
    Otherwise, it does nothing.
-   Opcode `7` is *less than*: if the first parameter is *less than* the
    second parameter, it stores `1` in the position given by the third
    parameter. Otherwise, it stores `0`.
-   Opcode `8` is *equals*: if the first parameter is *equal to* the
    second parameter, it stores `1` in the position given by the third
    parameter. Otherwise, it stores `0`.

Like all instructions, these instructions need to support *parameter
modes* as described above.

Normally, after an instruction is finished, the instruction pointer
increases by the number of values in that instruction. *However*, if the
instruction modifies the instruction pointer, that value is used and the
instruction pointer is *not automatically increased*.

For example, here are several programs that take one input, compare it
to the value `8`, and then produce one output:

-   `3,9,8,9,10,9,4,9,99,-1,8` - Using *position mode*, consider whether
    the input is *equal to* `8`; output `1` (if it is) or `0` (if it is
    not).
-   `3,9,7,9,10,9,4,9,99,-1,8` - Using *position mode*, consider whether
    the input is *less than* `8`; output `1` (if it is) or `0` (if it is
    not).
-   `3,3,1108,-1,8,3,4,3,99` - Using *immediate mode*, consider whether
    the input is *equal to* `8`; output `1` (if it is) or `0` (if it is
    not).
-   `3,3,1107,-1,8,3,4,3,99` - Using *immediate mode*, consider whether
    the input is *less than* `8`; output `1` (if it is) or `0` (if it is
    not).

Here are some jump [thermal radiators]: https://en.wikipedia.org/wiki/Spacecraft_thermal_control
