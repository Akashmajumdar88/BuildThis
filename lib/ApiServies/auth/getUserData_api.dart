
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../Model/getUserDetail.dart';
import '../../Utils/shared_prefernces.dart';
import '../url_management.dart';

class UserDataApiService extends GetxController {
  RxBool isLoading = false.obs;
  final _getUserDetail = UserLoginDetails();

  Future<GetUserDetail> userDetailsApi({id}) async {
    var token = await _getUserDetail.getUserData('token');
    var headers = {
      'authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET', Uri.parse("${ApiEndpoint.userDetailsEndPoint}$id"));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var responseJson = await response.stream.bytesToString();
      var responseDecode = json.decode(responseJson);
      isLoading.value=false;
      return GetUserDetail.fromJson(responseDecode);
    }
    else {
      print(response.reasonPhrase);
      throw Exception('Failed to load post');
    }
  }
}