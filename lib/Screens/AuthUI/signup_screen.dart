import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../ApiServies/auth/signup_api.dart';
import '../../Controllers/signup_controller.dart';
import '../../Routes/routes.dart';
import '../../Utils/commonButton.dart';
import '../../Utils/commonFields.dart';
import '../../Utils/commonStyles.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);
  final double _height = Get.height,_width = Get.width;
  SignupController? _signupController;
  final validKey = GlobalKey<FormState>();
  final _apiController = Get.put(SignupApiService());
  @override
  Widget build(BuildContext context) {
    _signupController ??= Get.find<SignupController>();
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
              child: Form(
                key: validKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset('assets/splash.png',
                          fit: BoxFit.fill,width: _width * 0.5,height: _height * 0.10),
                    ),
                    SizedBox(height: _height * 0.05),
                    Text("Sign Up",style: TextStyles.loginTitle),
                    SizedBox(height: _height * 0.005),
                    Text("Hello, We are happy to have you back at app",style: TextStyles.loginSubTitle),
                    SizedBox(height: _height * 0.03),
                    Text("Full Name",style: TextStyles.labelStyle),
                    SizedBox(height: _height * 0.005),
                    CommonTextField(
                        validation: (nameValid) {
                          if (nameValid!.isEmpty) {
                            return "Please enter full name";
                          } else {
                            return null;
                          }
                        },
                        onPressed: () {},
                        cont: _signupController!.nameController,
                        hintText: "Enter full name"),
                    SizedBox(height: _height * 0.02),
                    Text("Email Address",style: TextStyles.labelStyle),
                    SizedBox(height: _height * 0.005),
                    CommonTextField(
                        validation: (nameValid) {
                          if (nameValid!.isEmpty) {
                            return "Please enter email";
                          } else {
                            return null;
                          }
                        },
                        onPressed: () {},
                        cont: _signupController!.emailController,
                        hintText: "Email"),
                    SizedBox(height: _height * 0.02),
                    Text("Create Password",style: TextStyles.labelStyle),
                    SizedBox(height: _height * 0.005),
                    _buildPassTextFieldWidget,
                    SizedBox(height: _height * 0.02),
                    Text("Confirm Password",style: TextStyles.labelStyle),
                    SizedBox(height: _height * 0.005),
                    _buildPassTextFieldWidget1,
                    SizedBox(height: _height * 0.01),
                    Row(
                      children: [
                        Obx(()=>Checkbox(
                          activeColor: appColor,
                          value: _signupController!.isChecked.value,
                          onChanged: (bool? value) {
                            _signupController!.isChecked.value = value ?? false;
                          },
                        )),
                        Text('Keep me signed up',
                            style: GoogleFonts.manrope(fontSize: 14,color: const Color(0xFF191D23),fontWeight: FontWeight.w600)),
                      ],
                    ),
                    SizedBox(height: _height * 0.01),
                    Obx(()=> _apiController.isLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : CustomButtonIcon(
                      width: _width,
                      height: 48,
                      title: "Create an account",
                      onPressed: () async{
                        if (validKey.currentState!.validate()) {
                          _apiController.isLoading.value = true;
                          try {
                            await SignupApiService().signupApi(
                                name: _signupController!.nameController.text,
                                password: _signupController!.passwordController.text,
                                email: _signupController!.emailController.text,
                                conPassword: _signupController!.conPasswordController.text);
                          } finally {
                            _apiController.isLoading.value = false;
                          }
                        }
                      },
                    )),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account?",
                            style: GoogleFonts.nunito(fontWeight: FontWeight.w600,fontSize: 16,color: const Color(0xFF666666))),
                        TextButton(
                            onPressed: () {
                              Routes.loginPage();
                            },
                            child: Text("Login",
                                style: GoogleFonts.nunito(fontWeight: FontWeight.w600,fontSize: 16,color: appColor)
                            )
                        ),
                      ],
                    ),
                    SizedBox(height: _height * 0.03),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget get _buildPassTextFieldWidget =>  Obx(() =>
      TextFormField(
          controller: _signupController!.passwordController,
          keyboardType: TextInputType.text,
          obscureText : _signupController!.isVisiblePassword.value,
          style: TextStyles.fillStyle,
          obscuringCharacter: "*",
          validator: (nameValid) {
            if (nameValid!.isEmpty) {
              return "Please enter password";
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: "Enter password",
            hintStyle: TextStyles.hintStyle,
            suffixIcon: IconButton(
                icon: Icon(
                  _signupController!.isVisiblePassword.value ? Icons.visibility_off : Icons.visibility, //change icon based on boolean value
                  color: Colors.grey,
                ),
                onPressed: _signupController!.onVisiblePress
            ),
            contentPadding: const EdgeInsets.all(10.0),
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                borderSide: BorderSide(color: Color(0xFF64748B), width: 0.4)),
            border: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xFFD0D5DD), width: 0.4),
                borderRadius: BorderRadius.circular(4.0)),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: inputBorder, width: 0.4),
                borderRadius: BorderRadius.circular(4.0)),
          )
      ));

  Widget get _buildPassTextFieldWidget1 =>  Obx(() =>
      TextFormField(
          controller: _signupController!.conPasswordController,
          keyboardType: TextInputType.text,
          obscureText : _signupController!.isVisibleConPassword.value,
          style: TextStyles.fillStyle,
          obscuringCharacter: "*",
          validator: (nameValid) {
            if (nameValid!.isEmpty) {
              return "Please enter conform password";
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: "Enter password",
            hintStyle: TextStyles.hintStyle,
            suffixIcon: IconButton(
                icon: Icon(
                  _signupController!.isVisibleConPassword.value ? Icons.visibility_off : Icons.visibility, //change icon based on boolean value
                  color: Colors.grey,
                ),
                onPressed: _signupController!.onVisibleConPress
            ),
            contentPadding: const EdgeInsets.all(10.0),
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                borderSide: BorderSide(color: Color(0xFF64748B), width: 0.4)),
            border: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xFFD0D5DD), width: 0.4),
                borderRadius: BorderRadius.circular(4.0)),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: inputBorder, width: 0.4),
                borderRadius: BorderRadius.circular(4.0)),
          )
      ));
}
