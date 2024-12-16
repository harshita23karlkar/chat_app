import 'package:chat_app/widgets/profilecircle.dart';
import 'package:flutter/material.dart';

class UserProfileBar extends StatelessWidget implements PreferredSizeWidget {
  const UserProfileBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shadowColor: Colors.grey,
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ProfileCircle(size: 10, camSize: 8, onTapAction: () {}),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(70);
}
