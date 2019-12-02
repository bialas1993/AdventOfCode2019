\-\-- Day 2: 1202 Program Alarm \-\--
-------------------------------------

On the way to your [gravity assist] around the Moon, your ship computer
beeps angrily about a \"[1202 program alarm]\". On the radio, an Elf is
already explaining how to handle the situation: \"Don\'t worry, that\'s
perfectly norma\--\" The ship computer [bursts into flames].

You notify the Elves that the computer\'s [magic smoke] seems to have
[escaped]{title="Looks like SOMEONE forgot to change the switch to 'more magic'."}.
\"That computer ran *Intcode* programs like the gravity assist program
it was working on; surely there are enough spare parts up there to build
a new Intcode computer!\"

An Intcode program is a list of [integers] separated by commas (like
`1,0,0,3,99`). To run one, start by looking at the first integer (called
position `0`). Here, you will find an *opcode* - either `1`, `2`, or
`99`. The opcode indicates what to do; for example, `99` means that the
program is finished and should immediately halt. Encountering an unknown
opcode means something went wrong.

Opcode `1` *adds* together numbers read from two positions and stores
the result in a third position. The three integers *immediately after*
the opcode tell you these three positions - the first two indicate the
*positions* from which you should read the input values, and the third
indicates the *position* at which the output should be stored.

For example, if your Intcode computer encounters `1,10,20,30`, it should
read the values at positions `10` and `20`, add those values, and then
overwrite the value at position `30` with their sum.

Opcode `2` works exactly like opcode `1`, except it *multiplies* the two
inputs instead of adding them. Again, the three integers after the
opcode indicate *where* the inputs and outputs are, not their values.

Once you\'re done processing an opcode, *move to the next one* by
stepping forward `4` positions.

For example, suppose you have the following program:

    1,9,10,3,2,3,11,0,99,30,40,50

For the purposes of illustration, here is the same program split into
multiple lines:

    1,9,10,3,
    2,3,11,0,
    99,
    30,40,50

The first four integers, `1,9,10,3`, are at positions `0`, `1`, `2`, and
`3`. Together, they represent the first opcode (`1`, addition), the
positions of the two inputs (`9` and 1

  [gravity assist]: https://en.wikipedia.org/wiki/Gravity_assist
  [1202 program alarm]: https://www.hq.nasa.gov/alsj/a11/a11.landing.html#1023832
  [bursts into flames]: https://en.wikipedia.org/wiki/Halt_and_Catch_Fire
  [magic smoke]: https://en.wikipedia.org/wiki/Magic_smoke
  [integers]: https://en.wikipedia.org/wiki/Integer