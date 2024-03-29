import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/data/common/model/model.dart';
import '../../../../core/data/error/failures.dart';
import '../../../../core/domain/usecase.dart';
import '../repository/repository.dart';

@lazySingleton
class GetFilmUseCase implements UseCase<FilmModel, int> {
  final DetailRepository repository;

  const GetFilmUseCase(this.repository);

  @override
  Future<Either<Failure, FilmModel>> call(int param) {
    return repository.getFilm(param);
  }
}
