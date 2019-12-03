import 'dart:io';
import 'dart:math';

int manhattanDistance(Point<int> point) => point.x.abs() + point.y.abs();

final Map<String, Point<int> Function(Point<int> point)> movesMap = {
  'U': (Point<int> point) => Point(point.x, point.y + 1),
  'D': (Point<int> point) => Point(point.x, point.y - 1),
  'L': (Point<int> point) => Point(point.x - 1, point.y),
  'R': (Point<int> point) => Point(point.x + 1, point.y)
};

Map<Point<int>, int> findIntersections(List<String> input) {
  final global = <Point<int>, int>{};
  final intersections = <Point<int>, int>{};

  for (final line in input) {
    final points = <Point<int>, int>{};
    var currPosition = const Point(0, 0);
    var distance = 0;

    for (final instruction in line.split(',')) {
      final move = movesMap[instruction.substring(0,1)];
      final length = int.parse(instruction.substring(1));

      for (var i = 0; i < length; i++) {
        currPosition = move(currPosition);
        distance++;
        if (!points.containsKey(currPosition)) {
          points[currPosition] = distance;
        }
      }
    }

    for (final point in points.entries) {
      if (!global.containsKey(point.key)) {
        global[point.key] = point.value;
      } else {
        intersections[point.key] = global[point.key] + point.value;
      }
    }
  }

  return intersections;
}

main(List<String> arguments) async {
  var file = File('./bin/day03/input.a.txt');

  if (await file.exists()) {
    var input = (await file.readAsLinesSync());
    
    print('Day 3 Part 1: ${findIntersections(input).keys.map(manhattanDistance).reduce(min)}');
    print('Day 3 Part 2: ${findIntersections(input).values.reduce(min)}');
    return;
  }

  throw("Can not read input file.");
}