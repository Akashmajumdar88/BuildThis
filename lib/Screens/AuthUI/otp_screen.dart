import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import '../../ApiServies/auth/login_api.dart';
import '../../Controllers/otp_controller.dart';
import '../../Utils/commonButton.dart';
import '../../Utils/commonStyles.dart';


class OtpScreen extends StatelessWidget {
   OtpScreen({Key? key}) : super(key: key);
  OtpController? _otpController;
   final double _height = Get.height,_width = Get.width;
   var _pin;
  @override
  Widget build(BuildContext context) {
    _otpController ??= Get.find<OtpController>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/login.png",fit: BoxFit.fill,width: 200,height: 170),
            SizedBox(height: _height * 0.03),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset('assets/splash.png',
                        fit: BoxFit.fill,width: _width * 0.5,height: _height * 0.10),
                  ),
                  SizedBox(height: _height * 0.05),
                  Text("Enter Confirmation Code",style: TextStyles.loginTitle),
                  SizedBox(height: _height * 0.005),
                  Text("A 4-digit code was sent to hello@example.com",style: TextStyles.loginSubTitle),
                  SizedBox(height: _height * 0.05),
                  Center(
                    child: SizedBox(
                      height: 50,
                      child: OTPTextField(
                          controller: _otpController!.otpFieldController,
                          length: 4,
                          width: MediaQuery.of(context).size.width,
                          textFieldAlignment: MainAxisAlignment.spaceBetween,
                          fieldWidth: 50,
                          otpFieldStyle: OtpFieldStyle(
                            focusBorderColor: const Color(0xFFFFEDE4),
                            disabledBorderColor: const Color(0xFFFFEDE4),
                            borderColor: Colors.grey,
                            enabledBorderColor: Colors.grey,
                            backgroundColor: Colors.white,
                          ),
                          fieldStyle: FieldStyle.box,
                          outlineBorderRadius: 15,
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 22, color: Colors.black),
                          onChanged: (pin){
                            _pin = pin;
                          },
                          onCompleted: (pin) {}),
                    ),
                  ),
                  SizedBox(height: _height * 0.2),
                  Center(child: Text("Resend",style: TextStyles.labelStyle,textAlign: TextAlign.center)),
                  SizedBox(height: _height * 0.02),
                  CustomButtonIcon(
                    width: _width,
                    height: 48,
                    title: "Send",
                    onPressed: () {
                      LoginApiService().verifyOtpApi(otp: _pin);
                    },
                  ),
                  SizedBox(height: _height * 0.03),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
