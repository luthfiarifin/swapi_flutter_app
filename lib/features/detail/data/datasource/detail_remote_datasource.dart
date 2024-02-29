import 'package:injectable/injectable.dart';

import '../../../../core/data/common/model/model.dart';
import '../../../../core/data/constant/api_constant.dart';
import '../../../../core/data/network/api_client.dart';

abstract class DetailRemoteDataSource {
  Future<FilmModel> getFilm(int id);
  Future<PeopleModel> getPeople(int id);
}

@Injectable(as: DetailRemoteDataSource)
class DetailRemoteDataSourceImpl implements DetailRemoteDataSource {
  final ApiClient client;

  const DetailRemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<FilmModel> getFilm(int id) {
    return client.get(
      '${ApiConstant.films}/$id',
      converter: (e) => FilmModel.fromJson(
        e,
      ),
    );
  }

  @override
  Future<PeopleModel> getPeople(int id) {
    return client.get(
      '${ApiConstant.people}/$id',
      converter: (e) => PeopleModel.fromJson(
        e,
      ),
      newIsolate: false,
    );
  }
}
