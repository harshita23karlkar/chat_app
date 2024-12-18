import 'package:chat_app/api_services/chat_api.dart';
import 'package:chat_app/models/UserChat_model.dart';
import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  List<UserChatModel> messagesList = [];
  Future<void> fetchMessagesList(int recipientId) async {
    messagesList = await ChatApiServices().fetchMessages(recipientId);
    notifyListeners();
  }

  Future<void> saveMessage(int recipientId, String content) async {
    UserChatModel userChatModel =
        await ChatApiServices().saveMessage(recipientId, content);
    messagesList.add(userChatModel);
    notifyListeners();
  }

  deleteMessageFromChat(int msgId) async {
    await ChatApiServices().deleteMessage(msgId);
    for (int i = 0; i < messagesList.length; i++) {
      messagesList.removeWhere((messagesList[i].id == msgId) as bool Function(
          UserChatModel element));
    }
  }
}
