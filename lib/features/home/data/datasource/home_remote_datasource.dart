import 'package:injectable/injectable.dart';

import '../../../../core/core.dart';
import '../../../../core/data/common/model/model.dart';

abstract class HomeRemoteDataSource {
  Future<BaseModel<FilmModel>> getFilms(int page);
}

@LazySingleton(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiClient client;

  const HomeRemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<BaseModel<FilmModel>> getFilms(int page) {
    return client.get(
      ApiConstant.films,
      queryParameters: {
        'page': page,
      },
      converter: (e) => BaseModel.fromJson(
        e,
        (e) => FilmModel.fromJson(e),
      ),
    );
  }
}
