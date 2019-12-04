main(List<String> arguments) async {
  var input = '245182-790572';
  var range = input.split('-').map(int.parse).toList();
  var maches = 0;
  print('Range: $range');

  for (var i=range[0]; i <= range[1]; i++) {
    if (validate(i)) {
      maches++;
    }
  }

  print('Maches: $maches');
}

bool validate(int n) {
  var s = n.toString();
  var lastChar = 0;
  var doubleNum = false;

  for (var i=0; i<s.length; i++) {
      var char =  s[i].codeUnitAt(0);

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