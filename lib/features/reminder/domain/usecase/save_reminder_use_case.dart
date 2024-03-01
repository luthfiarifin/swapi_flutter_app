import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/data/error/failures.dart';
import '../../../../core/domain/usecase.dart';
import '../model/reminder_model.dart';
import '../repository/repository.dart';

@lazySingleton
class SaveReminderUseCase implements UseCase<ReminderModel, ReminderModel> {
  final ReminderRpository repository;

  const SaveReminderUseCase(this.repository);

  @override
  Future<Either<Failure, ReminderModel>> call(ReminderModel param) {
    return repository.saveReminder(param);
  }
}
