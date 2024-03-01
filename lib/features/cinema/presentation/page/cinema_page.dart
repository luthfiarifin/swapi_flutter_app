import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_directions_api/google_directions_api.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../config/di/di.dart';
import '../../../../core/core.dart';
import '../../domain/model/cinema_model.dart';
import '../cubit/cubit.dart';
import '../widget/widget.dart';

@RoutePage()
class CinemaPage extends StatefulWidget implements AutoRouteWrapper {
  const CinemaPage({super.key});

  @override
  State<CinemaPage> createState() => _CinemaPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider.value(
      value: getIt<CinemaCubit>(),
      child: this,
    );
  }
}

class _CinemaPageState extends State<CinemaPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final Map<PolylineId, Polyline> _polylines = <PolylineId, Polyline>{};

  CinemaModel? _selectedCinema;
  Position? _currentPosition;
  (String distance, String duration)? _selectedDistanceDuration;

  @override
  void initState() {
    _setUserPosition();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CinemaCubit, CinemaState>(
      listener: (context, state) {
        _onChangeState(state);
      },
      child: Scaffold(
        body: BlocBuilder<CinemaCubit, CinemaState>(
          builder: (context, state) {
            return Stack(
              children: [
                _map(),
                _cinemaList(),
                _selectedCinemaWidget(),
                if (state is GetDirectionLoading) _cinemaLoading(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _map() {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _getInitialCameraPosition(),
      myLocationButtonEnabled: false,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      markers: _markers(),
      polylines: Set<Polyline>.of(_polylines.values),
    );
  }

  Set<Marker> _markers() {
    if (_selectedCinema != null) {
      return {
        _getUserMarker(),
        _getMarker(_selectedCinema!),
      };
    }

    return cinemaList.map((model) => _getMarker(model)).toSet();
  }

  Marker _getMarker(CinemaModel model) {
    return Marker(
      markerId: MarkerId(model.name),
      position: LatLng(model.latitude, model.longitude),
      infoWindow: InfoWindow(
        title: model.name,
        snippet: model.address,
      ),
    );
  }

  Marker _getUserMarker() {
    if (_currentPosition == null) return const Marker(markerId: MarkerId(''));

    return Marker(
      markerId: const MarkerId('user'),
      position: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    );
  }

  Widget _cinemaList() {
    if (_selectedCinema != null) return const SizedBox();

    return Positioned(
      bottom: 16,
      left: 0,
      right: 0,
      child: CinemaList(
        data: cinemaList,
        onPageChanged: (model) => _onCinemaSelected(model),
        onDirectionPressed: (model) => _onDirectionPressed(model),
      ),
    );
  }

  Widget _selectedCinemaWidget() {
    final distance = _selectedDistanceDuration?.$1;
    final duration = _selectedDistanceDuration?.$2;

    if (_selectedCinema == null || distance == null || duration == null) {
      return const SizedBox();
    }

    return Positioned(
      bottom: 16,
      left: 0,
      right: 0,
      child: SelectedCinemaWidget(
        cinema: _selectedCinema!,
        distance: distance,
        duration: duration,
        onBackPressed: _onResetSelectedCinema,
      ),
    );
  }

  Widget _cinemaLoading() {
    return const Positioned(
      bottom: 16,
      left: 0,
      right: 0,
      child: CinemaWidgetLoading(),
    );
  }

  CameraPosition _getInitialCameraPosition() {
    return CameraPosition(
      target: _getInitialLatLng(),
      zoom: 18,
    );
  }

  LatLng _getInitialLatLng() {
    final firstCinema = cinemaList.first;
    return LatLng(firstCinema.latitude, firstCinema.longitude);
  }

  void _onCinemaSelected(CinemaModel model) {
    _changeCameraPosition(LatLng(model.latitude, model.longitude));
  }

  void _changeCameraPosition(
    LatLng latLng, {
    double? zoom,
  }) async {
    await Future.delayed(const Duration(milliseconds: 200));

    final GoogleMapController controller = await _controller.future;

    if (zoom != null) {
      await controller.moveCamera(
        CameraUpdate.newLatLngZoom(latLng, zoom),
      );
    } else {
      await controller.moveCamera(
        CameraUpdate.newLatLng(latLng),
      );
    }
  }

  void _onDirectionPressed(CinemaModel model) async {
    _selectedCinema = model;
    context.read<CinemaCubit>().getDirections(
          GeoCoord(_currentPosition?.latitude ?? 0,
              _currentPosition?.longitude ?? 0),
          GeoCoord(model.latitude, model.longitude),
        );
  }

  Future<void> _drawPolyline(
    List<LatLng> points,
  ) async {
    final LatLng halfPoints = points[points.length ~/ 2];
    _changeCameraPosition(
      halfPoints,
      zoom: 14,
    );

    final PolylineId polylineId = PolylineId(_selectedCinema!.name);
    final Polyline polyline = Polyline(
      polylineId: polylineId,
      color: Colors.blue,
      width: 3,
      points: points,
    );
    _polylines[polylineId] = polyline;
  }

  void _setUserPosition() async {
    _currentPosition = await _getUserCurrentLocation();
  }

  Future<Position> _getUserCurrentLocation() async {
    await Geolocator.requestPermission().then((value) {}).onError(
      (error, stackTrace) async {
        await Geolocator.requestPermission();
        debugPrintStack(stackTrace: stackTrace);
      },
    );

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
    );
  }

  void _onResetSelectedCinema() {
    _changeCameraPosition(_getInitialLatLng(), zoom: 18);

    _selectedCinema = null;
    _polylines.clear();

    setState(() {});
  }

  void _onChangeState(CinemaState state) {
    if (state is GetDirectionError) {
      context.showSnackBar(message: state.message);
    } else if (state is GetDirectionLoaded) {
      _onDirectionLoaded(state.response);
    }
  }

  void _onDirectionLoaded(DirectionsResult response) {
    final route = response.routes?.firstOrNull;
    final leg = route?.legs?.firstOrNull;

    if (leg == null) return;

    final distance = leg.distance?.text ?? '';
    final duration = leg.duration?.text ?? '';

    _selectedDistanceDuration = (distance, duration);
    route?.overviewPolyline?.points;

    _drawPolyline(leg.steps
            ?.map((e) =>
                LatLng(e.startLocation!.latitude, e.startLocation!.longitude))
            .toList() ??
        []);
  }
}
