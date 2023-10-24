import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:neighbour_bazaar/dashboard.dart';

import 'home_screen.dart';

class UserLocation extends StatefulWidget {

  const UserLocation({Key? key}) : super(key: key);
  @override
  _HomepageState createState() => _HomepageState();
}
class _HomepageState extends State<UserLocation> {
  String location = 'Null, Press Button';
  String Address = 'search';

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    Address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place
        .postalCode}, ${place.country}';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Navigate back to the HomeScreen when the back button is pressed
        //Get.to(() => HomeScreen());
        Get.to(()=>Dashboard());
        return true; // Allow the back button press
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Coordinates Points', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Text(location, style: TextStyle(color: Colors.black, fontSize: 16),),
              SizedBox(height: 10,),
              Text('ADDRESS', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Text('${Address}'),
              ElevatedButton(onPressed: () async {
                Position position = await _getGeoLocationPosition();
                location = 'Lat: ${position.latitude} , Long: ${position.longitude}';
                GetAddressFromLatLong(position);
              }, child: Text('Get Location'))
            ],
          ),
        ),
      ),
    );
    // return Scaffold(
    //
    //   body: Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         Text('Coordinates Points',
    //           style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
    //         SizedBox(height: 10,),
    //         Text(
    //           location, style: TextStyle(color: Colors.black, fontSize: 16),),
    //         SizedBox(height: 10,),
    //         Text('ADDRESS',
    //           style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
    //         SizedBox(height: 10,),
    //         Text('${Address}'),
    //         ElevatedButton(onPressed: () async {
    //           Position position = await _getGeoLocationPosition();
    //           location =
    //           'Lat: ${position.latitude} , Long: ${position.longitude}';
    //           GetAddressFromLatLong(position);
    //         }, child: Text('Get Location'))
    //       ],
    //     ),
    //   ),
    // );
  }
}