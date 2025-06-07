import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../ApiServies/users/all_user_list.dart';
import '../Utils/shared_prefernces.dart';

class HomeController extends GetxController {
  late final TextEditingController searchController;
  final myProjectList = Get.put(AllUserApiServices());
  final allProjectList = Get.put(AllUserApiServices());
  final filteredMyProjectList = <dynamic>[].obs;
  final filteredAllProjectList = <dynamic>[].obs;
  final _getUserDetail = UserLoginDetails();
  late final RxnString name;
  late final RxnString logo;


  @override
  void onInit() async{
    super.onInit();
    name = RxnString();
    logo = RxnString();
    _loadUserName();
    searchController = TextEditingController();
    await myProjectList.getMyProjectApi();
    await allProjectList.getAllProjectApiService();
    ever(myProjectList.getMyProjectList, (_) {
      resetUserList();
    });
    resetUserList();
    ever(allProjectList.getAllProjectList, (_) {
      resetUserList();
    });
    resetAllProjectList();
  }
  Future<void> _loadUserName() async {
    final userName = await _getUserDetail.getUserData('name');
    final userImage = await _getUserDetail.getUserData('logo');
    name.value = userName;
    logo.value = userImage;
  }
  void filterUsers(String query) {
    if (query.isEmpty) {
      resetUserList();
    } else {
      filteredMyProjectList.assignAll(
        myProjectList.getMyProjectList.where((user) =>
            user.name.toLowerCase().contains(query.toLowerCase())),
      );
    }
  }
  void filterAllProjectData(String query) {
    if (query.isEmpty) {
      resetAllProjectList();
    } else {
      filteredAllProjectList.assignAll(
        allProjectList.getAllProjectList.where((user) =>
            user.name.toLowerCase().contains(query.toLowerCase())),
      );
    }
  }

  void resetUserList() {
    filteredMyProjectList.assignAll(myProjectList.getMyProjectList);
  }
  void resetAllProjectList() {
    filteredAllProjectList.assignAll(allProjectList.getAllProjectList);
  }

}