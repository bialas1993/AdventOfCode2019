import 'dart:io';
import 'dart:convert';

main(List<String> arguments) async {
  var file = File('./bin/day01/input.a.txt');
  var lines;

  if (await file.exists()) {
    lines = LineSplitter().convert(await file.readAsString());

    print('Fuel: ${fuel(lines, 0)}');
  }
}

int fuel(List<String> list, int quantity) {
  if (list.isNotEmpty) {
    return fuel(
      list.getRange(1, list.length).toList(), 
      (double.parse(list[0]) / 3.0).floor() - 2  + quantity
    );
  }

  return quantity;
}