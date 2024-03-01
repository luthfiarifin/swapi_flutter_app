import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/core.dart';
import '../../domain/model/cinema_model.dart';
import '../widget/widget.dart';

@RoutePage()
class CinemaPage extends StatefulWidget {
  const CinemaPage({super.key});

  @override
  State<CinemaPage> createState() => _CinemaPageState();
}

class _CinemaPageState extends State<CinemaPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final Map<PolylineId, Polyline> _polylines = <PolylineId, Polyline>{};

  CinemaModel? _selectedCinema;
  Position? _currentPosition;

  @override
  void initState() {
    _setUserPosition();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _map(),
          _cinemaList(),
          _backButton(),
        ],
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

  Widget _backButton() {
    if (_selectedCinema == null) return const SizedBox();

    return Positioned(
      top: 16,
      left: 16,
      child: InkWell(
        onTap: _onResetSelectedCinema,
        child: CircleAvatar(
          backgroundColor: context.colorScheme.primary,
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  CameraPosition _getInitialCameraPosition() {
    final firstCinema = cinemaList.first;

    return CameraPosition(
      target: LatLng(firstCinema.latitude, firstCinema.longitude),
      zoom: 18,
    );
  }

  void _onCinemaSelected(CinemaModel model) {
    _changeCameraPosition(LatLng(model.latitude, model.longitude));
  }

  void _changeCameraPosition(LatLng latLng) async {
    await Future.delayed(const Duration(milliseconds: 200));

    final GoogleMapController controller = await _controller.future;
    await controller.moveCamera(
      CameraUpdate.newLatLng(latLng),
    );
  }

  void _onDirectionPressed(CinemaModel model) async {
    _selectedCinema = model;
    await _drawPolyline();

    setState(() {});
  }

  Future<void> _drawPolyline() async {
    final currentPosition = _currentPosition ?? await _getUserCurrentLocation();

    final PolylineId polylineId = PolylineId(_selectedCinema!.name);
    final Polyline polyline = Polyline(
      polylineId: polylineId,
      color: Colors.blue,
      width: 5,
      points: [
        LatLng(_selectedCinema!.latitude, _selectedCinema!.longitude),
        LatLng(currentPosition.latitude, currentPosition.longitude),
      ],
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

    return await Geolocator.getCurrentPosition();
  }

  void _onResetSelectedCinema() {
    _selectedCinema = null;
    _polylines.clear();

    setState(() {});
  }
}
