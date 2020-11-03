import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class Gmaps extends StatefulWidget {
  @override
  _GmapsState createState() => _GmapsState();
}


class _GmapsState extends State<Gmaps> {
  var cp = CameraPosition(target: LatLng(21.5, 83.866669), zoom: 10, tilt: 60);
  @override
  Widget build(BuildContext context) {
    live() async {
      var p = await Geolocator.getCurrentPosition();
      print(p);
    }

    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text('My Location',
                style: TextStyle(
                    color: Colors.red,
                    fontStyle: FontStyle.normal,
                    fontSize: 20))),
        backgroundColor: Colors.black,
      ),
      body: GoogleMap(
        initialCameraPosition: cp,
        mapType: MapType.hybrid,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: live,
        child: Icon(Icons.live_help_sharp),
      ),
    );
  }
}

