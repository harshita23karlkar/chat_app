// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;

// class ChatPage extends StatefulWidget {
//   @override
//   _ChatPageState createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {
//   late IO.Socket socket;
//   final StreamController<List<Message>> _messageStreamController =
//       StreamController<List<Message>>.broadcast();

//   List<Message> _messages = []; // Local message storage

//   @override
//   void initState() {
//     super.initState();
//     initializeSocket();
//   }

//   void initializeSocket() {
//     // Replace 'http://your-server-url' with your backend Socket.IO URL
//     socket = IO.io('http://your-server-url', <String, dynamic>{
//       'transports': ['websocket'],
//       'autoConnect': true,
//     });

//     // Connect to the server
//     socket.onConnect((_) {
//       print('Connected to the server');
//     });

//     // Listen for incoming messages
//     socket.on('message', (data) {
//       final newMessage = Message(
//         sender: data['sender'],
//         text: data['text'],
//         timestamp: DateTime.parse(data['timestamp']),
//       );
//       _addMessage(newMessage);
//     });

//     // Handle disconnection
//     socket.onDisconnect((_) => print('Disconnected from the server'));
//   }

//   void _addMessage(Message message) {
//     _messages.add(message);
//     _messageStreamController.add(_messages); // Add updated list to stream
//   }

//   void _sendMessage(String text) {
//     final message = {
//       'sender': 'You',
//       'text': text,
//       'timestamp': DateTime.now().toIso8601String(),
//     };
//     socket.emit('message', message); // Send message to server
//     _addMessage(Message(
//       sender: message['sender'],
//       text: message['text'],
//       timestamp: DateTime.parse(message['timestamp']),
//     ));
//   }

//   @override
//   void dispose() {
//     socket.dispose(); // Dispose the socket connection
//     _messageStreamController.close(); // Close the stream
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Chat App"),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: StreamBuilder<List<Message>>(
//               stream: _messageStreamController.stream,
//               initialData: _messages,
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                   return const Center(
//                     child: Text("No messages yet"),
//                   );
//                 }

//                 final messages = snapshot.data!;
//                 return ListView.builder(
//                   reverse: true, // Show the newest messages at the bottom
//                   itemCount: messages.length,
//                   itemBuilder: (context, index) {
//                     final message = messages[index];
//                     final isMe = message.sender == 'You';
//                     return Align(
//                       alignment:
//                           isMe ? Alignment.centerRight : Alignment.centerLeft,
//                       child: Container(
//                         margin: const EdgeInsets.symmetric(
//                             horizontal: 8.0, vertical: 4.0),
//                         padding: const EdgeInsets.all(12.0),
//                         decoration: BoxDecoration(
//                           color: isMe ? Colors.blue : Colors.grey[300],
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             if (!isMe)
//                               Text(
//                                 message.sender,
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 12,
//                                 ),
//                               ),
//                             Text(
//                               message.text,
//                               style: const TextStyle(fontSize: 16),
//                             ),
//                             Text(
//                               "${message.timestamp.hour}:${message.timestamp.minute}",
//                               style: TextStyle(
//                                 fontSize: 10,
//                                 color: Colors.grey[700],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     decoration: const InputDecoration(
//                       hintText: "Enter your message",
//                       border: OutlineInputBorder(),
//                     ),
//                     onSubmitted: (text) {
//                       if (text.isNotEmpty) {
//                         _sendMessage(text);
//                       }
//                     },
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.send),
//                   onPressed: () {
//                     // Trigger the send message functionality
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }




/*
import 'package:flutter/material.dart';
class ChatScreen extends StatefulWidget {
  final String userId; // Current user ID
  final String recipientId; // ID of the user being chatted with

  const ChatScreen({
    Key? key,
    required this.userId,
    required this.recipientId,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late SocketService _socketService;
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = []; // Local message list

  @override
  void initState() {
    super.initState();
    _socketService = SocketService();
    _socketService.initSocket(widget.userId);

    // Listen for incoming messages
    _socketService.messageStream.listen((message) {
      setState(() {
        _messages.add(message);
      });
    });
  }

  @override
  void dispose() {
    _socketService.closeSocket();
    super.dispose();
  }

  void _sendMessage() {
    final content = _messageController.text.trim();
    if (content.isNotEmpty) {
      _socketService.sendPrivateMessage(
        widget.userId,
        widget.recipientId,
        content,
      );
      setState(() {
        _messages.add({
          "sender_id": widget.userId,
          "content": content,
        });
      });
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Private Chat"),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isMe = message["sender_id"] == widget.userId;

                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 5, horizontal: 10),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isMe ? Colors.teal.shade700 : Colors.grey.shade800,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      message["content"] ?? "",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
          _buildInputField(),
        ],
      ),
    );
  }

  Widget _buildInputField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      color: Colors.grey.shade900,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Type a message...",
                hintStyle: const TextStyle(color: Colors.white70),
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
          CircleAvatar(
            backgroundColor: Colors.teal.shade700,
            radius: 22,
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: _sendMessage,
            ),
          ),
        ],
      ),
    );
  }
}
*/