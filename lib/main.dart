import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:neighbour_bazaar/auth_controller.dart';
import 'package:neighbour_bazaar/login_page.dart';
import 'package:neighbour_bazaar/signup_page.dart';
import 'package:neighbour_bazaar/user_location.dart';
import 'package:neighbour_bazaar/welcome_page.dart';

import 'dashboard.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) => Get.put(AuthController()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'neighbour_bazaar',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
       //home: Homepage(),
        home:  LoginPage()
    );
  }
}

