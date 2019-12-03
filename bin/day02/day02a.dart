import 'dart:io';

const CODE_EXIT = 99;
const CODE_ADD = 1;
const CODE_MULTIPLE = 2;

List<int> stack;

main(List<String> arguments) async {
  var file = File('./bin/day02/input.a.txt');

  if (await file.exists()) {
    stack = List<int>.from((await file.readAsString()).toString().split(',').map((f) => int.parse(f)));
    //before crash
    stack[1] = 12;
    stack[2] = 2;

    print('Solution: ${execute(stack)}');
    
    return;
  }

  throw("Can not read input file.");
}

int execute(List<int> stack) {
  for (var i=0; i < stack.length; i=i+4) {
    switch (stack[i]) {
      case CODE_ADD:
      {
        stack[stack[i+3]] = stack[stack[i+1]] + stack[stack[i+2]];
      }
      break;
      case CODE_MULTIPLE:
      {
        stack[stack[i+3]] = stack[stack[i+1]] * stack[stack[i+2]];
      }
      break;
      case CODE_EXIT:
      {
        return stack[0];
      }
    }
  }

  return 0;
}
