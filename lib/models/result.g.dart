// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      id: json['id'] as String,
      result: ResultData.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'id': instance.id,
      'result': instance.result,
    };

ResultData _$ResultDataFromJson(Map<String, dynamic> json) => ResultData(
      steps: (json['steps'] as List<dynamic>)
          .map((e) => Step.fromJson(e as Map<String, dynamic>))
          .toList(),
      path: json['path'] as String,
    );

Map<String, dynamic> _$ResultDataToJson(ResultData instance) =>
    <String, dynamic>{
      'steps': instance.steps,
      'path': instance.path,
    };

Step _$StepFromJson(Map<String, dynamic> json) => Step(
      x: json['x'] as String,
      y: json['y'] as String,
    );

Map<String, dynamic> _$StepToJson(Step instance) => <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
    };
