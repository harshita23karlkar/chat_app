import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final VoidCallback onTapAction;
  final String title;
  const AuthButton({super.key, required this.onTapAction, required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // await UserApiServices().userSignUp(username, userEmail, userPassword);
        onTapAction();
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 209, 70, 214),
              Color.fromARGB(255, 224, 183, 230)
            ], // Green gradient
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
