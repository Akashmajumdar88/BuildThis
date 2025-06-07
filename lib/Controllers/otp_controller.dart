
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';

class OtpController extends GetxController {

  OtpFieldController otpFieldController = OtpFieldController();

  @override
  void onInit() {
    super.onInit();
    otpFieldController = OtpFieldController();
  }

  @override
  void onClose() {
    super.onClose();
  }
}