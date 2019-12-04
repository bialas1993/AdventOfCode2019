import 'dart:io';

main(List<String> arguments) async {

  solutionA('245182-790572');
  solutionB('245182-790572');
}

solutionA (String input) {
  var range = input.split('-').map(int.parse).toList();
  var maches = 0;
  print('Range: $range');

  for (var i=range[0]; i <= range[1]; i++) {
    if (validate(i.toString())) {
      maches++;
    }
  }

  print('Part 1 Maches: $maches');
}

solutionB (String input) {
  var range = input.split('-').map(int.parse).toList();
  var maches = 0;
  print('Range: $range');

  for (var i=range[0]; i <= range[1]; i++) {
    if (isIncreasing(i.toString()) && isAdjacentDouble(i.toString())) {
      maches++;
    }
  }

  print('Part 2 Maches: $maches');
}

bool isIncreasing(String s) {
  var lastChar = s[0].codeUnitAt(0);

  for (var i=1; i<s.length; i++) {
      var char = s[i].codeUnitAt(0);

      if (!(lastChar <= char)) {
        return false;
      }

      lastChar = char;
  }

  return true;
}

bool isAdjacentDouble(String s) {
  int seq = 1;
  for (var l = 1; l < s.length; l++) {
    if (s[l] == s[l - 1]) {
      seq++;
    } else if (seq == 2) {
      return true;
    } else {
      seq = 1;
    }
  }

  return seq == 2;
}

bool validate(String s) {
  var lastChar = s[0].codeUnitAt(0);
  var doubleNum = false;

  for (var i=1; i<s.length; i++) {
      var char = s[i].codeUnitAt(0);

      if (lastChar <= char) {
        if (lastChar == char) {
          doubleNum = true;
        }
      } else {
        return false;
      }

      lastChar = char;
  }

  return doubleNum;
}