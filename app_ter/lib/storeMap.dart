import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'storeDetailPage.dart';

class StoreMap extends StatefulWidget {
  final List storeData;
  //final List parkingData;

  StoreMap(this.storeData);

  @override
  State<StoreMap> createState() => StoreMapState();

  static int currentPeople(List<dynamic> dataSensor) {
    int people = 0;
    DateTime now = DateTime.now().toLocal();
    dataSensor.forEach((element) {
      people += element["type"] == "in"
          ? 1
          : now.difference(element["date"].toLocal()).inSeconds > 0
              ? -1
              : 0;
    });

    return people;
  }
}

class StoreMapState extends State<StoreMap> {
  final List<Marker> markers = <Marker>[];

  BitmapDescriptor checkedIcon;
  BitmapDescriptor crossedIcon;
  BitmapDescriptor orangeIcon;

  Completer<GoogleMapController> _controller = Completer();

  StoreMapState();

  @override
  void initState() {
    super.initState();
    this._loadMarker();
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
                      return StoreDetailPage(e,
                          StoreMap.currentPeople(e["sensorsDatas"].toList()));
                    },
                  ),
                );
              },
            ),
            icon: StoreMap.currentPeople(e["sensorsDatas"].toList()) /
                        e["maxPeopleCapacity"] <
                    0.33
                ? this.checkedIcon
                : StoreMap.currentPeople(e["sensorsDatas"].toList()) /
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
      zoomControlsEnabled: false,
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
