import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../Model/user_model.dart';
import 'package:http/http.dart' as http;
import '../../Utils/commonStyles.dart';
import '../../Utils/commonToast.dart';
import '../../Utils/shared_prefernces.dart';
import '../url_management.dart';

class AllUserApiServices extends GetxController {

  RxList<AllUserModel> getAllStateList = <AllUserModel>[].obs;
  RxList<MyProjectModel> getMyProjectList = <MyProjectModel>[].obs;
  RxList<AllProjectModel> getAllProjectList = <AllProjectModel>[].obs;
  RxList<AssignProjectAllUserModel> getAssignAllProjectList = <AssignProjectAllUserModel>[].obs;

  RxBool isLoading = false.obs;
  final _getUserDetail = UserLoginDetails();

  Future<void> getAllUserApi() async {
    try {
      getAllStateList.clear();
      isLoading.value = true;
      var token = await _getUserDetail.getUserData('token');
      var headers = {
        'authorization': 'Bearer $token'
      };
      var request = http.Request('GET', Uri.parse(ApiEndpoint.allUserUrlEndPoint));
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      var responseJson = await response.stream.bytesToString();
      var responseDecode = json.decode(responseJson);
      if (response.statusCode == 200) {
        List allData = responseDecode['data'];
        for (var element in allData) {
          getAllStateList.add(AllUserModel(
              id: element['id'] ?? "",
              fullName: element['full_name'] ?? "",
            prImage: element['pr_image'] ?? "",
            skillNames: element['skill_names'] ?? "",
          ));
        }
        isLoading.value = false;
      } else {
        print(response.reasonPhrase);
        isLoading.value = false;
      }
    } catch (e) {
      print(e);
      print("error all user list api");
      isLoading.value = false;
    }
  }

  Future<void> getMyProjectApi() async {
    try {
      getMyProjectList.clear();
      isLoading.value = true;
      var token = await _getUserDetail.getUserData('token');
      var headers = {
        'authorization': 'Bearer $token'
      };
      var request = http.Request('GET', Uri.parse(ApiEndpoint.myAllProjectEndPoint));
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      var responseJson = await response.stream.bytesToString();
      var responseDecode = json.decode(responseJson);
      if (response.statusCode == 200) {
        List allData = responseDecode['data'];
        for (var element in allData) {
          getMyProjectList.add(MyProjectModel(
            id: element['id'] ?? "",
            name: element['project_name'] ?? "",
            prImage: element['logo'] ?? "",
            status: element['status'] ?? "",
            start: element['start_date'] ?? "",
            end: element['end_date'] ?? "",
          ));
        }
        isLoading.value = false;
      } else {
        print(response.reasonPhrase);
        isLoading.value = false;
      }
    } catch (e) {
      print(e);
      print("error all My project list api");
      isLoading.value = false;
    }
  }

  Future<void> getAllProjectApiService() async {
    try {
      getAllProjectList.clear();
      isLoading.value = true;
      var token = await _getUserDetail.getUserData('token');
      var headers = {
        'authorization': 'Bearer $token'
      };
      var request = http.Request('GET', Uri.parse(ApiEndpoint.allProjectEndPoint));
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      var responseJson = await response.stream.bytesToString();
      var responseDecode = json.decode(responseJson);
      if (response.statusCode == 200) {
        List allData = responseDecode['data'];
        for (var element in allData) {
          getAllProjectList.add(AllProjectModel(
            id: element['id'] ?? "",
            name: element['project_name'] ?? "",
            prImage: element['logo'] ?? "",
            status: element['status'] ?? "",
            start: element['start_date'] ?? "",
            end: element['end_date'] ?? "",
          ));
        }
        isLoading.value = false;
      } else {
        print(response.reasonPhrase);
        isLoading.value = false;
      }
    } catch (e) {
      print(e);
      print("error all My project list api");
      isLoading.value = false;
    }
  }

  Future<void> createInviteProjectApi({
    required var body,
    required String projectId,
    required BuildContext context,
  }) async {
    try {
      final now = DateTime.now();
      final formattedDate = DateFormat('yyyy-MM-dd').format(now);
      var token = await _getUserDetail.getUserData('token');
      var headers = {
        'authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST', Uri.parse(ApiEndpoint.createInvitationEndPoint));
      request.body = json.encode({
        "projectId": projectId,
        "invitedUserIds": body,
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
          onTapInterest(context);
          isLoading.value = false;
        }
      } else {
        commonToast(color: appColor,message: "Something Wrong");
        isLoading.value = false;
      }
    } catch (e) {
      commonToast(color: appColor,message: "invite Server error");
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
            height: 220,
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
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(50)
                  ),
                  child: IconButton(onPressed: () {},
                      icon: const Icon(Icons.person_add_alt_1,color: Colors.green,size: 24)
                  ),
                ),
                const SizedBox(height: 20,),
                Text("Invite Successfully",style: TextStyles.inder14W800),
                const SizedBox(height: 10),
                Text("Your invite has been processed successfully",style: TextStyles.inder12W400,textAlign: TextAlign.center,),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> assignProjectAllUserApi({id}) async {
    try {
      getAssignAllProjectList.clear();
      isLoading.value = true;
      var token = await _getUserDetail.getUserData('token');
      var headers = {
        'authorization': 'Bearer $token'
      };
      var request = http.Request('GET', Uri.parse("${ApiEndpoint.assignProjectEndPoint}$id"));
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      var responseJson = await response.stream.bytesToString();
      var responseDecode = json.decode(responseJson);
      if (response.statusCode == 200) {
        List allData = responseDecode['data'];
        for (var element in allData) {
          getAssignAllProjectList.add(AssignProjectAllUserModel(
            id: element['id'] ?? "",
            userId: element['userId'] ?? "",
          ));
        }
        isLoading.value = false;
      } else {
        print(response.reasonPhrase);
        isLoading.value = false;
      }
    } catch (e) {
      print(e);
      print("error all user list api");
      isLoading.value = false;
    }
  }

}