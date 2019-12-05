import 'dart:io';

const INSTRUCTION_ADD = '01';
const INSTRUCTION_MULTIPLE = '02';
const INSTRUCTION_INPUT = '03';
const INSTRUCTION_OUTPUT = '04';
const INSTRUCTION_JUMP_TRUE = '05';
const INSTRUCTION_JUMP_FALSE = '06';
const INSTRUCTION_LESS = '07';
const INSTRUCTION_EQUAL = '08';
const INSTRUCTION_EXIT = '99';

const MODE_POSITION = '0';
const MODE_IMMEDIATE = '1';

int run(List<int> memory, List<int> input) {
  int pointer = 0;

  while (!memory[pointer].toString().endsWith(INSTRUCTION_EXIT)) {
    final param = memory[pointer++].toString().padLeft(5, '0');
    final mode1 = param[2];
    final mode2 = param[1];

    final opCode = param.substring(3);

    switch (opCode) {
      case INSTRUCTION_ADD:
        final in1 = val(memory, pointer++, mode1);
        final in2 = val(memory, pointer++, mode2);
        final dest = val(memory, pointer++, MODE_IMMEDIATE);

        memory[dest] = in1 + in2;
        break;
      case INSTRUCTION_MULTIPLE: 
        final in1 = val(memory, pointer++, mode1);
        final in2 = val(memory, pointer++, mode2);
        final dest = val(memory, pointer++, MODE_IMMEDIATE);

        memory[dest] = in1 * in2;
        break;
      case INSTRUCTION_INPUT: // input:
        final in1 = val(memory, pointer++, MODE_IMMEDIATE);

        memory[in1] = input.removeAt(0);
        break;
      case INSTRUCTION_OUTPUT: // output
        final in1 = val(memory, pointer++, mode1);

        if (in1 != 0) {
          return in1;
        }
        break;
      case INSTRUCTION_JUMP_TRUE: // jump-if-true
        final in1 = val(memory, pointer++, mode1);
        final in2 = val(memory, pointer++, mode2);

        if (in1 != 0) pointer = in2;
        break;
      case INSTRUCTION_JUMP_FALSE:
        final in1 = val(memory, pointer++, mode1);
        final in2 = val(memory, pointer++, mode2);

        if (in1 == 0) pointer = in2;
        break;
      case INSTRUCTION_LESS: 
        final in1 = val(memory, pointer++, mode1);
        final in2 = val(memory, pointer++, mode2);
        final dest = val(memory, pointer++, MODE_IMMEDIATE);

        memory[dest] = in1 < in2 ? 1 : 0;
        break;
      case INSTRUCTION_EQUAL:
        final in1 = val(memory, pointer++, mode1);
        final in2 = val(memory, pointer++, mode2);
        final dest = val(memory, pointer++, MODE_IMMEDIATE);

        memory[dest] = in1 == in2 ? 1 : 0;
        break;
      default:
        throw Exception('OpCode $opCode is not supported');
    }
  }
}

int val(List<int> memory, int pointer, String mode) {
  switch (mode) {
    case MODE_IMMEDIATE:
      return memory[pointer];
    case MODE_POSITION:
      return memory[memory[pointer]];
    default:
      throw Exception('Mode $mode is not supported!');
  }
}

main(List<String> arguments) async {
  var file = File('./bin/day05/input.txt');

  if (await file.exists()) {
    final memoryA = (await file.readAsString()).split(',').map(int.parse).toList(growable: false);;
    final memoryB = List<int>.from([]..addAll(memoryA));

    print('Solution 1: ${run(memoryA, [1])}');
    print('Solution 2: ${run(memoryB, [5])}');
    return;
  }

  throw("Can not read input file.");
}