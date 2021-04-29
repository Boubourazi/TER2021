import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'storeDetailPage.dart';

class AirMap extends StatefulWidget {
  final List<Polygon> polygons;
  //final List parkingData;

  AirMap(this.polygons);

  @override
  State<AirMap> createState() => AirMapState();
}

class AirMapState extends State<AirMap> {
  final List<Marker> markers = <Marker>[];

  BitmapDescriptor checkedIcon;
  BitmapDescriptor crossedIcon;
  BitmapDescriptor orangeIcon;

  Completer<GoogleMapController> _controller = Completer();

  AirMapState();

  @override
  void initState() {
    super.initState();
  }

  static final CameraPosition _pau = CameraPosition(
    target: LatLng(43.3166044, -0.3627473),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      zoomControlsEnabled: true,
      liteModeEnabled: false,
      mapType: MapType.normal,
      polygons: Set.from(this.widget.polygons),
      initialCameraPosition: _pau,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }
}
