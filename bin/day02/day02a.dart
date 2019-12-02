import 'dart:io';

const CODE_EXIT = 99;
const CODE_ADD = 1;
const CODE_MULTIPLE = 2;

List<int> stack;

main(List<String> arguments) async {
  var file = File('./bin/day02/input.a.txt');

  if (await file.exists()) {
    stack = List<int>.from((await file.readAsString()).toString().split(',').map((f) => int.parse(f)));

    // 4bit instruction [add, index first data, index secod data, output index]

    //before crash
    stack[1] = 12;
    stack[2] = 2;
    //

    for (var i=0; i < stack.length; i=i+4) {
      print('operation: ${stack[i]} ; val: ${stack[i+1]}, ${stack[i+2]}, out: ${stack[i+3]}');
      print("----");
      execute(stack[i], stack[i+1], stack[i+2], stack[i+3]);
    }

    return;
  }

  throw("Can not read input file.");
}

void execute(int opcode, int i1, int i2, int output) {
  switch (opcode) {
    case CODE_ADD:
    {
      stack[output] = stack[i1] + stack[i2];
    }
    break;
    case CODE_MULTIPLE:
    {
      stack[output] = stack[i1] * stack[i2];
    }
    break;
    case CODE_EXIT:
    {
      print('First element: ${stack[0]}');
      print(stack);
      exit(1);
    }
    break;
  }
}
