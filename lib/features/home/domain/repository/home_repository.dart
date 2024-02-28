import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/data/common/model/model.dart';
import '../../../../core/data/error/failures.dart';
import '../../../../core/data/util/repository_util.dart';
import '../../data/datasource/datasource.dart';

abstract class HomeRepository {
  Future<Either<Failure, BaseModel<FilmModel>>> getFilms(int page);
}

@LazySingleton(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  const HomeRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, BaseModel<FilmModel>>> getFilms(int page) {
    return RepositoryUtil.catchOrThrow(
      body: () async {
        return await remoteDataSource.getFilms(page);
      },
    );
  }
}
