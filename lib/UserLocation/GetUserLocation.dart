import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:neighbour_bazaar/UserLocation/addressReturner.dart';
import 'package:neighbour_bazaar/dashboard.dart';

class ShowUserLocation extends StatefulWidget {
  const ShowUserLocation({Key? key}) : super(key: key);


  @override
  _ShowUserLocationState createState() => _ShowUserLocationState();
}

class _ShowUserLocationState extends State<ShowUserLocation> {
  String location = 'Loading...'; // Default message while loading
  String Address = 'search';
  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await _getGeoLocationPosition();
      location = 'Lat: ${position.latitude}, Long: ${position.longitude}';
      GetAddressFromLatLong(position);
      AddressReturner addressReturner = AddressReturner(initialAddress: Address);

    } catch (e) {
      location = 'Error getting location: $e';
    }
  }

  Future<Position> _getGeoLocationPosition() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude, position.longitude);
    Placemark place = placemarks[0];
    Address = '${place.subLocality},${place.locality},${place.country}';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.to(() => Dashboard());
        return true; // Allow the back button press
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Coordinates Points', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10,),
              Text(location, style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              SizedBox(height: 10,),
              Text('ADDRESS', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10,),
              Text('${Address}'),
            ],
          ),
        ),
      ),
    );
  }
}
