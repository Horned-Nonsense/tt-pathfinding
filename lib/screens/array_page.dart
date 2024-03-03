import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pathfinding/models/tables.dart';

import '../models/node.dart';

class ArrayPage extends StatelessWidget {
  final DataItem data;
  final List<Point<int>> path;

  const ArrayPage({
    super.key,
    required this.data,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Preview screen"),
      ),
      body: _buildBody(context, data.field.length),
    );
  }

  Widget _buildBody(BuildContext context, int dimensionLength) {
    List<Node> barriers = data.getBarriers();
    String coordinatePath = '';

    for (var step in path) {
      coordinatePath += '(${step.x},${step.y})';

      if (path.last != step) {
        coordinatePath += '->';
      }
    }

    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: dimensionLength,
            ),
            itemBuilder: (BuildContext context, int index) {
              int x = index % dimensionLength;
              int y = index ~/ dimensionLength;

              Color cellColor;
              Color textColot = Colors.black;

              if (x == data.start.x && y == data.start.y) {
                cellColor = const Color(0xFF64FFDA);
              } else if (x == data.end.x && y == data.end.y) {
                cellColor = const Color(0xFF009688);
              } else if (barriers.where((element) {
                return element.position == Point(x, y);
              }).isNotEmpty) {
                cellColor = const Color(0xFF000000);
                textColot = const Color(0xFFFFFFFF);
              } else if (path.contains(Point(x, y)) &&
                  Point(x, y) != path.first &&
                  Point(x, y) != path.last) {
                cellColor = const Color(0xFF4CAF50);
              } else {
                cellColor = const Color(0xFFFFFFFF);
              }

              return Container(
                decoration: BoxDecoration(
                  color: cellColor,
                  border: Border.all(),
                ),
                child: Center(
                  child: Text(
                    '($x, $y)',
                    style: TextStyle(
                      color: textColot,
                    ),
                  ),
                ),
              );
            },
            itemCount: dimensionLength * dimensionLength,
          ),
        ),
        const SizedBox(height: 12),
        Text(coordinatePath)
      ],
    );
  }
}
