
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../ApiServies/ProjectApi/myInvite_api.dart';
import '../../Utils/commonStyles.dart';
import '../../Utils/shared_prefernces.dart';

class MyInvitesScreen extends StatefulWidget {
  const MyInvitesScreen({Key? key}) : super(key: key);

  @override
  State<MyInvitesScreen> createState() => _MyInvitesScreenState();
}

class _MyInvitesScreenState extends State<MyInvitesScreen>with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final double _width = Get.width;
  final myInviteList = Get.put(MyInviteApiServices());
  final myInviteListSend = Get.put(MyInviteApiServices());
  final getUserDetail = UserLoginDetails();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    load();
    _loadUserId();
  }
  late final String userId;
  load(){
    setState(() {
      myInviteList.getMyInviteApiServiceReceive();
      myInviteListSend.getMyInviteSendApiService();
    });
  }
  Future<void> _loadUserId() async {
    final id = await getUserDetail.getUserData('id');
    userId = id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("My Invites",style: TextStyles.appBarTitle),
        leadingWidth: 60,
        bottom: TabBar(
          controller: _tabController,
          unselectedLabelStyle: const TextStyle(color: Colors.grey,fontWeight: FontWeight.w500,fontSize: 14),
          labelColor: Colors.black,
          indicatorColor: appColor,
          unselectedLabelColor: Colors.grey,
          tabs: [
            Tab(
                child: SizedBox(
                  width: _width /2,
                  child: const Tab(child: Text("Received")),
                )
            ),
            Tab(
                child: SizedBox(
                  width: _width /2 ,
                  child: const Tab(child: Text("Send")),
                )
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Obx((){
            if (myInviteList.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            if (myInviteList.getMyInviteList.isEmpty) {
              return const Center(child: Text("Data not available"));
            }
            return ListView.builder(
              itemCount: myInviteList.getMyInviteList.length,
              physics: const ScrollPhysics(),
              itemBuilder: (context, index) {
                var data = myInviteList.getMyInviteList[index];
                if(data.senderId.toString() != userId){
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                        border: Border.all(color: Colors.grey,width: 0.5)
                    ),
                    child: Table(
                      columnWidths: const {
                        0: FixedColumnWidth(130),  // Set the width of the first column
                        1: FixedColumnWidth(50),   // Set the width of the second column
                        2: FixedColumnWidth(140),  // Set the width of the third column
                      },
                      children: [
                        TableRow(
                            children: [
                              const Text("Project Name",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                              const Text(":",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                              Text(data.projectName,style: const TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w500),),
                            ]
                        ),
                        TableRow(
                            children: [
                              const Text("Project Owner Name",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                              const Text(":",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                              Text(data.projectOwnerName,style: const TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w500),),
                            ]
                        ),
                        TableRow(
                            children: [
                              const Text("Invited Date",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                              const Text(":",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                              Text(data.invitedDate,style: const TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w500),),
                            ]
                        ),
                        TableRow(
                            children: [
                              const Text("Status",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                              const Text(":",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                              Text(data.status,style: const TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w500),),
                            ]
                        ),
                      ],
                    ),
                  );
                }else{
                  return const SizedBox();
                }
              });
          }),
          Obx((){
            if (myInviteListSend.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            if (myInviteListSend.getMyInviteSendList.isEmpty) {
              return const Center(child: Text("Data not available"));
            }
            return ListView.builder(
              itemCount: myInviteListSend.getMyInviteSendList.length,
              physics: const ScrollPhysics(),
              itemBuilder: (context, index) {
                var data = myInviteListSend.getMyInviteSendList[index];
                if(data.senderId.toString() == userId){
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                        border: Border.all(color: Colors.grey,width: 0.5)
                    ),
                    child: Table(
                      columnWidths: const {
                        0: FixedColumnWidth(130),  // Set the width of the first column
                        1: FixedColumnWidth(50),   // Set the width of the second column
                        2: FixedColumnWidth(120),  // Set the width of the third column
                      },
                      children: [
                        TableRow(
                            children: [
                              const Text("Project Name",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                              const Text(":",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                              Text(data.projectName,style: const TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w500),),
                            ]
                        ),
                        TableRow(
                            children: [
                              const Text("Project Owner Name",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                              const Text(":",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                              Text(data.projectOwnerName,style: const TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w500),),
                            ]
                        ),
                        TableRow(
                            children: [
                              const Text("Invited Date",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                              const Text(":",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                              Text(data.invitedDate,style: const TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w500),),
                            ]
                        ),
                        TableRow(
                            children: [
                              const Text("Status",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                              const Text(":",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                              Text(data.status,style: const TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w500),),
                            ]
                        ),
                      ],
                    ),
                  );
                }else{
                  return const SizedBox();
                }
              },);
          }),
        ],
      ),
    );
  }
}
