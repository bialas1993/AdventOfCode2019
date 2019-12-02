import 'dart:io';
import 'dart:convert';

const CODE_EXIT = 99;
const CODE_ADD = 1;
const CODE_MULTIPLE = 2;
// const CODE_EXIT = 99;

List<int> stack;

main(List<String> arguments) async {
  var file = File('./bin/day02/input.a.txt');

  if (await file.exists()) {
    List<int> instructions = List<int>.from((await file.readAsString()).toString().split(',').map((f) => int.parse(f)));

    // 4bit instruction [add, index first data, in]dex secod data, output index]

    print(instructions);

    return;
  }

  throw("Can not read input file.");
}

void execute(int opcode, int i1, int i2, int output) {
  switch (opcode) {
    case CODE_ADD:
    {}
    break;
  }
}
