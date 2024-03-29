import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/data/common/model/model.dart';
import '../../../../core/data/error/failures.dart';
import '../../../../core/domain/usecase.dart';
import '../repository/repository.dart';

@lazySingleton
class GetFilmsUseCase implements UseCase<BaseModel<FilmModel>, int> {
  final HomeRepository repository;

  const GetFilmsUseCase(this.repository);

  @override
  Future<Either<Failure, BaseModel<FilmModel>>> call(int param) {
    return repository.getFilms(param);
  }
}
