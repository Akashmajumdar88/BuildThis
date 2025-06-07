
import 'package:get/get.dart';
import '../Controllers/chatDetails_controller.dart';

class ChatDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatDetailsController());
  }
}