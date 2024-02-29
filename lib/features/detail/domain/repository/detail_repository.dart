import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/data/common/model/model.dart';
import '../../../../core/data/error/failures.dart';
import '../../../../core/data/util/repository_util.dart';
import '../../data/datasource/datasource.dart';
import '../param/param.dart';

abstract class DetailRepository {
  Future<Either<Failure, FilmModel>> getFilm(int id);
  Future<Either<Failure, List<PeopleModel>>> getPeople(GetPeopleParam param);
}

@Injectable(as: DetailRepository)
class DetailRepositoryImpl implements DetailRepository {
  final DetailRemoteDataSource remoteDataSource;

  const DetailRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, FilmModel>> getFilm(int id) {
    return RepositoryUtil.catchOrThrow(
      body: () async {
        return await remoteDataSource.getFilm(id);
      },
    );
  }

  @override
  Future<Either<Failure, List<PeopleModel>>> getPeople(GetPeopleParam param) {
    return RepositoryUtil.catchOrThrow(
      body: () async {
        return await Future.wait(
          param.ids.map((e) => remoteDataSource.getPeople(e)),
        );
      },
    );
  }
}
