// To parse this JSON data, do
//
//     final usersListModel = usersListModelFromJson(jsonString);

import 'dart:convert';

List<UsersListModel> usersListModelFromJson(String str) =>
    List<UsersListModel>.from(
        json.decode(str).map((x) => UsersListModel.fromJson(x)));

String usersListModelToJson(List<UsersListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UsersListModel {
  int id;
  String name;
  String? socketId;
  String email;
  String password;

  UsersListModel({
    required this.id,
    required this.name,
    required this.socketId,
    required this.email,
    required this.password,
  });

  factory UsersListModel.fromJson(Map<String, dynamic> json) => UsersListModel(
        id: json["id"],
        name: json["name"],
        socketId: json["socket_id"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "socket_id": socketId,
        "email": email,
        "password": password,
      };
}
