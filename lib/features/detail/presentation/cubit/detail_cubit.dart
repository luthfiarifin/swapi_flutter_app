import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/data/common/model/model.dart';
import '../../../../core/presentation/cubit/cubit_util.dart';
import '../../../../core/presentation/extension/extension.dart';
import '../../domain/param/param.dart';
import '../../domain/usecase/usecase.dart';

part 'detail_state.dart';

@injectable
class DetailCubit extends Cubit<DetailState> {
  final GetFilmUseCase _getFilmUseCase;
  final GetPeopleUseCase _getPeopleUseCase;

  DetailCubit(
    this._getFilmUseCase,
    this._getPeopleUseCase,
  ) : super(DetailInitial());

  FilmModel? filmModel;

  void getFilm(int id) async {
    CubitUtil.fetchData(
      useCaseFunction: () => _getFilmUseCase(id),
      onLoading: () => emit(GetFilmLoading()),
      onError: (failure) => emit(GetFilmError(message: failure.message)),
      onSuccess: (d) {
        filmModel = d;
        emit(GetFilmLoaded(film: d));
        _getPeople(d.characters.map((e) => e.getId() ?? 0).toList());
      },
    );
  }

  void _getPeople(List<int> ids) async {
    CubitUtil.fetchData(
      useCaseFunction: () => _getPeopleUseCase(GetPeopleParam(ids: ids)),
      onLoading: () => emit(GetPeopleLoading()),
      onError: (failure) => emit(GetPeopleError(message: failure.message)),
      onSuccess: (d) => emit(GetPeopleLoaded(people: d)),
    );
  }
}
