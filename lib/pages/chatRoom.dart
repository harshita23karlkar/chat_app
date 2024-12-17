import 'package:chat_app/helper/localstorage.dart';
import 'package:chat_app/models/UserChat_model.dart';
import 'package:chat_app/widgets/messageInputField.dart';
import 'package:chat_app/widgets/userProfileBar.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final List<UserChatModel> messagesList;
  final int userid;
  final String username;

  const ChatScreen(
      {super.key,
      required this.messagesList,
      required this.userid,
      required this.username});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    List<UserChatModel> list = widget.messagesList;
    LocalstorageService.getUser();

    // Screen start
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: UserProfileBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: list.length,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              itemBuilder: (context, index) {
                final message = list[index];
                final isMe = message.senderId == widget.userid;

                return Row(
                  mainAxisAlignment:
                      isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 14),
                      decoration: BoxDecoration(
                        color: isMe
                            ? Color.fromARGB(255, 153, 55, 156)
                            : Colors.grey.shade800,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(10),
                          topRight: const Radius.circular(10),
                          bottomLeft:
                              isMe ? const Radius.circular(10) : Radius.zero,
                          bottomRight:
                              isMe ? Radius.zero : const Radius.circular(10),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isMe ? "You" : message.senderInfo.name,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            message.content,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          messageInputField(),
        ],
      ),
    );
  }
}
