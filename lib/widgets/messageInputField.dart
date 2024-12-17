// Message Input Field
import 'package:flutter/material.dart';

Widget messageInputField() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    color: Colors.grey.shade900,
    child: Row(
      children: [
        IconButton(
          icon: const Icon(Icons.emoji_emotions_outlined, color: Colors.white),
          onPressed: () {},
        ),
        Expanded(
          child: TextField(
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Type a message...",
              hintStyle: TextStyle(color: Colors.white70),
              filled: true,
              fillColor: Colors.grey.shade800,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        const CircleAvatar(
          backgroundColor: Color.fromARGB(255, 241, 131, 245),
          radius: 22,
          child: Icon(Icons.send, color: Colors.white),
        ),
      ],
    ),
  );
}
