import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GoogleMap(
      initialCameraPosition:
          CameraPosition(target: LatLng(22.544811, 88.3403691), zoom: 15),
    ));
  }
}
