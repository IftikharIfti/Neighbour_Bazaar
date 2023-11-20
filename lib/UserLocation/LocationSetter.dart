import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:neighbour_bazaar/UserLocation/AddressSingleton.dart';

import 'addressReturner.dart';

class LocationSetter {

  String location = 'Loading...'; // Default message while loading
  String Address = 'search';
  Future<void> getCurrentLocation() async {
    try {
      Position position = await getGeoLocationPosition();
      location = 'Lat: ${position.latitude}, Long: ${position.longitude}';
      GetAddressFromLatLong(position);

    } catch (e) {
      location = 'Error getting location: $e';
    }
  }

  Future<Position> getGeoLocationPosition() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude, position.longitude);
    Placemark place = placemarks[0];
    Address = '${place.subLocality},${place.locality},${place.country}';

    addressSingleton().address=Address;
  }
}
