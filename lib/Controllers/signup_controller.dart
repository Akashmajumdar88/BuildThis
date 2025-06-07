import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {

  late final TextEditingController emailController;
  late final TextEditingController nameController;
  late final TextEditingController passwordController;
  late final TextEditingController conPasswordController;
  late final RxBool isVisiblePassword;
  late final RxBool isVisibleConPassword;
  late final RxBool isChecked;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    conPasswordController = TextEditingController();
    nameController = TextEditingController();
    isVisiblePassword = true.obs;
    isVisibleConPassword = true.obs;
    isChecked = false.obs;
    onVisiblePress();
    onVisibleConPress();
  }

  @override
  void onClose() {
    super.onClose();
  }
  void onVisiblePress(){
    isVisiblePassword.value =! isVisiblePassword.value;
  }
  void onVisibleConPress(){
    isVisibleConPassword.value =! isVisibleConPassword.value;
  }
}