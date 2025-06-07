import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {

  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final RxBool isVisiblePassword;
  late final RxBool isChecked;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    isVisiblePassword = true.obs;
    isChecked = false.obs;
    onVisiblePress();
  }

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
  }
  void onVisiblePress(){
    isVisiblePassword.value =! isVisiblePassword.value;
  }
}