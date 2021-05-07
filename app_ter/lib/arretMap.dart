import 'package:app_ter/arretDetailPage.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'storeDetailPage.dart';

class ArretMap extends StatefulWidget {
  final List arretData;

  final List ligneData;
  //final List parkingData;

  ArretMap(this.arretData, this.ligneData);

  @override
  State<ArretMap> createState() => ArretMapState();

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

class ArretMapState extends State<ArretMap> {
  final List<Marker> markers = <Marker>[];

  BitmapDescriptor checkedIcon;
  BitmapDescriptor crossedIcon;
  BitmapDescriptor orangeIcon;

  Completer<GoogleMapController> _controller = Completer();

  ArretMapState();

  @override
  void initState() {
    super.initState();
    this._loadMarker();
  }

  List<dynamic> getligneFromArret(arret) {
    return this
        .widget
        .ligneData
        .where((element) => element["bus_route"].contains(arret["_id"]))
        .toList();
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
              title: e["ville"] + " / " + e["description"],
              onTap: () {
                Navigator.of(this.context).push(
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) {
                      return ArretDetailPage(e, this.getligneFromArret(e));
                    },
                  ),
                );
              },
            ),
            /*icon: ArretMap.currentPeople(e["sensorsDatas"].toList()) /
                        e["maxPeopleCapacity"] <
                    0.33
                ? this.checkedIcon
                : ArretMap.currentPeople(e["sensorsDatas"].toList()) /
                            e["maxPeopleCapacity"] >
                        0.66
                    ? this.crossedIcon
                    : this.orangeIcon,*/
            markerId: MarkerId("${e["_id"]}"),
            position: LatLng(e["coordonnees"][0], e["coordonnees"][1]),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      zoomControlsEnabled: false,
      markers: Set<Marker>.of(this._markerize(this.widget.arretData)),
      liteModeEnabled: false,
      mapType: MapType.normal,
      initialCameraPosition: _pau,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }
}
