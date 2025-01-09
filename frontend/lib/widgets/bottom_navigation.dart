import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  final Function(int) onItemSelected;

  const BottomNavigation({Key? key, required this.onItemSelected, required int currentIndex}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  // Define gradient colors for each nav item
  final List<List<Color>> _itemGradients = [
    [Color(0xFF4158D0), Color(0xFFC850C0)], // Home
    [Color(0xFF43E97B), Color(0xFF38F9D7)], // Video
    [Color(0xFFFA709A), Color(0xFFFF9472)], // Profile
    [Color(0xFF4E65FF), Color(0xFF92EFFD)], // Work
    [Color(0xFFF6D242), Color(0xFFFF52E5)], // Chat
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white.withOpacity(0.9), Colors.white.withOpacity(0.9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 15,
            offset: Offset(0, 5),
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(Icons.home_rounded, 0),
          _buildNavItem(Icons.video_library_rounded, 1),
          _buildNavItem(Icons.person_rounded, 2),
          _buildNavItem(Icons.work_rounded, 3),
          _buildNavItem(Icons.chat_rounded, 4),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    bool isSelected = _selectedIndex == index;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
          widget.onItemSelected(index);
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: isSelected
              ? LinearGradient(
                  colors: _itemGradients[index],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
        ),
        child: AnimatedScale(
          scale: isSelected ? 1.2 : 1.0,
          duration: Duration(milliseconds: 300),
          child: AnimatedRotation(
            turns: isSelected ? 0.05 : 0,
            duration: Duration(milliseconds: 300),
            child: Icon(
              icon,
              color: isSelected ? Colors.white : Colors.grey.shade600,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
}