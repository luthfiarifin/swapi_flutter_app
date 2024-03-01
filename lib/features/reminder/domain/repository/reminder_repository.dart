import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/data/error/error.dart';
import '../../../../core/data/util/repository_util.dart';
import '../../data/datasource/datasource.dart';
import '../../../../core/domain/common/model/model.dart';

abstract class ReminderRpository {
  Future<Either<Failure, ReminderModel?>> getReminder();
  Future<Either<Failure, ReminderModel>> saveReminder(ReminderModel reminder);
}

@Injectable(as: ReminderRpository)
class ReminderRpositoryImpl implements ReminderRpository {
  final ReminderLocalDataSource localDataSource;

  ReminderRpositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, ReminderModel?>> getReminder() {
    return RepositoryUtil.catchOrThrow(
      body: () {
        return localDataSource.getReminder();
      },
    );
  }

  @override
  Future<Either<Failure, ReminderModel>> saveReminder(ReminderModel reminder) {
    return RepositoryUtil.catchOrThrow(
      body: () {
        return localDataSource.saveReminder(reminder);
      },
    );
  }
}
