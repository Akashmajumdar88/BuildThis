import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../Routes/routes.dart';
import '../../Utils/commonButton.dart';
import '../../Utils/commonStyles.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final double _height = Get.height,_width = Get.width;
  int currentPage = 0;
  List introImage = [
      "assets/intro1.png",
      "assets/intro2.png",
      "assets/intro3.png"
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: CarouselSlider(
                  options: CarouselOptions(
                    onPageChanged:(index, reason){
                      setState(() {
                        currentPage = index;
                      });
                    },
                    height: _height * 0.5,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: const Duration(milliseconds: 800),
                    viewportFraction: 1,
                  ),
                  items: introImage.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Image.asset(i,fit: BoxFit.fill,width: _width);
                      },
                    );
                  }).toList(),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  // height: MediaQuery.of(context).size.height * 0.4,
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: _height * 0.02),
                      AnimatedSmoothIndicator(
                        activeIndex: currentPage,
                        count: introImage.length,
                        effect: const WormEffect(
                          dotWidth: 10,
                          dotHeight: 10
                        ),
                      ),
                      SizedBox(height: _height * 0.02),
                      Text("Lorem Ipsum",style: TextStyles.appBarTitle),
                      SizedBox(height: _height * 0.01),
                      Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                          style: TextStyles.loginSubTitle,textAlign: TextAlign.center),
                      SizedBox(height: _height * 0.02),
                      CustomButtonIcon(
                        width: _width,
                        height: 45,
                        title: "Create an account",
                        onPressed: () {
                          Routes.signupScreen();
                        },
                      ),
                      SizedBox(height: _height * 0.01),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account? ",
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
                      SizedBox(height: _height * 0.02),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
