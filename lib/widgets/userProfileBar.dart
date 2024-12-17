import 'package:chat_app/widgets/profilecircle.dart';
import 'package:flutter/material.dart';

class UserProfileBar extends StatelessWidget implements PreferredSizeWidget {
  const UserProfileBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 241, 131, 245),
      shadowColor: Colors.grey,
      leading: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: const CircleAvatar(
          radius: 16,
          child: Icon(Icons.person),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(60);
}
