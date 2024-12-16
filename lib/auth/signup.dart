import 'package:chat_app/api_services/user_api_services.dart';
import 'package:chat_app/pages/HomePage.dart';
import 'package:chat_app/widgets/authbutton.dart';
import 'package:chat_app/widgets/profilecircle.dart';
import 'package:chat_app/widgets/textField.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String username, userEmail, userPassword;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // profile ke liye
            ProfileCircle(
                camSize: 20,
                size: 50,
                onTapAction: () {
                  print("profile pic");
                }),
            const SizedBox(height: 20),
            CustomTextField(
                label: "name",
                icon: Icons.person,
                hintText: "Enter your name..",
                isPassword: false,
                controller: nameController),
            const SizedBox(height: 20),
            CustomTextField(
                label: "Email",
                icon: Icons.email,
                hintText: "Enter your Email..",
                isPassword: false,
                controller: emailController),
            const SizedBox(height: 20),
            CustomTextField(
                label: "Password",
                icon: Icons.password,
                hintText: "Enter your password..",
                isPassword: true,
                controller: passwordController),
            const SizedBox(height: 20),
            AuthButton(
              title: "Sign-up",
              onTapAction: () async {
                username = nameController.text;
                userEmail = emailController.text;
                userPassword = passwordController.text;
                await UserApiServices()
                    .userSignUp(username, userEmail, userPassword);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Homepage(),
                    ));
              },
            )
          ],
        ),
      ),
    );
  }
}
