
import 'dart:convert';
import 'package:get/get.dart';
import '../../Model/projectModel.dart';
import '../../Utils/commonStyles.dart';
import '../../Utils/commonToast.dart';
import '../../Utils/shared_prefernces.dart';
import '../url_management.dart';
import 'package:http/http.dart' as http;

class ProjectApiServices extends GetxController {

  RxList<MyProjectModel> getMyProjectList = <MyProjectModel>[].obs;
  RxList<MySkillModel> getMySkillList = <MySkillModel>[].obs;
  RxBool isLoading = false.obs;
  final _getUserDetail = UserLoginDetails();

  Future<void> getMyProjectApi() async {
    var token = await _getUserDetail.getUserData('token');
    try {
      getMyProjectList.clear();
      isLoading.value = true;
      final response = await http.get(Uri.parse(ApiEndpoint.myProjectEndPoint),
        headers: {
          'Authorization': 'Bearer $token', // Replace with your token
        },
      );
      if (response.statusCode == 200) {
        var responseDecode = json.decode(response.body);
        List allData = responseDecode['data'];
        for (var element in allData) {
          getMyProjectList.add(MyProjectModel(
            id: element['id'] ?? "",
            projectName: element['project_name'] ?? "",
            status: element['status'] ?? ""
          ));
        }
        isLoading.value = false;
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> getMySkillApi() async {
    var token = await _getUserDetail.getUserData('token');
    try {
      getMySkillList.clear();
      isLoading.value = true;
      final response = await http.get(Uri.parse(ApiEndpoint.mySkillsEndPoint),
        headers: {
          'Authorization': 'Bearer $token', // Replace with your token
        },
      );
      if (response.statusCode == 200) {
        var responseDecode = json.decode(response.body);
        List allData = responseDecode['data'];
        for (var element in allData) {
          getMySkillList.add(MySkillModel(
              id: element['id'] ?? "",
              skillName: element['skill_name'] ?? ""
          ));
        }
        isLoading.value = false;
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> createSkills({
    required List skills,
  }) async {
    try {
      var token = await _getUserDetail.getUserData('token');
      var headers = {
        'authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST', Uri.parse(ApiEndpoint.createSkillEndPoint));
      request.body = json.encode({
        "skill_name": skills,
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