import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neighbour_bazaar/InternalSetup/UploadPost.dart';
import 'package:neighbour_bazaar/UserLocation/addressReturner.dart';
import 'package:neighbour_bazaar/dashboard.dart';

class ShowUserLocation2 extends StatefulWidget {
  final XFile? selectedImage; // Assuming you're using XFile from image_picker

  ShowUserLocation2({required this.selectedImage});


  @override
  _ShowUserLocationState2 createState() => _ShowUserLocationState2();
}

class _ShowUserLocationState2 extends State<ShowUserLocation2> {
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
    print('Updated Address: $Address');
    AddressReturner addressReturner = AddressReturner(initialAddress: Address);
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.to(() => UploadPost(selectedImage: widget.selectedImage));
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
