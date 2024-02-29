part of 'detail_cubit.dart';

sealed class DetailState extends Equatable {
  const DetailState();

  @override
  List<Object> get props => [];
}

final class DetailInitial extends DetailState {}

final class GetFilmLoading extends DetailState {}

final class GetFilmLoaded extends DetailState {
  final FilmModel film;

  const GetFilmLoaded({
    required this.film,
  });

  @override
  List<Object> get props => [film];
}

final class GetFilmError extends DetailState {
  final String message;

  const GetFilmError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

final class GetPeopleLoading extends DetailState {}

final class GetPeopleLoaded extends DetailState {
  final List<PeopleModel> people;

  const GetPeopleLoaded({
    required this.people,
  });

  @override
  List<Object> get props => [people];
}

final class GetPeopleError extends DetailState {
  final String message;

  const GetPeopleError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
