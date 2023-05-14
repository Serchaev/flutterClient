// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'positions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PositionsList _$PositionsListFromJson(Map<String, dynamic> json) =>
    PositionsList(
      positions: (json['positions'] as List<dynamic>)
          .map((e) => Position.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PositionsListToJson(PositionsList instance) =>
    <String, dynamic>{
      'positions': instance.positions,
    };

Position _$PositionFromJson(Map<String, dynamic> json) => Position(
      id: json['_id'] as String,
      name: json['name'] as String,
      salary: json['salary'] as int,
    );

Map<String, dynamic> _$PositionToJson(Position instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'salary': instance.salary,
    };
