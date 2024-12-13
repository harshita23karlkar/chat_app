import 'package:flutter/material.dart';

class ProfileCircle extends StatelessWidget {
  final double size;
  final VoidCallback onTapAction;
  const ProfileCircle(
      {super.key, required this.size, required this.onTapAction});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey[800],
          child: Icon(
            Icons.person,
            size: size,
            color: Colors.white,
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: () {
              onTapAction();
            },
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.purple[200],
              child: Icon(Icons.camera_alt),
            ),
          ),
        ),
      ],
    );
  }
}
