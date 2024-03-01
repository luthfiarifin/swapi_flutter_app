import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _map(),
          _cinemaList(),
        ],
      ),
    );
  }

  Widget _map() {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _getInitialCameraPosition(),
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      myLocationButtonEnabled: false,
      markers: cinemaList
          .map(
            (model) => Marker(
              markerId: MarkerId(model.name),
              position: LatLng(model.latitude, model.longitude),
              infoWindow: InfoWindow(
                title: model.name,
                snippet: model.address,
              ),
            ),
          )
          .toSet(),
    );
  }

  Widget _cinemaList() {
    return Positioned(
      bottom: 16,
      left: 0,
      right: 0,
      child: CinemaList(
        onPageChanged: (model) {
          _onCinemaSelected(model);
        },
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
}
