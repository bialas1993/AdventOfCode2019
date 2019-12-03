import 'dart:io';
import 'day02a.dart';

const RESULT = 19690720;

List<int> stack;

main(List<String> arguments) async {
  var file = File('./bin/day02/input.b.txt');

  if (await file.exists()) {
    stack = List<int>.from((await file.readAsString()).toString().split(',').map((f) => int.parse(f)));
    List<int> stackCopy = []..addAll(stack);

    for(var noun=0; noun<100; noun++) {
      for(var verb=0; verb<100; verb++) {
        stack = []..addAll(stackCopy);
        stack[1] = noun;
        stack[2] = verb;

        if (execute(stack) == RESULT) {
          print('noun: $noun, varb: $verb, result: ${100 * noun + verb}');
          exit(1);
        }
      }
    }

    return;
  }

  throw("Can not read input file.");
}