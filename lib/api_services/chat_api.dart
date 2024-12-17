import 'package:chat_app/api_services/api_services.dart';
import 'package:chat_app/helper/end_points.dart';
import 'package:chat_app/helper/localstorage.dart';
import 'package:chat_app/models/Login_model.dart';
import 'package:chat_app/models/UserChat_model.dart';

class ChatApiServices {
  Future<List<UserChatModel>> fetchMessages(int recipient_id) async {
    User user = await LocalstorageService.getUser();
    var res = await ApiServices.getRequest(
      endPoint:
          "${ApiEndPoints.messages}?sender_id=${user.id}&recipient_id=$recipient_id",
      headers: {
        "Authorization": "Bearer ${await LocalstorageService.getToken()}",
      },
    );
    List<UserChatModel> msgList = userChatModelFromJson(res.body);
    return msgList;
  }

  saveMessage() async {
    await ApiServices.postRequest(
      endPoint: ApiEndPoints.messages,
      headers: {
        "Authorization": "Bearer ${await LocalstorageService.getToken()}",
      },
      body: {},
    );
  }
}
