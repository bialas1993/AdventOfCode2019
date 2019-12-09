import 'dart:io';
import 'dart:core';

class SpaceObject {
  SpaceObject orbitAround;

  int get directAndIndirectOrbits => orbitAround == null ? 0 : 1 + orbitAround.directAndIndirectOrbits;
}

int solveA(Iterable<String> inputs) {
  final map = <String, SpaceObject>{};

  for (final input in inputs) {
    final parts = input.split(')');
    final o1 = map.putIfAbsent(parts[0], () => SpaceObject());
    final o2 = map.putIfAbsent(parts[1], () => SpaceObject());
    o2.orbitAround = o1;
  }

  return map.values.map((o) => o.directAndIndirectOrbits)
      .reduce((sum, e) => sum + e);
}

class SpaceObject2Way {
  final List<SpaceObject2Way> orbitedBy = [];
  SpaceObject2Way orbitAround;
  int distanceFromStart;

  Iterable<SpaceObject2Way> get orbitsNotVisited sync* {
    if (orbitAround != null && orbitAround.distanceFromStart == null) {
      yield orbitAround;
    }

    yield* orbitedBy.where((o) => o.distanceFromStart == null);
  }

  void visit([int distance = 0]) {
    distanceFromStart = distance;
    orbitsNotVisited.forEach((o) => o.visit(distance + 1));
  }
}

int solveB(Iterable<String> inputs) {
  final map = <String, SpaceObject2Way>{};

  for (final input in inputs) {
    final parts = input.split(')');
    final o1 = map.putIfAbsent(parts[0], () => SpaceObject2Way());
    final o2 = map.putIfAbsent(parts[1], () => SpaceObject2Way());
    o2.orbitAround = o1;
    o1.orbitedBy.add(o2);
  }

  map['YOU'].orbitAround.visit();
  return map['SAN'].orbitAround.distanceFromStart;
}


main(List<String> arguments) async {
  var file = File('./bin/day06/input.txt');

  if (await file.exists()) {
    final input = (await file.readAsLinesSync());

    print('Solution 1: ${solveA(input)}');
    print('Solution 2: ${solveB(input)}');
    return;
  }

  throw("Can not read input file.");
}