import 'package:chat_app/widgets/bottom_navbar.dart';
import 'package:chat_app/widgets/createRoom.dart';
import 'package:chat_app/widgets/userProfileBar.dart';

import 'package:chat_app/widgets/usersList.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/api_services/user_api_services.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UserProfileBar(),
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: UserApiServices().fetchUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return Stack(
              children: [
                ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final user = snapshot.data![index];
                    return UserListW(user: user);
                  },
                ),
                Positioned(bottom: 20, right: 20, child: Createroom())
              ],
            );
          }
          return const Center(child: Text("No users found"));
        },
      ),
      bottomNavigationBar: BottomNavbar(),
    );
  }
}
