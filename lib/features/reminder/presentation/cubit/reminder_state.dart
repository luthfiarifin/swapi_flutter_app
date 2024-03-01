part of 'reminder_cubit.dart';

sealed class ReminderState extends Equatable {
  const ReminderState();

  @override
  List<Object> get props => [];
}

final class ReminderInitial extends ReminderState {}

final class SaveReminderLoading extends ReminderState {}

final class SaveReminderLoaded extends ReminderState {
  final ReminderModel reminder;

  const SaveReminderLoaded(this.reminder);

  @override
  List<Object> get props => [reminder];
}

final class SaveReminderError extends ReminderState {
  final String message;

  const SaveReminderError(this.message);

  @override
  List<Object> get props => [message];
}

final class GetReminderLoading extends ReminderState {}

final class GetReminderLoaded extends ReminderState {
  final ReminderModel? reminder;

  const GetReminderLoaded(this.reminder);

  @override
  List<Object> get props => [reminder ?? ''];
}

final class GetReminderError extends ReminderState {
  final String message;

  const GetReminderError(this.message);

  @override
  List<Object> get props => [message];
}
