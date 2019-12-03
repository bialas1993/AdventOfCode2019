import 'dart:collection';
import 'dart:io';

SplayTreeMap board = SplayTreeMap<int, String>(); 

main(List<String> arguments) async {
  var file = File('./bin/day03/sample.txt');

  if (await file.exists()) {
    List<String> moves = List<String>.from((await file.readAsString()).toString().split(','));

    print(moves);

    return;
  }

  throw("Can not read input file.");
}

void draw(List<String> moves) {


}