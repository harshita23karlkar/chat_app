import 'package:flutter/material.dart';

class UserProfileBar extends StatelessWidget implements PreferredSizeWidget {
  const UserProfileBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 242, 96, 247),
      shadowColor: Colors.grey,
      leading: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: CircleAvatar(
          radius: 16,
          child: Icon(Icons.person),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
