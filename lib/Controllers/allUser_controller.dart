
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../ApiServies/ProjectApi/myProject.dart';
import '../ApiServies/users/all_user_list.dart';
import '../Model/user_model.dart';
import '../Utils/shared_prefernces.dart';

class AllUserController extends GetxController {
  late final TextEditingController searchController;
  final allUserList = Get.put(AllUserApiServices());
  final projectList = Get.put(ProjectApiServices());
  final assignProjectListByUser = Get.put(AllUserApiServices());



  final Set<int> selectedIndexes = {};

  final filteredUserList = <dynamic>[].obs;
  final _getUserDetail = UserLoginDetails();
  late final RxnString name;
  late final RxnString logo;
  late final RxnString categoryValue;

  @override
  void onInit() async {
    super.onInit();
    searchController = TextEditingController();
    name = RxnString();
    logo = RxnString();
    categoryValue = RxnString();
    _loadUserName();
    await allUserList.getAllUserApi();
    await projectList.getMyProjectApi();
    ever(allUserList.getAllStateList, (_) {
      resetUserList();
    });
    resetUserList();
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
      filteredUserList.assignAll(
        allUserList.getAllStateList.where((user) =>
            user.fullName.toLowerCase().contains(query.toLowerCase())),
      );
    }
  }

  void resetUserList() {
    filteredUserList.assignAll(allUserList.getAllStateList);
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}