import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Map Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyMap(),
    );
  }
}

class MyMap extends StatefulWidget {
  const MyMap({super.key});

  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  late LatLng userPosition;
  List<Marker> markers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Google Maps'),
          actions: [
            IconButton(
              icon: const Icon(Icons.map),
              onPressed: () => findPlaces(),
            )
          ],
        ),
        body: FutureBuilder(
            future: findUserLocation(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return GoogleMap(
                  initialCameraPosition:
                      CameraPosition(target: snapshot.data, zoom: 12),
                  markers: Set<Marker>.of(markers),
                );
              } else {
                return Container();
              }
            }));
  }

  Future<LatLng> findUserLocation() async {
    Location location = Location();
    LocationData userLocation;
    PermissionStatus hasPermission = await location.hasPermission();
    bool active = await location.serviceEnabled();
    if (hasPermission == PermissionStatus.granted && active) {
      userLocation = await location.getLocation();
      userPosition = LatLng(userLocation.latitude!, userLocation.longitude!);
    } else {
      userPosition = const LatLng(51.5285582, -0.24167);
    }
    return userPosition;
  }

  Future findPlaces() async {
    const key = 'Your key here';
    const placesUrl =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?';
    String url = placesUrl +
        'key=$key&type=restaurant&location=${userPosition.latitude},${userPosition.longitude}' +
        '&radius=1000';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      showMarkers(data);
    } else {
      throw Exception('Unable to retrieve places');
    }
  }

  showMarkers(data) {
    List places = data['results'];
    markers.clear();
    for (var place in places) {
      markers.add(Marker(
          markerId: MarkerId(place['reference']),
          position: LatLng(place['geometry']['location']['lat'],
              place['geometry']['location']['lng']),
          infoWindow:
              InfoWindow(title: place['name'], snippet: place['vicinity'])));
    }
    setState(() {
      markers = markers;
    });
  }
}
