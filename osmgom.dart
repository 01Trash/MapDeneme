import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  // location

  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var locationMessage = '';

  late String latitude;
  late String longitude;

  // function for getting the current location
  // but before that you need to add this permission!
  void getCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lat = position.latitude;
    var long = position.longitude;

    // passing this to latitude and longitude strings
    latitude = "$lat";
    longitude = "$long";

    setState(() {
      locationMessage = "Enlem: $lat ve Boylam: $long";
    });
  }

  // function for opening it in google maps
  void googleMap() async {
    String googleUrl =
        "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";

    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw ("Google haritalar açılamadı");
    }
  }

  // function for opening it in OSM maps
  void osMap() async {
    String osmUrl =
        "https://www.openstreetmap.org/#map=15/$latitude/$longitude";

    if (await canLaunch(osmUrl)) {
      await launch(osmUrl);
    } else {
      throw ("OpenStreetMap haritalar açılamadı");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kullanıcı Konumu WGS84',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on,
                size: 45.0,
                color: Colors.white,
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "Kullanıcı Konumunu Bul",
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                locationMessage,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 05.0,
              ),
              // button for taking the location
              FlatButton(
                color: Colors.white,
                onPressed: () {
                  getCurrentLocation();
                },
                child: Text("Kullanıcı Konumunu Bul"),
              ),
              SizedBox(
                height: 5.0,
              ),
              FlatButton(
                color: Colors.white,
                onPressed: () {
                  googleMap();
                },
                child: Text("GoogleMap Aç"),
              ),
              SizedBox(
                height: 5.0,
              ),
              FlatButton(
                color: Colors.white,
                onPressed: () {
                  osMap();
                },
                child: Text("OpenStreetMap Aç"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
