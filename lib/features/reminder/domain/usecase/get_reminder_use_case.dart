import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/data/error/failures.dart';
import '../../../../core/domain/usecase.dart';
import '../model/reminder_model.dart';
import '../repository/repository.dart';

@lazySingleton
class GetReminderUseCase implements UseCase<ReminderModel?, NoParams> {
  final ReminderRpository repository;

  const GetReminderUseCase(this.repository);

  @override
  Future<Either<Failure, ReminderModel?>> call(NoParams param) {
    return repository.getReminder();
  }
}
