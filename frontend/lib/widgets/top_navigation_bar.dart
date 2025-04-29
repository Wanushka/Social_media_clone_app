import 'package:flutter/material.dart';

class TopNavigationBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false, // Add this line
      title: Text("SocialMedi"),
      actions: [IconButton(icon: Icon(Icons.settings), onPressed: () => Navigator.pushNamed(context, '/settings'))],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}