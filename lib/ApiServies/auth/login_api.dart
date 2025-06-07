import 'dart:convert';
import 'package:get/get.dart';
import '../../Routes/routes.dart';
import '../../Screens/dashboard.dart';
import '../../Utils/commonStyles.dart';
import '../../Utils/commonToast.dart';
import '../../Utils/shared_prefernces.dart';
import '../url_management.dart';
import 'package:http/http.dart' as http;

class LoginApiService extends GetxController{
  RxBool isLoading = false.obs;
  final _getUserDetail = UserLoginDetails();
  String userId = '';
  String userToken = '';
  String userName = '';
  String logo = '';

  Future<void> loginApi({
    required String password,
    required String email,
  }) async {
    try {
      var headers = {
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST', Uri.parse(ApiEndpoint.loginEndPoint));
      request.body = json.encode({
        "email": email,
        "password": password
      });
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var responseJson = await response.stream.bytesToString();
        var responseDecode = json.decode(responseJson);
        if(responseDecode["success"] == false){
          commonToast(color: appColor,message: responseDecode["message"]);
          isLoading.value = false;
        }else{
          userId = responseDecode["data"]["id"].toString();
          userToken = responseDecode["data"]["token"].toString();
          userName = responseDecode["data"]["full_name"].toString();
          logo = responseDecode["data"]["pr_image"].toString();
          await _getUserDetail.setUserData("id", userId);
          await _getUserDetail.setUserData("token", userToken);
          await _getUserDetail.setUserData("name", userName);
          await _getUserDetail.setUserData("logo", logo);
          Get.offAll(const Dashboard());
          isLoading.value = false;
        }
      } else {
        commonToast(color: appColor,message: "Something Wrong");
        isLoading.value = false;
      }
    } catch (e) {
      commonToast(color: appColor,message: "Api Server error");
      isLoading.value = false;
      print(e);
    }
  }

  Future<void> forgotPasswordApi({
    required String email,
  }) async {
    try {
      var headers = {
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST', Uri.parse(ApiEndpoint.forgotPasswordEndPoint));
      request.body = json.encode({
        "email": email,
      });
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var responseJson = await response.stream.bytesToString();
        var responseDecode = json.decode(responseJson);
        if(responseDecode["success"] == false){
          commonToast(color: appColor,message: responseDecode["message"]);
          isLoading.value = false;
        }else{
          Routes.otpScreen();
          isLoading.value = false;
        }
      } else {
        commonToast(color: appColor,message: "Something Wrong");
        isLoading.value = false;
      }
    } catch (e) {
      commonToast(color: appColor,message: "Api Server error");
      isLoading.value = false;
      print(e);
    }
  }

  Future<void> verifyOtpApi({
    required String otp,
  }) async {
    try {
      var headers = {
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST', Uri.parse(ApiEndpoint.verifyOtpEndPoint));
      request.body = json.encode({
        "otp": otp,
      });
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var responseJson = await response.stream.bytesToString();
        var responseDecode = json.decode(responseJson);
        if(responseDecode["success"] == false){
          commonToast(color: appColor,message: responseDecode["message"]);
          isLoading.value = false;
        }else{
          Routes.loginPage();
          isLoading.value = false;
        }
      } else {
        commonToast(color: appColor,message: "Something Wrong");
        isLoading.value = false;
      }
    } catch (e) {
      commonToast(color: appColor,message: "Api Server error");
      isLoading.value = false;
      print(e);
    }
  }
}