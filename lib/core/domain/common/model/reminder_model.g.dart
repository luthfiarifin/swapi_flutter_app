// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReminderModel _$ReminderModelFromJson(Map<String, dynamic> json) =>
    ReminderModel(
      id: json['id'] as int? ?? -1,
      time: DateTime.parse(json['time'] as String),
      enabled: json['enabled'] as bool,
    );

Map<String, dynamic> _$ReminderModelToJson(ReminderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'time': instance.time.toIso8601String(),
      'enabled': instance.enabled,
    };
