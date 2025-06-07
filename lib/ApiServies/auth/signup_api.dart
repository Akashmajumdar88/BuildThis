import 'dart:convert';
import 'package:get/get.dart';
import '../../Routes/routes.dart';
import '../../Utils/commonStyles.dart';
import '../../Utils/commonToast.dart';
import 'package:http/http.dart' as http;
import '../url_management.dart';

class SignupApiService extends GetxController{
  RxBool isLoading = false.obs;
  Future<void> signupApi({
    required String name,
    required String password,
    required String email,
    required String conPassword,
  }) async {
    try {
      var headers = {
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST', Uri.parse(ApiEndpoint.signupEndPoint));
      request.body = json.encode({
        "email": email,
        "name": name,
        "password": password,
        "cn_password": password,
      });
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var responseJson = await response.stream.bytesToString();
        var responseDecode = json.decode(responseJson);
        if(responseDecode["success"] == false){
          isLoading.value = false;
          commonToast(color: appColor,message: responseDecode["message"]);
        }else{
          Routes.loginPage();
          commonToast(color: appColor,message: responseDecode["message"]);
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