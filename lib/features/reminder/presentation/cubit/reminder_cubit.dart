import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'reminder_state.dart';

@injectable
class ReminderCubit extends Cubit<ReminderState> {
  ReminderCubit() : super(ReminderInitial());
}
