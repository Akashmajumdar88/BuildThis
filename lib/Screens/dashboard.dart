import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controllers/allUser_controller.dart';
import '../Controllers/home_controller.dart';
import '../Utils/commonStyles.dart';
import 'AuthUI/myProfile.dart';
import 'Chat/chat.dart';
import 'OtherUser/users_screen.dart';
import 'Project/createProject.dart';
import 'home_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }
  static final List<Widget> _screens =  [
    HomeScreen(),
    UsersScreen(),
    CreateProject(),
    ChatScreen(),
    Myprofile(),
  ];
  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());
    final allUserController = Get.put(AllUserController());
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildNavBar("assets/home.png",0),
            buildNavBar("assets/group.png",1),
            const SizedBox(width: 20),
            buildNavBar("assets/message.png",3),
            buildNavBar("assets/user.png",4),
          ],
        ),
      ),
      floatingActionButton: ClipOval(
        child: Material(
          color: appColor,
          child: InkWell(
            onTap: () => _onItemTapped(2),
            child: const SizedBox(
              height: 50,
              width: 50,
              child: Icon(Icons.add,color: Colors.white),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
  Widget buildNavBar(image,int index){
    return GestureDetector(
      onTap: () =>_onItemTapped(index),
      child: Image.asset("$image",height: 30,width: 30,fit: BoxFit.fill,color: _selectedIndex == index ? Colors.blue : Colors.black),
    );
  }
}