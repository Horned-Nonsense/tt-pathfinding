import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pathfinding/screens/array_page.dart';

import '../models/tables.dart';

class ResultListPage extends StatelessWidget {
  final List<DataItem> grids;
  final List<List<Point<int>>> pathes;

  const ResultListPage({
    super.key,
    required this.grids,
    required this.pathes,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Result list page"),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: pathes.length,
            itemBuilder: (context, index) {
              String coordinatePath = '';

              for (var step in pathes[index]) {
                coordinatePath += '(${step.x},${step.y})';

                if (pathes[index].last != step) {
                  coordinatePath += '->';
                }
              }

              return SizedBox(
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.to(ArrayPage(
                          data: grids[index],
                          path: pathes[index],
                        ));
                      },
                      child: Text(
                        coordinatePath,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.grey[850],
                    )
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
