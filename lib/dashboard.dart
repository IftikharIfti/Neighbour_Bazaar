import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:neighbour_bazaar/ChatPage/chatpageui.dart';
import 'package:neighbour_bazaar/Notification/notificationpage.dart';
import 'package:neighbour_bazaar/home_screen.dart';
import 'package:neighbour_bazaar/settings_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  void initState() {
    super.initState();
    _checkAndTriggerNotification();
  }
  Future<void> _checkAndTriggerNotification() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool notificationTriggered = prefs.getBool('notificationTriggered') ?? false;

    if (!notificationTriggered) {
      triggerNotification();
      prefs.setBool('notificationTriggered', true);
    }
  }
  void triggerNotification() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel',
        title: 'Hello Brother',
        body: 'Hellooooo',
      ),
    );
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
        return NotificationPage();
      case 2:
        return ChatScreen();
      case 3:
        return SettingsScreen();
      default:
        return HomeScreen();
    }
  }
}
