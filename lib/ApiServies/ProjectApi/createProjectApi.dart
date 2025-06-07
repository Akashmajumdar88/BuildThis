
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../../Screens/dashboard.dart';
import '../../Utils/commonStyles.dart';
import '../../Utils/commonToast.dart';
import '../../Utils/shared_prefernces.dart';
import '../url_management.dart';

class CreateProjectApiServices extends GetxController{
  final _getUserDetail = UserLoginDetails();
  RxBool isLoading = false.obs;

  Future<void> createProject({
    required String projectName,
    required String startDate,
    required String endDate,
    required String category,
    required List skills,
    required String tagBy,
    required String description,
    required File imageFile,
    context,
  }) async {
    try {
      String skillsJson = jsonEncode(skills);
      var token = await _getUserDetail.getUserData('token');
      var id = await _getUserDetail.getUserData('id');
      var headers = {
        'authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };
      var request = http.MultipartRequest('POST', Uri.parse(ApiEndpoint.createProjectEndPoint));
      request.fields.addAll({
        "userId": id,
        "project_name": projectName,
        "start_date": startDate,
        "end_date": endDate,
        "category": category,
        "skills_name": skillsJson,
        "tag_by": tagBy,
        "description": description,
      });
      request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      var responseJson = await response.stream.bytesToString();
      var responseDecode = json.decode(responseJson);
      if (response.statusCode == 200) {
        if(responseDecode["success"] == false){
          commonToast(color: appColor,message: responseDecode["message"]);
          isLoading.value = false;
        }else{
          commonToast(color: appColor,message: responseDecode["message"]);
          Navigator.push(context, MaterialPageRoute(builder: (context) => const Dashboard()));
          isLoading.value = false;
        }
      } else {
        commonToast(color: appColor,message: responseDecode["message"]);
        isLoading.value = false;
      }
    } catch (e) {
      print(e);
    }
  }
}