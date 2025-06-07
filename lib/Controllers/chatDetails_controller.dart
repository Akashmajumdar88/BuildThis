
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatDetailsController extends GetxController {

  late final TextEditingController emailController;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
  }

  @override
  void onClose() {
    super.onClose();
  }
}