
import 'package:buildthis/Utils/shared_prefernces.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Routes/routes.dart';
import '../Screens/myRequest/myInterest_screen.dart';
import '../Screens/myRequest/myInvites_screen.dart';
import 'commonStyles.dart';

class MyDrawer{
  getDrawer(context){
    return SafeArea(
      child: Drawer(
        width: 260,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topRight: Radius.circular(0),bottomRight: Radius.circular(0))
        ),
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10,left: 20,right: 20,top: 20),
                child: Image.asset("assets/splash.png",fit: BoxFit.fill,height: 100,width: MediaQuery.of(context).size.width),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    const Divider(color: Colors.grey,thickness: 0.5,),
                    const SizedBox(height: 10.0),
                    ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Color(0xFFFF5050),
                        radius: 18,
                        child: Icon(Icons.mail,size: 18,color: Colors.white),
                      ),
                      title:  const Text("My Invites",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500)),
                      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 12, color: Color(0xFF001133)),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const MyInvitesScreen()));
                      },
                    ),
                    ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Color(0xFFFF5050),
                        radius: 18,
                        child: Icon(Icons.interests,size: 18,color: Colors.white),
                      ),
                      title:  const Text("My Interest",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500)),
                      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 12, color: Color(0xFF001133)),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const MyInterest()));
                      },
                    ),
                    const Spacer(),
                    Container(
                      width: double.infinity,
                      height: 40,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: IconButton(onPressed: () {
                        onTapLogout(context);
                      },
                          icon: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.logout,size: 24,color: Colors.black),
                              SizedBox(width: 5,),
                              Text("Logout",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500))
                            ],
                          )
                      ),
                    ),
                    const SizedBox(height: 30.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  onTapLogout(context) {
    final double _height = Get.height,_width = Get.width;
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            height: 180,
            width: _width,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Are you sure",style: TextStyles.appBarTitle),
                SizedBox(height: _height * 0.02),
                Text("Do you want to logout",style: TextStyles.labelStyle),
                SizedBox(height: _height * 0.02),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 100,
                        height: 35,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.blue,width: 0.5),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: const Text("No",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w500,fontSize: 14)),
                      ),
                    ),
                    GestureDetector(
                      onTap: ()async {
                        final getUserId = UserLoginDetails();
                        final token = UserLoginDetails();
                        final logo = UserLoginDetails();
                        final name = UserLoginDetails();
                        await getUserId.remove('id');
                        await token.remove('token');
                        await logo.remove('logo');
                        await name.remove('name');
                        Routes.loginPage();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 100,
                        height: 35,
                        decoration: BoxDecoration(
                            color: appColor,
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: const Text("Yes",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 14)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}