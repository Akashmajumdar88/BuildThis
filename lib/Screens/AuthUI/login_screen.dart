import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../ApiServies/auth/login_api.dart';
import '../../Controllers/login_controller.dart';
import '../../Routes/routes.dart';
import '../../Utils/commonButton.dart';
import '../../Utils/commonFields.dart';
import '../../Utils/commonStyles.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  LoginController? _loginController;
  final double _height = Get.height,_width = Get.width;
  final validKey = GlobalKey<FormState>();
  final _apiController = Get.put(LoginApiService());

  @override
  Widget build(BuildContext context) {
    _loginController ??= Get.find<LoginController>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Image.asset("assets/login.png",fit: BoxFit.fill,width: 200,height: 170),
              ],
            ),
            SizedBox(height: _height * 0.03),
            Form(
              key: validKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset('assets/splash.png',
                          fit: BoxFit.fill,width: _width * 0.5,height: _height * 0.10),
                    ),
                    SizedBox(height: _height * 0.05),
                    Text("Login Account",style: TextStyles.loginTitle),
                    SizedBox(height: _height * 0.005),
                    Text("Already have an account.",style: TextStyles.loginSubTitle),
                    SizedBox(height: _height * 0.03),
                    Text("Email Address",style: TextStyles.labelStyle),
                    SizedBox(height: _height * 0.005),
                    CommonTextField(
                      inputType: TextInputType.emailAddress,
                        validation: (nameValid) {
                          if (nameValid!.isEmpty) {
                            return "Please enter email";
                          } else {
                            return null;
                          }
                        },
                        onPressed: () {},
                        cont: _loginController!.emailController,
                        hintText: "Email"),
                    SizedBox(height: _height * 0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Password",style: TextStyles.labelStyle),
                        GestureDetector(
                          onTap: (){
                            Routes.forgotPasswordScreen();
                          },
                            child: Text("Forgot Password",style: TextStyles.labelStyle)),
                      ],
                    ),
                    SizedBox(height: _height * 0.005),
                    _buildPassTextFieldWidget,
                    SizedBox(height: _height * 0.01),
                    Row(
                      children: [
                        Obx(()=>Checkbox(
                          activeColor: appColor,
                          value: _loginController!.isChecked.value,
                          onChanged: (bool? value) {
                            _loginController!.isChecked.value = value ?? false;
                          },
                        )),
                        Text('Keep me signed in',
                            style: GoogleFonts.manrope(fontSize: 14,color: const Color(0xFF191D23),fontWeight: FontWeight.w600)),
                      ],
                    ),
                    SizedBox(height: _height * 0.01),
                    Obx(() => _apiController.isLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : CustomButtonIcon(
                      width: _width,
                      height: 45,
                      title: "Login",
                      onPressed: () async {
                        if (validKey.currentState!.validate()) {
                          _apiController.isLoading.value = true;
                          try {
                            await LoginApiService().loginApi(
                              password: _loginController!.passwordController.text,
                              email: _loginController!.emailController.text,
                            );
                          } finally {
                            _apiController.isLoading.value = false;
                          }
                        }
                      },
                    )),
                    SizedBox(height: _height * 0.01),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don’t have an account?",
                            style: GoogleFonts.nunito(fontWeight: FontWeight.w600,fontSize: 16,color: const Color(0xFF666666))),
                        TextButton(
                            onPressed: () {
                              Routes.signupScreen();
                            },
                            child: Text("Sign Up",
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
          controller: _loginController!.passwordController,
          keyboardType: TextInputType.text,
          obscureText : _loginController!.isVisiblePassword.value,
          style: TextStyles.fillStyle,
           validator: (nameValid) {
            if (nameValid!.isEmpty) {
              return "Please enter Password";
            } else {
              return null;
            }
          },
          obscuringCharacter: "*",
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: "Enter password",
            hintStyle: TextStyles.hintStyle,
            suffixIcon: IconButton(
                icon: Icon(
                  _loginController!.isVisiblePassword.value ? Icons.visibility_off : Icons.visibility, //change icon based on boolean value
                  color: Colors.grey,
                ),
                onPressed: _loginController!.onVisiblePress
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
