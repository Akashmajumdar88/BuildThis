
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../Model/user_model.dart';
import '../../Utils/shared_prefernces.dart';
import '../url_management.dart';

class AllProjectUserApiServices extends GetxController {

  RxList<AllProjectModel5> getAllProjectList5 = <AllProjectModel5>[].obs;
  RxBool isLoading = false.obs;
  final _getUserDetail = UserLoginDetails();

  Future<void> getAllProjectApiService5() async {
    try {
      getAllProjectList5.clear();
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
          getAllProjectList5.add(AllProjectModel5(
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
      print("error all project list api");
      isLoading.value = false;
    }
  }
}