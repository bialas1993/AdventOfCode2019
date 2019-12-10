import 'dart:math';

const INSTRUCTION_ADD = '01';
const INSTRUCTION_MULTIPLE = '02';
const INSTRUCTION_INPUT = '03';
const INSTRUCTION_OUTPUT = '04';
const INSTRUCTION_JUMP_TRUE = '05';
const INSTRUCTION_JUMP_FALSE = '06';
const INSTRUCTION_LESS = '07';
const INSTRUCTION_EQUAL = '08';
const INSTRUCTION_ADJUST_RELATIVE_BASE = '09';
const INSTRUCTION_EXIT = '99';

const MODE_POSITION = '0';
const MODE_IMMEDIATE = '1';
const MODE_RELATIVE = '2';

class Memory {
  final Map<int, int> _data = {};

  int operator [](int pos) => _data[pos] ?? 0;
  void operator []=(int pos, int value) => _data[pos] = value;

  Memory(Iterable<int> input) {
    var i = 0;
    for (final value in input) {
      this[i++] = value;
    }
  }

  Memory.clone(Memory memory) {
    _data.addAll(memory._data);
  }

  List<int> toList() {
    final maxKey = _data.keys.reduce(max) + 1;
    final result = List<int>(maxKey);

    for (var i = 0; i < maxKey; i++) {
      result[i] = this[i];
    }

    return result;
  }
}

class IntcodeComputer {
  final Memory memory;
  int relativeBase = 0;
  bool isRunning = true;

  IntcodeComputer(Memory memory) : this.memory = Memory.clone(memory);
  IntcodeComputer.fromString(String input) : this.memory = parse(input);

  static Memory parse(String input) => Memory(input.split(',').map(int.parse));

  void computeWithoutOutput() {
    for (final _ in compute()) {
      // Empty since we just want to throw the output away
    }
  }

  Iterable<int> compute([List<int> input = const []]) sync* {
    var pos = 0;

    while (!memory[pos].toString().endsWith(INSTRUCTION_EXIT)) {
      final parameter = memory[pos++].toString().padLeft(5, '0');
      final mode1 = parameter[2];
      final mode2 = parameter[1];
      final mode3 = parameter[0];
      final opCode = parameter.substring(3);

      switch (opCode) {
        case INSTRUCTION_ADD:
          final in1 = _getValueInterpreted(pos++, mode1);
          final in2 = _getValueInterpreted(pos++, mode2);
          final dest = _getValueLiteral(pos++, mode3);

          memory[dest] = in1 + in2;
          break;
        case INSTRUCTION_MULTIPLE:
          final in1 = _getValueInterpreted(pos++, mode1);
          final in2 = _getValueInterpreted(pos++, mode2);
          final dest = _getValueLiteral(pos++, mode3);

          memory[dest] = in1 * in2;
          break;
        case INSTRUCTION_INPUT:
          final val1 = _getValueLiteral(pos++, mode1);

          memory[val1] = input.removeAt(0);
          break;
        case INSTRUCTION_OUTPUT:
          final val1 = _getValueInterpreted(pos++, mode1);

          yield val1;
          break;
        case INSTRUCTION_JUMP_TRUE:
          final val1 = _getValueInterpreted(pos++, mode1);
          final val2 = _getValueInterpreted(pos++, mode2);

          if (val1 != 0) pos = val2;
          break;
        case INSTRUCTION_JUMP_FALSE:
          final val1 = _getValueInterpreted(pos++, mode1);
          final val2 = _getValueInterpreted(pos++, mode2);

          if (val1 == 0) pos = val2;
          break;
        case INSTRUCTION_LESS:
          final val1 = _getValueInterpreted(pos++, mode1);
          final val2 = _getValueInterpreted(pos++, mode2);
          final val3 = _getValueLiteral(pos++, mode3);

          memory[val3] = val1 < val2 ? 1 : 0;
          break;
        case INSTRUCTION_EQUAL: 
          final val1 = _getValueInterpreted(pos++, mode1);
          final val2 = _getValueInterpreted(pos++, mode2);
          final val3 = _getValueLiteral(pos++, mode3);

          memory[val3] = val1 == val2 ? 1 : 0;
          break;
        case INSTRUCTION_ADJUST_RELATIVE_BASE:
          final val1 = _getValueInterpreted(pos++, mode1);
          relativeBase += val1;
          break;
        default:
          throw Exception('OpCode $opCode is not supported');
      }
    }

    isRunning = false;
  }

  int _getValueInterpreted(int pos, String mode) {
    switch (mode) {
      case MODE_POSITION:
        return memory[memory[pos]];
        break;
      case MODE_IMMEDIATE:
        return memory[pos];
        break;
      case MODE_RELATIVE:
        return memory[memory[pos] + relativeBase];
      default:
        throw Exception('Mode $mode is not supported!');
    }
  }

  int _getValueLiteral(int pos, String mode) {
    switch (mode) {
      case MODE_POSITION:
      case MODE_IMMEDIATE:
        return memory[pos];
        break;
      case MODE_RELATIVE:
        return memory[pos] + relativeBase;
      default:
        throw Exception('Mode $mode is not supported!');
    }
  }
}