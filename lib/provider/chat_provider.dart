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

  Future<bool> deleteMessageFromChat(int msgId, int userId) async {
    await ChatApiServices().deleteMessage(msgId, userId);
    messagesList.removeWhere((message) => message.id == msgId);
    notifyListeners();
    return true;
  }
}
