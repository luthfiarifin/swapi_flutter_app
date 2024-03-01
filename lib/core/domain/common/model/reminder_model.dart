import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reminder_model.g.dart';

@JsonSerializable()
class ReminderModel extends Equatable {
  final int id;
  final DateTime time;
  final bool enabled;

  const ReminderModel({
    this.id = -1,
    required this.time,
    required this.enabled,
  });

  @override
  List<Object?> get props => [
        id,
        time,
        enabled,
      ];

  factory ReminderModel.fromJson(Map<String, dynamic> json) =>
      _$ReminderModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReminderModelToJson(this);

  ReminderModel copyWith({
    int? id,
    DateTime? time,
    bool? enabled,
  }) {
    return ReminderModel(
      id: id ?? this.id,
      time: time ?? this.time,
      enabled: enabled ?? this.enabled,
    );
  }
}

ReminderModel emptyReminder() {
  final time = DateTime.now();
  return ReminderModel(
    id: -1,
    time: time.add(const Duration(minutes: 1)),
    enabled: false,
  );
}
