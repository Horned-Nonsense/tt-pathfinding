import 'dart:math';

import 'package:pathfinding/models/node.dart';

enum TypeResumeDirection {
  axisX,
  axisY,
  topLeft,
  bottomLeft,
  topRight,
  bottomRight,
}

class AStar {
  final int dimensionLength;
  final Node start;
  final Node end;
  final List<Node> barriers;
  List<Node> _doneList = [];
  List<Node> _waitList = [];

  late List<List<Node>> grid;

  AStar({
    required this.dimensionLength,
    required this.start,
    required this.end,
    required this.barriers,
  }) {
    grid = _createGrid(dimensionLength, barriers);
  }

  ///Main algorithm function
  Future<Iterable<Point<int>>> findThePath() async {
    _doneList.clear();
    _waitList.clear();

    if (barriers.contains(end)) {
      return [];
    }

    _addNeighbors(grid);

    Node startNode = grid[start.position.x][start.position.y];
    Node endNode = grid[end.position.x][end.position.y];

    Node? winner = _getNodeWinner(
      startNode,
      endNode,
    );

    List<Point<int>> path = [end.position];

    if (winner != null) {
      Node? nodeAux = winner.previous;
      for (int i = 0; i < winner.g - 1; i++) {
        path.add(nodeAux!.position);
        nodeAux = nodeAux.previous;
      }
    }
    path.add(start.position);

    if (winner == null && !_isNeighbors(start, end)) {
      path.clear();
    }
    return path.reversed;
  }

  /// Method that create the grid with barriers
  List<List<Node>> _createGrid(int dimensionLength, List<Node> barriers) {
    List<List<Node>> grid = [];
    List.generate(
      dimensionLength,
      (x) {
        List<Node> rowList = [];
        List.generate(
          dimensionLength,
          (y) {
            final offset = Point(x, y);
            bool isBarrie = barriers.where((element) {
              return element.position == offset;
            }).isNotEmpty;
            rowList.add(
              Node(
                offset,
              )..isWall = isBarrie,
            );
          },
        );
        grid.add(rowList);
      },
    );
    return grid;
  }

  /// Adds neighbors to cells
  void _addNeighbors(List<List<Node>> grid) {
    for (var _ in grid) {
      for (var element in _) {
        int x = element.position.x;
        int y = element.position.y;

        /// adds in top
        if (y > 0) {
          final t = grid[x][y - 1];
          if (!t.isWall) {
            element.neighbors.add(t);
          }
        }

        /// adds in bottom
        if (y < (grid.first.length - 1)) {
          final t = grid[x][y + 1];
          if (!t.isWall) {
            element.neighbors.add(t);
          }
        }

        /// adds in left
        if (x > 0) {
          final t = grid[x - 1][y];
          if (!t.isWall) {
            element.neighbors.add(t);
          }
        }

        /// adds in right
        if (x < (grid.length - 1)) {
          final t = grid[x + 1][y];
          if (!t.isWall) {
            element.neighbors.add(t);
          }
        }

        /// adds in top-left
        if (y > 0 && x > 0) {
          final t = grid[x - 1][y - 1];
          if (!t.isWall) {
            element.neighbors.add(t);
          }
        }

        /// adds in top-right
        if (y > 0 && x < (grid.length - 1)) {
          final t = grid[x + 1][y - 1];
          if (!t.isWall) {
            element.neighbors.add(t);
          }
        }

        /// adds in bottom-left
        if (x > 0 && y < (grid.first.length - 1)) {
          final t = grid[x - 1][y + 1];
          if (!t.isWall) {
            element.neighbors.add(t);
          }
        }

        /// adds in bottom-right
        if (x < (grid.length - 1) && y < (grid.first.length - 1)) {
          final t = grid[x + 1][y + 1];
          if (!t.isWall) {
            element.neighbors.add(t);
          }
        }
      }
    }
  }

  /// Method recursive that execute the A* algorithm
  Node? _getNodeWinner(Node current, Node end) {
    if (current == end) return current;
    _waitList.remove(current);

    for (var element in current.neighbors) {
      _analiseDistance(element, end, previous: current);
    }

    _doneList.add(current);

    _waitList.addAll(current.neighbors.where((element) {
      return !_doneList.contains(element);
    }));

    _waitList.sort((a, b) => a.f.compareTo(b.f));

    for (final element in _waitList.toList()) {
      if (!_doneList.contains(element)) {
        final result = _getNodeWinner(element, end);
        if (result != null) {
          return result;
        }
      }
    }

    return null;
  }

  /// Calculates the distance g and h
  void _analiseDistance(Node current, Node end, {Node? previous}) {
    if (current.previous == null) {
      current.previous = previous;
      current.g = (current.previous?.g ?? 0) + 1;

      current.h = _distance(current, end);
    }
  }

  /// Calculates the distance between two Nodes.
  int _distance(Node node1, Node node2) {
    int distX = (node1.position.x - node2.position.x).abs();
    int distY = (node1.position.y - node2.position.y).abs();
    return distX + distY;
  }

  ///Checks whether the start and end positions are neighbors
  bool _isNeighbors(Node start, Node end) {
    bool isNeighbor = false;

    int startX = start.position.x;
    int startY = start.position.y;
    int endX = end.position.x;
    int endY = end.position.y;

    if (startX + 1 == endX && startY == endY || //right
            startX - 1 == endX && startY == endY || //left
            startX == endX && startY + 1 == endY || //bottom
            startX == endX && startY - 1 == endY || //top
            startX + 1 == endX && startY + 1 == endY || //bottom-right
            startX - 1 == endX && startY - 1 == endY || //top-left
            startX - 1 == endX && startY + 1 == endY || //bottom-left
            startX + 1 == endX && startY - 1 == endY //top-right
        ) {
      isNeighbor = true;
    }

    return isNeighbor;
  }
}
