part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class GetFilmsLoading extends HomeState {}

final class GetFilmsLoaded extends HomeState {
  final BaseModel<FilmModel> response;

  const GetFilmsLoaded({
    required this.response,
  });

  @override
  List<Object> get props => [
        response,
      ];
}

final class GetFilmsError extends HomeState {
  final String message;

  const GetFilmsError({
    required this.message,
  });

  @override
  List<Object> get props => [
        message,
      ];
}
