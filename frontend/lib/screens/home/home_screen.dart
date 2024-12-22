import 'package:flutter/material.dart';
import 'package:app_01/widgets/bottom_navigation.dart';
import 'package:app_01/widgets/top_navigation_bar.dart';
import 'package:app_01/screens/home/video_screen.dart';
import 'package:app_01/screens/home/profile_screen.dart';
import 'package:app_01/screens/home/careers_screen.dart';
import 'package:app_01/screens/home/chat_screen.dart'; // Import ChatScreen

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // List of screens to correspond with bottom navigation
  final List<Widget> _screens = [
    HomeContent(),
    VideoScreen(),
    ProfileScreen(),
    CareersScreen(),
    ChatScreen(), // Use ChatScreen from chat_screen.dart
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavigationBar(),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigation(
        onItemSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

// Placeholder screens (you'll need to create these in their respective files)
class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Home Screen",
        style: TextStyle(
          fontSize: 24,
          color: Colors.blue,
        ),
      ),
    );
  }
}