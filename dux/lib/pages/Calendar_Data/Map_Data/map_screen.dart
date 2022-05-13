import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _googleMapController;
  late Marker _origin;
  late Marker _destination;

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  // Set<Marker> _markers = {};

  // void _onMapCreated(GoogleMapController controller) {
  //   setState(() {
  //     _markers.add(Marker(
  //         markerId: MarkerId('id-1'), position: LatLng(22.544811, 88.3403691)));
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GoogleMap(
          // markers: _markers,
          initialCameraPosition:
              CameraPosition(target: LatLng(22.544811, 88.3403691), zoom: 15),
          onMapCreated: ((controller) => _googleMapController = controller),
          markers: {
            if (_origin != null) _origin,
            if (_destination != null) _destination,
          },
          onLongPress: _addMarker,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          onPressed: () => _googleMapController.animateCamera(
              CameraUpdate.newCameraPosition(CameraPosition(
                  target: LatLng(22.544811, 88.3403691), zoom: 15))),
          child: const Icon(Icons.center_focus_strong),
        ));
  }

  void _addMarker(LatLng pos) {
    if (_origin == null || (_origin != null && _destination != null)) {
      setState(() {
        _origin = Marker(
          markerId: const MarkerId('origin'),
          infoWindow: const InfoWindow(title: 'Origin'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: pos,
        );
      });
    } else {
      setState(() {
        _destination = Marker(
          markerId: const MarkerId('destination'),
          infoWindow: const InfoWindow(title: 'Destination'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: pos,
        );
      });
    }
  }
}
