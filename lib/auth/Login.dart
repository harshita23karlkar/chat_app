import 'package:chat_app/api_services/user_api_services.dart';
import 'package:chat_app/pages/HomePage.dart';
import 'package:chat_app/widgets/authbutton.dart';
import 'package:chat_app/widgets/profilecircle.dart';
import 'package:chat_app/widgets/textField.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ProfileCircle(
                size: 50,
                onTapAction: () {
                  print("logged in");
                }),
            const SizedBox(height: 20),
            CustomTextField(
                label: "Email",
                icon: Icons.email,
                hintText: "Enter your email..",
                isPassword: false,
                controller: emailController),
            const SizedBox(height: 20),
            CustomTextField(
                label: "Password",
                icon: Icons.password,
                hintText: "Enter your password",
                isPassword: true,
                controller: passwordController),
            const SizedBox(height: 20),
            AuthButton(
                title: "Login",
                onTapAction: () async {
                  bool res = await UserApiServices()
                      .userLogin(emailController.text, passwordController.text);
                  if (res) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Homepage(),
                      ),
                    );
                  }
                  print("logged in");
                })
          ],
        ),
      ),
    );
  }
}
