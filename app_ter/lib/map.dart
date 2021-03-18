import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final List<Marker> markers = <Marker>[
    Marker(
        markerId: MarkerId("test"),
        position: LatLng(43.3166044, -0.3627473),
        onTap: () {}),
    Marker(
        markerId: MarkerId("test"), position: LatLng(43.3166044, -0.3627473)),
  ];
  Completer<GoogleMapController> _controller = Completer();

  MapSampleState();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(43.3166044, -0.3627473),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 0,
      target: LatLng(43.3166044, -0.3627473),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        markers: Set<Marker>.of(this.markers),
        liteModeEnabled: false,
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
