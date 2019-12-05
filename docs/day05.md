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