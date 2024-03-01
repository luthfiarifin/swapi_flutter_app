part of 'cinema_cubit.dart';

sealed class CinemaState extends Equatable {
  const CinemaState();

  @override
  List<Object> get props => [];
}

final class CinemaInitial extends CinemaState {}

final class GetDirectionLoading extends CinemaState {}

final class GetDirectionLoaded extends CinemaState {
  final DirectionsResult response;

  const GetDirectionLoaded({required this.response});

  @override
  List<Object> get props => [response];
}

final class GetDirectionError extends CinemaState {
  final String message;

  const GetDirectionError({required this.message});

  @override
  List<Object> get props => [message];
}
