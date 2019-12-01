import 'dart:io';
import 'dart:convert';

main(List<String> arguments) async {
  var file = File('./bin/day01/input.b.txt');
  var lines;

  if (await file.exists()) {
    lines = LineSplitter().convert(await file.readAsString());

    print('Fuel: ${fuel(lines, 0)}');
  }
}

int fuel(List<String> list, int quantity) {
  if (list.isNotEmpty) {
    var q  = (double.parse(list[0]) / 3.0).floor() - 2;
    var qq = (q > 0 ? fuel(List.from([q.toString()]), 0) : 0);

    return fuel(
      list.getRange(1, list.length).toList(), 
      q  + quantity + (qq > 0 ? qq : 0) 
    );
  }

  return quantity;
}