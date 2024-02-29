import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/data/common/model/model.dart';
import '../../../../core/data/error/failures.dart';
import '../../../../core/domain/usecase.dart';
import '../param/get_people_param.dart';
import '../repository/repository.dart';

@lazySingleton
class GetPeopleUseCase implements UseCase<List<PeopleModel>, GetPeopleParam> {
  final DetailRepository repository;

  const GetPeopleUseCase(this.repository);

  @override
  Future<Either<Failure, List<PeopleModel>>> call(GetPeopleParam param) {
    return repository.getPeople(param);
  }
}
