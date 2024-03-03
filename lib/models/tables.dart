import 'dart:math';
import 'package:json_annotation/json_annotation.dart';
import 'package:pathfinding/models/node.dart';

part 'tables.g.dart';

@JsonSerializable()
class Tables {
  final bool error;
  final String message;
  final List<DataItem> data;

  Tables({
    required this.error,
    required this.message,
    required this.data,
  });

  Tables.empty()
      : error = false,
        message = '',
        data = [];

  factory Tables.fromJson(Map<String, dynamic> json) => _$TablesFromJson(json);
  Map<String, dynamic> toJson() => _$TablesToJson(this);
}

@JsonSerializable()
class DataItem {
  final String id;
  final List<String> field;
  final Coordinates start;
  final Coordinates end;

  DataItem({
    required this.id,
    required this.field,
    required this.start,
    required this.end,
  });

  factory DataItem.fromJson(Map<String, dynamic> json) =>
      _$DataItemFromJson(json);
  Map<String, dynamic> toJson() => _$DataItemToJson(this);

  List<Node> getBarriers() {
    int counter = 0;
    List<Node> barriers = [];
    int dimensionLength = field.length;

    for (String row in field) {
      List<String> elements = row.split('');

      for (String char in elements) {
        if (char == 'X') {
          int x = counter % dimensionLength;
          int y = counter ~/ dimensionLength;

          Node barrierNode = Node(Point(x, y))..isWall = true;

          barriers.add(barrierNode.clone());
        }
        counter++;
      }
    }

    return barriers;
  }
}

@JsonSerializable()
class Coordinates {
  final int x;
  final int y;

  Coordinates({
    required this.x,
    required this.y,
  });

  factory Coordinates.fromJson(Map<String, dynamic> json) =>
      _$CoordinatesFromJson(json);
  Map<String, dynamic> toJson() => _$CoordinatesToJson(this);

  Node getPoint() {
    return Node(Point(x, y));
  }
}
