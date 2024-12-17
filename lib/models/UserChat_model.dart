// To parse this JSON data, do
//
//     final userChatModel = userChatModelFromJson(jsonString);

import 'dart:convert';

List<UserChatModel> userChatModelFromJson(String str) =>
    List<UserChatModel>.from(
        json.decode(str).map((x) => UserChatModel.fromJson(x)));

String userChatModelToJson(List<UserChatModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserChatModel {
  int id;
  String content;
  int senderId;
  int recipientId;
  dynamic roomId;
  SenderInfo senderInfo;

  UserChatModel({
    required this.id,
    required this.content,
    required this.senderId,
    required this.recipientId,
    required this.roomId,
    required this.senderInfo,
  });

  factory UserChatModel.fromJson(Map<String, dynamic> json) => UserChatModel(
        id: json["id"],
        content: json["content"],
        senderId: json["sender_id"],
        recipientId: json["recipient_id"],
        roomId: json["room_id"],
        senderInfo: SenderInfo.fromJson(json["sender_info"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "content": content,
        "sender_id": senderId,
        "recipient_id": recipientId,
        "room_id": roomId,
        "sender_info": senderInfo.toJson(),
      };
}

class SenderInfo {
  dynamic id;
  String name;
  String email;

  SenderInfo({
    required this.id,
    required this.name,
    required this.email,
  });

  factory SenderInfo.fromJson(Map<String, dynamic> json) => SenderInfo(
        id: json["id"],
        name: json["name"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
      };
}
