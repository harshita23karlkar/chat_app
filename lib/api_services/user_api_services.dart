import 'package:chat_app/api_services/api_services.dart';
import 'package:chat_app/helper/end_points.dart';
import 'package:chat_app/helper/localstorage.dart';
import 'package:chat_app/models/Login_model.dart';
import 'package:chat_app/models/UserSignup_model.dart';

class UserApiServices {
  userSignUp(String name, String email, String password) async {
    var credentials = {
      "name": name,
      "email": email,
      "password": password,
    };
    var res = await ApiServices.postRequest(
        endPoint: ApiEndPoints.signup,
        headers: {"Content-Type": "application/json"},
        body: credentials);
    return userSignUpFromJson(res.body);
  }

  userLogin(String username, String password) async {
    bool isLoggedIn = false;
    var credentials = {"email": username, "password": password};
    var res = await ApiServices.postRequest(
        endPoint: ApiEndPoints.signin,
        headers: {"Content-Type": "application/json"},
        body: credentials);
    var result = loginModelFromJson(res.body);
    var isSaved = await LocalstorageService.setToken(result.token);
    if (isSaved) {
      isLoggedIn = true;
    } else {
      isLoggedIn = false;
    }
    return isLoggedIn;
  }
}
