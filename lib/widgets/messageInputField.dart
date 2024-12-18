import 'package:chat_app/provider/chat_provider.dart';
import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageInputField extends StatelessWidget {
  final int recipientId;
  const MessageInputField({super.key, required this.recipientId});

  @override
  Widget build(BuildContext context) {
    return MessageBar(
      messageBarColor: const Color.fromARGB(255, 34, 33, 33),
      sendButtonColor: const Color.fromARGB(255, 252, 252, 252),
      onSend: (value) {
        context.read<ChatProvider>().saveMessage(recipientId, value);
      },
      actions: [
        InkWell(
          child: const Icon(
            Icons.emoji_emotions_outlined,
            color: Color.fromARGB(255, 253, 252, 252),
            size: 24,
          ),
          onTap: () {},
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: InkWell(
            child: const Icon(
              Icons.add,
              color: Color.fromARGB(255, 255, 255, 255),
              size: 24,
            ),
            onTap: () {
              //  add icon
            },
          ),
        ),
      ],
    );
  }
}
