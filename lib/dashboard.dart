import 'package:flutter/material.dart';
import 'package:neighbour_bazaar/home_screen.dart';
import 'package:neighbour_bazaar/video_screen.dart';
import 'package:neighbour_bazaar/settings_screen.dart';
import 'package:neighbour_bazaar/message_screen.dart';

import 'custom_navigation_bar.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Neighbour Bazaar'),
      ),
      body: _buildCurrentScreen(_currentIndex),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }

  Widget _buildCurrentScreen(int index) {
    switch (index) {
      case 0:
        return HomeScreen();
      case 1:
        return VideoScreen();
      case 2:
        return MessagesScreen();
      case 3:
        return SettingsScreen();
      default:
        return HomeScreen();
    }
  }
}
