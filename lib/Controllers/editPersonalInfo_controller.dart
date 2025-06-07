
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../ApiServies/auth/getUserData_api.dart';
import '../Model/getUserDetail.dart';
import '../Utils/shared_prefernces.dart';

class EditPersonalInfoController extends GetxController {

  late final TextEditingController fullNameController;
  late final TextEditingController userNameController;
  late final TextEditingController emailController;
  late final TextEditingController birthController;
  late final TextEditingController languageController;
  late final TextEditingController addressController;
  late final TextEditingController descriptionController;
  late Rxn<XFile> profileImage;
  UserData userData = UserData();
  final getUserDetail = UserLoginDetails();
  late final RxnString id;


  @override
  void onInit() {
    super.onInit();
    id = RxnString();
    fullNameController = TextEditingController();
    userNameController = TextEditingController();
    emailController = TextEditingController();
    birthController = TextEditingController();
    languageController = TextEditingController();
    addressController = TextEditingController();
    descriptionController = TextEditingController();
    profileImage = Rxn<XFile>(null);
    _loadUserName();
    UserDataApiService().userDetailsApi(id: id).then((value) {
        userData = value.data!;
        fullNameController.text = userData.fullName!;
        userNameController.text = userData.userName!;
        birthController.text = userData.dob!;
        languageController.text = userData.language!;
        addressController.text = userData.city!;
        descriptionController.text = userData.bio!;
    });
  }
  Future<void> _loadUserName() async {
    final userId = await getUserDetail.getUserData('id');
    id.value = userId;
  }

  @override
  void onClose() {
    super.onClose();
  }
}