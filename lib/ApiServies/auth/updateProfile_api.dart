
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../Model/projectModel.dart';
import '../../Utils/commonStyles.dart';
import '../../Utils/commonToast.dart';
import '../../Utils/shared_prefernces.dart';
import '../url_management.dart';

class UpdateProfileApiServices extends GetxController{
  final _getUserDetail = UserLoginDetails();
  RxBool isLoading = false.obs;
  RxList<MyCertificateModel> getMyCertificateList = <MyCertificateModel>[].obs;

  Future<void> updateProfile({
    required String fullName,
    required String userName,
    required String date,
    required String city,
    required String language,
    required String bio,
    var profile,
  }) async {
    try {
      var token = await _getUserDetail.getUserData('token');
      var id = await _getUserDetail.getUserData('id');
      isLoading.value = true;
      var headers = {
        'authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };
      var request = http.MultipartRequest('POST', Uri.parse(ApiEndpoint.updateUserProfileEndPoint));
      request.fields.addAll({
        "userId": id,
        "fullName": fullName,
        "userName": userName,
        "dob": date,
        "phone": "",
        "address": "",
        "city": city,
        "postalCode": "",
        "language": language,
        "bio": bio,
      });
      profile == '' ? '' :  request.files.add(await http.MultipartFile.fromPath('image', profile));
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
          Get.back();
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

  Future<void> interestedProjectApi({
    required String projectCreateId,
    required String projectId,
    required BuildContext context,
  }) async {
    try {
      final now = DateTime.now();
      final formattedDate = DateFormat('yyyy-MM-dd').format(now);
      var token = await _getUserDetail.getUserData('token');
      var id = await _getUserDetail.getUserData('id');
      var headers = {
        'authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST', Uri.parse(ApiEndpoint.interestedProjectEndPoint));
      request.body = json.encode({
        "projectCreatorId": projectCreateId,
        "projectId": projectId,
        "invitedUserIds": id,
        "invitedDate": formattedDate,
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
          // commonToast(color: appColor,message: responseDecode["message"]);
          onTapInterest(context);
          isLoading.value = false;
        }
      } else {
        commonToast(color: appColor,message: "Something Wrong");
        isLoading.value = false;
      }
    } catch (e) {
      commonToast(color: appColor,message: "Interested Server error");
      isLoading.value = false;
      print(e);
    }
  }

  Future<void> createCertificateApi({
    required String certificate,
  }) async {
    try {
      var token = await _getUserDetail.getUserData('token');
      var headers = {
        'authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST', Uri.parse(ApiEndpoint.createCertificateEndPoint));
      request.body = json.encode({
        "certificate_name": certificate,
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
      commonToast(color: appColor,message: "create certificate Server error");
      isLoading.value = false;
      print(e);
    }
  }

  Future<void> getCertificateApi() async {
    var token = await _getUserDetail.getUserData('token');
    try {
      getMyCertificateList.clear();
      isLoading.value = true;
      final response = await http.get(Uri.parse(ApiEndpoint.getMyCertificatesEndPoint),
        headers: {
          'Authorization': 'Bearer $token', // Replace with your token
        },
      );
      if (response.statusCode == 200) {
        var responseDecode = json.decode(response.body);
        List allData = responseDecode['data'];
        for (var element in allData) {
          getMyCertificateList.add(MyCertificateModel(
              id: element['id'] ?? "",
              certificateName: element['certificate_name'] ?? ""
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

  Future<void> deleteCertificateApi({
    required String id,
  }) async {
    try {
      var token = await _getUserDetail.getUserData('token');
      var headers = {
        'authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST', Uri.parse(ApiEndpoint.deleteCertificateEndPoint));
      request.body = json.encode({
        "id": id,
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
      commonToast(color: appColor,message: "delete certificate Server error");
      isLoading.value = false;
      print(e);
    }
  }

  Future<void> deleteSkillApi({
    required String id,
  }) async {
    try {
      var token = await _getUserDetail.getUserData('token');
      var headers = {
        'authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST', Uri.parse(ApiEndpoint.deleteSkillsEndPoint));
      request.body = json.encode({
        "id": id,
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
      commonToast(color: appColor,message: "delete skill Server error");
      isLoading.value = false;
      print(e);
    }
  }

  onTapInterest(context) {
    final double _width = Get.width;
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            height: 180,
            width: _width,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const Spacer(),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.cancel,color: Colors.grey,size: 24))
                  ],
                ),
                const SizedBox(height: 20,),
                Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: IconButton(onPressed: () {},
                      icon: const Icon(Icons.person_add_alt_1,color: Colors.blue,size: 24)
                  ),
                ),
                const SizedBox(height: 20,),
                Text("Request processed successfully",style: TextStyles.inder14W800),
              ],
            ),
          ),
        );
      },
    );
  }

}