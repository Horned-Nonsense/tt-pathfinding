// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tables.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tables _$TablesFromJson(Map<String, dynamic> json) => Tables(
      error: json['error'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => DataItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TablesToJson(Tables instance) => <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'data': instance.data,
    };

DataItem _$DataItemFromJson(Map<String, dynamic> json) => DataItem(
      id: json['id'] as String,
      field: (json['field'] as List<dynamic>).map((e) => e as String).toList(),
      start: Coordinates.fromJson(json['start'] as Map<String, dynamic>),
      end: Coordinates.fromJson(json['end'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataItemToJson(DataItem instance) => <String, dynamic>{
      'id': instance.id,
      'field': instance.field,
      'start': instance.start,
      'end': instance.end,
    };

Coordinates _$CoordinatesFromJson(Map<String, dynamic> json) => Coordinates(
      x: json['x'] as int,
      y: json['y'] as int,
    );

Map<String, dynamic> _$CoordinatesToJson(Coordinates instance) =>
    <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
    };
