import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  final Function(int) onItemSelected;

  const BottomNavigation({Key? key, required this.onItemSelected}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -2),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
              widget.onItemSelected(index);
            });
          },
          type: BottomNavigationBarType.shifting,
          selectedItemColor: Color(0xFF6A11CB),
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          items: [
            _buildNavItem(
              icon: Icons.home_rounded,
              label: 'Home',
              color: Colors.blue,
            ),
            _buildNavItem(
              icon: Icons.video_library_rounded,
              label: 'Videos',
              color: Colors.green,
            ),
            _buildNavItem(
              icon: Icons.person_rounded,
              label: 'Profile',
              color: Colors.purple,
            ),
            _buildNavItem(
              icon: Icons.work_rounded,
              label: 'Careers',
              color: Colors.orange,
            ),
            _buildNavItem(
              icon: Icons.chat_rounded,
              label: 'Chat',
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return BottomNavigationBarItem(
      icon: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: _selectedIndex == getIndex(label) 
              ? color.withOpacity(0.2) 
              : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Icon(
          icon,
          size: _selectedIndex == getIndex(label) ? 28 : 24,
          color: _selectedIndex == getIndex(label) 
              ? color 
              : Colors.grey,
        ),
      ),
      label: label,
    );
  }

  int getIndex(String label) {
    switch (label) {
      case 'Home':
        return 0;
      case 'Videos':
        return 1;
      case 'Profile':
        return 2;
      case 'Careers':
        return 3;
      case 'Chat':
        return 4;
      default:
        return 0;
    }
  }
}