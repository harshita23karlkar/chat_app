import 'package:chat_app/models/usersList_model.dart';
import 'package:chat_app/pages/chatRoom.dart';
import 'package:chat_app/provider/chat_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserListW extends StatelessWidget {
  final UsersListModel user;
  const UserListW({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 51, 50, 50),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 109, 108, 108).withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Consumer<ChatProvider>(
          builder: (context, value, child) => ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: Stack(
              children: [
                CircleAvatar(
                  radius: 28,
                  child: Text(user.name[0].toUpperCase()),
                  // backgroundImage:
                  //     NetworkImage(""),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ],
            ),
            title: Text(
              user.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              "Last message here...",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Text(
              "2:45 PM",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[500],
              ),
            ),
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ChatScreen(userid: user.id, username: user.name),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
