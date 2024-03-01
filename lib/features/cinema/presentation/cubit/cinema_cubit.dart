import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_directions_api/google_directions_api.dart';
import 'package:injectable/injectable.dart';

part 'cinema_state.dart';

@injectable
class CinemaCubit extends Cubit<CinemaState> {
  final DirectionsService _directionService;

  CinemaCubit(
    this._directionService,
  ) : super(CinemaInitial());

  void getDirections(
    GeoCoord origin,
    GeoCoord destination,
  ) async {
    emit(GetDirectionLoading());

    final DirectionsRequest directionsRequest = DirectionsRequest(
      origin: origin,
      destination: destination,
      travelMode: TravelMode.driving,
    );

    await _directionService.route(
      directionsRequest,
      (DirectionsResult response, DirectionsStatus? status) {
        if (status == DirectionsStatus.ok) {
          emit(GetDirectionLoaded(response: response));
        } else {
          emit(GetDirectionError(message: response.errorMessage ?? ''));
        }
      },
    );
  }
}
