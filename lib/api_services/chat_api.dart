import 'package:chat_app/api_services/api_services.dart';
import 'package:chat_app/helper/end_points.dart';
import 'package:chat_app/helper/localstorage.dart';
import 'package:chat_app/models/Login_model.dart';
import 'package:chat_app/models/SendMessage_model.dart';
import 'package:chat_app/models/UserChat_model.dart';

class ChatApiServices {
  Future<List<UserChatModel>> fetchMessages(int recipientId) async {
    User user = await LocalstorageService.getUser();
    var res = await ApiServices.getRequest(
      endPoint:
          "${ApiEndPoints.messages}?sender_id=${user.id}&recipient_id=$recipientId",
      headers: {
        "Authorization": "Bearer ${await LocalstorageService.getToken()}",
      },
    );
    List<UserChatModel> msgList = userChatModelFromJson(res.body);
    return msgList;
  }

// to add to sended message in database
  Future<UserChatModel> saveMessage(int recipientId, String content) async {
    User user = await LocalstorageService.getUser();
    var credentials = {
      "sender_id": "$recipientId",
      "recipient_id": "${user.id}",
      "content": content,
      "sender_info": {
        "id": "${user.id}",
        "name": user.name,
        "email": user.email
      }
    };
    var res = await ApiServices.postRequest(
      endPoint: ApiEndPoints.messages,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${await LocalstorageService.getToken()}",
      },
      body: credentials,
    );
    SendMessageModel responseData = sendMessageModelFromJson(res.body);
    return responseData.data;
  }

  deleteMessage(int msgId, int userId) async {
    User user = await LocalstorageService.getUser();
    var credentials = {"id": "$msgId", "sender_id": "$userId"};
    print("message id = $msgId  and senderId = ${userId}");
    var res = ApiServices.deleteRequest(
        endPoint: ApiEndPoints.messages,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${await LocalstorageService.getToken()}",
        },
        body: credentials);
  }
}
