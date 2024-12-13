import 'package:chat_app/auth/env_var.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalstorageService {
  static Future<bool> setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool res = await prefs.setString(UserToken.tokenKey, token);
    return res;
  }

  static getToken() async {
    String? token;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString(UserToken.tokenKey);
    return token;
  }
}
