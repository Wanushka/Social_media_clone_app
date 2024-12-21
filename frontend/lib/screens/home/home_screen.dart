import 'package:flutter/material.dart';
import 'package:app_01/widgets/bottom_navigation.dart';
import 'package:app_01/widgets/top_navigation_bar.dart';

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
    ChatScreen(),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Welcome to Home",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF6A11CB),
            ),
          ),
          SizedBox(height: 20),
          Text(
            "Explore and discover amazing features",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class VideoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Video Screen",
        style: TextStyle(
          fontSize: 24,
          color: Colors.green,
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Profile Screen",
        style: TextStyle(
          fontSize: 24,
          color: Colors.purple,
        ),
      ),
    );
  }
}

class CareersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Careers Screen",
        style: TextStyle(
          fontSize: 24,
          color: Colors.orange,
        ),
      ),
    );
  }
}

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Chat Screen",
        style: TextStyle(
          fontSize: 24,
          color: Colors.red,
        ),
      ),
    );
  }
}