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
  final List<Marker> markers = <Marker>[];

  BitmapDescriptor checkedIcon;
  BitmapDescriptor crossedIcon;
  BitmapDescriptor orangeIcon;

  Completer<GoogleMapController> _controller = Completer();

  MapState();

  @override
  void initState() {
    super.initState();
    this._loadMarker();
  }

  int currentPeople(List<dynamic> dataSensor) {
    int people = 0;
    DateTime now = DateTime.now();

    dataSensor.forEach((element) {
      people += element["type"] == "in"
          ? 1
          : now.difference(element["date"]).inSeconds > 0
              ? -1
              : 0;
    });

    return people;
  }

  _loadMarker() async {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(devicePixelRatio: 2.5), "checkedIcon.png")
        .then((value) => this.setState(() {
              this.checkedIcon = value;
            }))
        .then((value) => BitmapDescriptor.fromAssetImage(
            ImageConfiguration(devicePixelRatio: 2.5), "crossedIcon.png"))
        .then((value) => this.setState(() {
              this.crossedIcon = value;
            }))
        .then((value) => BitmapDescriptor.fromAssetImage(
            ImageConfiguration(devicePixelRatio: 2.5), "orangeIcon.png"))
        .then((value) => this.setState(() {
              this.orangeIcon = value;
            }));
  }

  static final CameraPosition _pau = CameraPosition(
    target: LatLng(43.3166044, -0.3627473),
    zoom: 14.4746,
  );

  List<Marker> _markerize(List data) {
    return data
        .map(
          (e) => Marker(
            infoWindow: InfoWindow(
              title: e["name"],
              onTap: () {
                Navigator.of(this.context).push(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) {
                      return StoreDetailPage(
                          e, this.currentPeople(e["sensorsDatas"].toList()));
                    },
                  ),
                );
              },
            ),
            icon: this.currentPeople(e["sensorsDatas"].toList()) /
                        e["maxPeopleCapacity"] <
                    0.33
                ? this.checkedIcon
                : this.currentPeople(e["sensorsDatas"].toList()) /
                            e["maxPeopleCapacity"] >
                        0.66
                    ? this.crossedIcon
                    : this.orangeIcon,
            markerId: MarkerId("${e["_id"]}"),
            position: LatLng(e["latitude"], e["longitude"]),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    this._loadMarker();
    return GoogleMap(
      markers: Set<Marker>.of(this._markerize(this.widget.storeData)),
      liteModeEnabled: false,
      mapType: MapType.normal,
      initialCameraPosition: _pau,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }
}
