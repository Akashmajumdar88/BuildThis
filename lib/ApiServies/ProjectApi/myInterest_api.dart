import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../Model/projectModel.dart';
import '../../Utils/shared_prefernces.dart';
import '../url_management.dart';

class MyInterestApiServices extends GetxController {

  RxList<MyInterestModel> getMyInterestReList = <MyInterestModel>[].obs;
  RxList<MyInterestSendModel> getMyInterestSendList = <MyInterestSendModel>[].obs;
  RxBool isLoading = false.obs;
  final _getUserDetail = UserLoginDetails();

  Future<void> getMyInterestApiService() async {
    try {
      getMyInterestReList.clear();
      isLoading.value = true;
      var token = await _getUserDetail.getUserData('token');
      var headers = {
        'authorization': 'Bearer $token'
      };
      var request = http.Request('GET', Uri.parse(ApiEndpoint.myShowInterestEndPoint));
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      var responseJson = await response.stream.bytesToString();
      var responseDecode = json.decode(responseJson);
      if (response.statusCode == 200) {
        List allData = responseDecode['data'];
        for (var element in allData) {
          getMyInterestReList.add(MyInterestModel(
              id: element['upaId'] ?? "",
              projectName: element['project_name'] ?? "",
              status: element['status'] ?? "",
              email: element['email'] ?? "",
              fullName: element['full_name'] ?? "",
               phone: element['phone'] ?? "",
               senderId: element['senderId'] ?? "",
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

  Future<void> getMyInterestSendApiService() async {
    try {
      getMyInterestSendList.clear();
      isLoading.value = true;
      var token = await _getUserDetail.getUserData('token');
      var headers = {
        'authorization': 'Bearer $token'
      };
      var request = http.Request('GET', Uri.parse(ApiEndpoint.myShowInterestSendEndPoint));
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      var responseJson = await response.stream.bytesToString();
      var responseDecode = json.decode(responseJson);
      if (response.statusCode == 200) {
        List allData = responseDecode['data'];
        for (var element in allData) {
          getMyInterestSendList.add(MyInterestSendModel(
            id: element['upaId'] ?? "",
            projectName: element['project_name'] ?? "",
            status: element['status'] ?? "",
            email: element['email'] ?? "",
            fullName: element['full_name'] ?? "",
            phone: element['phone'] ?? "",
            senderId: element['senderId'] ?? "",
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