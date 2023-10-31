import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dashboard.dart';
class usernameSingleton {
  static final usernameSingleton _instance = usernameSingleton._internal();

  factory usernameSingleton() {
    return _instance;
  }

  usernameSingleton._internal();

  String _email='';

  String get email => _email;

  set email(String value) {
    _email = value;
  }
}
