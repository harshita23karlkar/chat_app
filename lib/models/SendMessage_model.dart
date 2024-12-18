import 'dart:convert';

import 'package:chat_app/models/UserChat_model.dart';

SendMessageModel sendMessageModelFromJson(String str) =>
    SendMessageModel.fromJson(json.decode(str));

String sendMessageModelToJson(SendMessageModel data) =>
    json.encode(data.toJson());

class SendMessageModel {
  String message;
  UserChatModel data;

  SendMessageModel({
    required this.message,
    required this.data,
  });

  factory SendMessageModel.fromJson(Map<String, dynamic> json) =>
      SendMessageModel(
        message: json["message"],
        data: UserChatModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
      };
}
