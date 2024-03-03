import 'dart:math';

class Node {
  final Point<int> position;

  Node(this.position);

  bool visited = false;
  bool isWall = false;

  Node? previous;

  List<Node> neighbors = [];

  int g = 0;
  int h = 0;

  int get f => g + h;

  Node clone() => Node(position)
    ..visited = visited
    ..isWall = isWall
    ..previous = previous
    ..neighbors = List.from(neighbors)
    ..g = g
    ..h = h;
}
