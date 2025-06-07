
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../ApiServies/auth/getUserData_api.dart';
import '../../Model/getUserDetail.dart';
import '../../Utils/commonStyles.dart';

class UserProfileScreen extends StatefulWidget {
  String id;
  UserProfileScreen({Key? key,required this.id}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final double _height = Get.height,_width = Get.width;
  UserData userData = UserData();
  bool loader = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load();
  }
  load(){
    UserDataApiService().userDetailsApi(id: widget.id).then((value) {
      setState(() {
        userData = value.data!;
        loader = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
       appBar: AppBar(
         backgroundColor: Colors.white,
         title: Text("User Profile",style: TextStyles.appBarTitle),
       ),
      body: loader == false ? const Center(child: CircularProgressIndicator()) :
      SingleChildScrollView(
        physics: const ScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: _height *0.02),
            Align(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  DottedBorder(
                      borderType: BorderType.Circle,
                      radius: const Radius.circular(12),
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: "${userData.prImage}",
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            'assets/placeholder.png',
                            fit: BoxFit.cover,
                            width: 100,
                            height: 100,
                          ),
                          fit: BoxFit.cover,
                          height: 100,
                          width: 100,
                        ),
                      )
                  ),
                  const Positioned(
                     right: 10,
                      bottom: 10,
                      child: Icon(Icons.circle,color: Colors.green,size: 10))
                ],
              ),
            ),
            SizedBox(height: _height *0.01),
            Text(userData.fullName ?? "NA",style: GoogleFonts.manrope(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w600)),
            SizedBox(height: _height *0.01),
            Text(userData.bio ?? "",
                style: GoogleFonts.manrope(fontSize: 12,color: Colors.black,fontWeight: FontWeight.w300),textAlign: TextAlign.center),
            SizedBox(height: _height *0.03),
            Container(
              width: _width,
              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
              decoration: BoxDecoration(
                  color: const Color(0xFFFCFCFC),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Information",style: GoogleFonts.manrope(fontSize: 16,color: Colors.black,fontWeight: FontWeight.w600)),
                  SizedBox(height: _height *0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("User Name",style: GoogleFonts.manrope(fontSize: 12,color: Colors.black,fontWeight: FontWeight.w300)),
                      Text(userData.userName ?? "NA",style: GoogleFonts.manrope(fontSize: 12,color: const Color(0xFF999999),fontWeight: FontWeight.w400)),
                    ],
                  ),
                  SizedBox(height: _height *0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Email",style: GoogleFonts.manrope(fontSize: 12,color: Colors.black,fontWeight: FontWeight.w300)),
                      Text(userData.email ?? "NA",style: GoogleFonts.manrope(fontSize: 12,color: const Color(0xFF999999),fontWeight: FontWeight.w400)),
                    ],
                  ),
                  SizedBox(height: _height *0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Date Of Birth",style: GoogleFonts.manrope(fontSize: 12,color: Colors.black,fontWeight: FontWeight.w300)),
                      Text(userData.dob ?? "NA",style: GoogleFonts.manrope(fontSize: 12,color: const Color(0xFF999999),fontWeight: FontWeight.w400)),
                    ],
                  ),
                  SizedBox(height: _height *0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("City",style: GoogleFonts.manrope(fontSize: 12,color: Colors.black,fontWeight: FontWeight.w300)),
                      Text(userData.city ?? "NA",style: GoogleFonts.manrope(fontSize: 12,color: const Color(0xFF999999),fontWeight: FontWeight.w400)),
                    ],
                  ),
                  SizedBox(height: _height *0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Language",style: GoogleFonts.manrope(fontSize: 12,color: Colors.black,fontWeight: FontWeight.w300)),
                      Text(userData.language ?? "NA",style: GoogleFonts.manrope(fontSize: 12,color: const Color(0xFF999999),fontWeight: FontWeight.w400)),
                    ],
                  ),
                  SizedBox(height: _height *0.02),
                ],
              ),
            ),
            SizedBox(height: _height *0.03),
          ],
        ),
      ),
    );
  }
}
