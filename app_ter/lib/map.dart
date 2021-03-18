import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'storeDetailPage.dart';

class Map extends StatefulWidget {
  final List storeData;

  Map(this.storeData);

  @override
  State<Map> createState() => MapState();
}

class MapState extends State<Map> {
  final List<Marker> markers = <Marker>[
    Marker(
        markerId: MarkerId("test"),
        position: LatLng(43.3166044, -0.3627473),
        onTap: () {}),
    Marker(
        markerId: MarkerId("test"), position: LatLng(43.3166044, -0.3627473)),
  ];
  Completer<GoogleMapController> _controller = Completer();

  MapState();

  static final CameraPosition _pau = CameraPosition(
    target: LatLng(43.3166044, -0.3627473),
    zoom: 14.4746,
  );

  List<Marker> markerize(List data) {
    return data
        .map(
          (e) => Marker(
            infoWindow: InfoWindow(
              title: e["name"],
              onTap: () {
                Navigator.of(this.context).push(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) {
                      return StoreDetailPage(e);
                    },
                  ),
                );
              },
            ),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            markerId: MarkerId("${e["_id"]}"),
            position: LatLng(e["latitude"], e["longitude"]),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        markers: Set<Marker>.of(this.markerize(this.widget.storeData)),
        liteModeEnabled: false,
        mapType: MapType.normal,
        initialCameraPosition: _pau,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
