
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../ApiServies/auth/login_api.dart';
import '../../Controllers/forgotPassword_controller.dart';
import '../../Routes/routes.dart';
import '../../Utils/commonButton.dart';
import '../../Utils/commonFields.dart';
import '../../Utils/commonStyles.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);
  final double _height = Get.height,_width = Get.width;
  ForgotPasswordController? _forgotPasswordController;
  final validKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    _forgotPasswordController ??= Get.find<ForgotPasswordController>();
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
                  Text("Forgot Password",style: TextStyles.loginTitle),
                  SizedBox(height: _height * 0.005),
                  Text("Recover their password if forgotten",style: TextStyles.loginSubTitle),
                  SizedBox(height: _height * 0.03),
                  Text("Email Address",style: TextStyles.labelStyle),
                  SizedBox(height: _height * 0.005),
                  Form(
                    key: validKey,
                    child: CommonTextField(
                        inputType: TextInputType.emailAddress,
                        validation: (nameValid) {
                          if (nameValid!.isEmpty) {
                            return "Please enter email";
                          } else {
                            return null;
                          }
                        },
                        onPressed: () {},
                        cont: _forgotPasswordController!.emailController,
                        hintText: "Email"),
                  ),
                  SizedBox(height: _height * 0.2),
                  CustomButtonIcon(
                    width: _width,
                    height: 48,
                    title: "Send",
                    onPressed: () {
                      if(validKey.currentState!.validate()){
                        LoginApiService().forgotPasswordApi(email: _forgotPasswordController!.emailController.text);
                      }
                    },
                  ),
                  SizedBox(height: _height * 0.03),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
