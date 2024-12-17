import 'dart:convert';

import 'package:chat_app/auth/env_var.dart';
import 'package:chat_app/models/Login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalstorageService {
  static Future<bool> setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool res = await prefs.setString(UserToken.tokenKey, token);
    return res;
  }

  static setUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool res = await prefs.setString("user", jsonEncode(user.toJson()));
    return res;
  }

  static Future<User> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user = prefs.getString("user");
    return User.fromJson(jsonDecode(user!));
  }

  static getToken() async {
    String? token;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString(UserToken.tokenKey);
    return token;
  }
}
