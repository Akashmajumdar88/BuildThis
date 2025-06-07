
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../Model/projectModel.dart';
import '../../Utils/shared_prefernces.dart';
import '../url_management.dart';

class MyInviteApiServices extends GetxController {

  RxList<MyInviteModel> getMyInviteList = <MyInviteModel>[].obs;
  RxList<MyInviteSendModel> getMyInviteSendList = <MyInviteSendModel>[].obs;
  RxBool isLoading = false.obs;
  final _getUserDetail = UserLoginDetails();

  Future<void> getMyInviteApiServiceReceive() async {
    try {
      getMyInviteList.clear();
      isLoading.value = true;
      var token = await _getUserDetail.getUserData('token');
      var headers = {
        'authorization': 'Bearer $token'
      };
      var request = http.Request('GET', Uri.parse(ApiEndpoint.myInviteReEndPoint));
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      var responseJson = await response.stream.bytesToString();
      var responseDecode = json.decode(responseJson);
      if (response.statusCode == 200) {
        List allData = responseDecode['data'];
        for (var element in allData) {
          getMyInviteList.add(MyInviteModel(
              id: element['id'] ?? "",
              senderId: element['senderId'] ?? "",
              projectName: element['project_name'] ?? "",
              projectOwnerName: element['project_owner_name'] ?? "",
              invitedDate: element['invitedDate'] ?? "",
              status: element['status'] ?? ""
          ));
        }
        isLoading.value = false;
      } else {
        isLoading.value = false;
      }
    } catch (e) {
      print(e);
      isLoading.value = false;
    }
  }

  Future<void> getMyInviteSendApiService() async {
    try {
      getMyInviteSendList.clear();
      isLoading.value = true;
      var token = await _getUserDetail.getUserData('token');
      var headers = {
        'authorization': 'Bearer $token'
      };
      var request = http.Request('GET', Uri.parse(ApiEndpoint.myInviteSendEndPoint));
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      var responseJson = await response.stream.bytesToString();
      var responseDecode = json.decode(responseJson);
      if (response.statusCode == 200) {
        List allData = responseDecode['data'];
        for (var element in allData) {
          getMyInviteSendList.add(MyInviteSendModel(
              id: element['upaId'] ?? "",
              senderId: element['senderId'] ?? "",
              projectName: element['project_name'] ?? "",
              projectOwnerName: element['full_name'] ?? "",
              invitedDate: element['invitedDate'] ?? "",
              status: element['status'] ?? ""
          ));
        }
        isLoading.value = false;
      } else {
        isLoading.value = false;
      }
    } catch (e) {
      print(e);
      isLoading.value = false;
    }
  }
}