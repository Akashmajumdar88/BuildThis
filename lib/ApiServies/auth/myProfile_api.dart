
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart';
import '../../Model/myProfile_model.dart';
import '../../Utils/shared_prefernces.dart';
import '../url_management.dart';

class GetUserDetailsService extends GetxController {
  final _getUserDetail = UserLoginDetails();
  Future<MyProfileModel> getUserDetails() async {
    var token = await _getUserDetail.getUserData('token');
    final response = await get(Uri.parse(ApiEndpoint.userProfileEndPoint),
      headers: {
        'Authorization': 'Bearer $token', // Replace with your token
      },
    );
    var responseDecode = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return MyProfileModel.fromJson(responseDecode);
    } else {
      throw Exception('Failed to load post');
    }
  }
}