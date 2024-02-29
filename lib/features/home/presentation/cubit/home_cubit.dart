import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/data/common/model/model.dart';
import '../../../../core/presentation/cubit/cubit_util.dart';
import '../../domain/usecase/usecase.dart';

part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final GetFilmsUseCase _getFilmUseCase;

  HomeCubit(
    this._getFilmUseCase,
  ) : super(HomeInitial());

  void getFilms(int page) async {
    CubitUtil.fetchData(
      onError: (p0) => emit(GetFilmsError(message: p0.message)),
      onLoading: () => emit(GetFilmsLoading()),
      onSuccess: (p0) => emit(GetFilmsLoaded(response: p0)),
      useCaseFunction: () => _getFilmUseCase(page),
    );
  }
}
