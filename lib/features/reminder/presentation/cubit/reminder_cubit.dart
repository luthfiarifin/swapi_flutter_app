import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/domain/usecase.dart';
import '../../../../core/presentation/cubit/cubit_util.dart';
import '../../domain/model/model.dart';
import '../../domain/usecase/usecase.dart';

part 'reminder_state.dart';

@injectable
class ReminderCubit extends Cubit<ReminderState> {
  final GetReminderUseCase _getReminderUseCase;
  final SaveReminderUseCase _saveReminderUseCase;

  ReminderCubit(
    this._getReminderUseCase,
    this._saveReminderUseCase,
  ) : super(ReminderInitial());

  void saveReminder(ReminderModel reminder) async {
    CubitUtil.fetchData(
      useCaseFunction: () => _saveReminderUseCase(reminder),
      onLoading: () => emit(SaveReminderLoading()),
      onError: (p0) => emit(SaveReminderError(p0.message)),
      onSuccess: (p0) => emit(SaveReminderLoaded(p0)),
    );
  }

  void getReminder() async {
    CubitUtil.fetchData(
      useCaseFunction: () => _getReminderUseCase(NoParams()),
      onLoading: () => emit(GetReminderLoading()),
      onError: (p0) => emit(GetReminderError(p0.message)),
      onSuccess: (p0) => emit(GetReminderLoaded(p0)),
    );
  }
}
