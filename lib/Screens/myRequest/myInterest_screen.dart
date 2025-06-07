
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../ApiServies/ProjectApi/myInterest_api.dart';
import '../../Utils/commonStyles.dart';
import '../../Utils/shared_prefernces.dart';

class MyInterest extends StatefulWidget {
  const MyInterest({Key? key}) : super(key: key);

  @override
  State<MyInterest> createState() => _MyInterestState();
}

class _MyInterestState extends State<MyInterest>with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final double _width = Get.width;
  final _getUserDetail = UserLoginDetails();
  final myInterestList = Get.put(MyInterestApiServices());
  final myInterestSendDataList = Get.put(MyInterestApiServices());
  final getUserDetail = UserLoginDetails();
  late final String userId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    load();
    _loadUserId();
  }
  load(){
    setState(() {
      myInterestList.getMyInterestApiService();
      myInterestSendDataList.getMyInterestSendApiService();
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
        title: Text("My Interest",style: TextStyles.appBarTitle),
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
            if (myInterestList.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            if (myInterestList.getMyInterestReList.isEmpty) {
              return const Center(child: Text("Data not available"));
            }
            return ListView.builder(
              itemCount: myInterestList.getMyInterestReList.length,
              physics: const ScrollPhysics(),
              itemBuilder: (context, index) {
                var data = myInterestList.getMyInterestReList[index];
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
                        2: FixedColumnWidth(120),   // Set the width of the third column
                      },
                      children:  [
                        TableRow(
                            children: [
                              const Text("Full Name",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                              const Text(":",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                              Text(data.fullName ?? "",style: const TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w500)),
                            ]
                        ),
                        const TableRow(
                            children: [
                              Text("Skills",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                              Text(":",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                              Text("",style: TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w500),),
                            ]
                        ),
                        TableRow(
                            children: [
                              const Text("Email",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                              const Text(":",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                              Text(data.email ?? "",style: const TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w500),),
                            ]
                        ),
                        TableRow(
                            children: [
                              const Text("Phone No.",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                              const Text(":",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                              Text(data.phone ?? "",style: const TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w500),),
                            ]
                        ),
                        TableRow(
                            children: [
                              const Text("Project Name",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                              const Text(":",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                              Text(data.projectName ?? "",style: const TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w500),),
                            ]
                        ),
                        TableRow(
                            children: [
                              const Text("Status",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                              const Text(":",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                              Text(data.status ?? "",style: const TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w500),),
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
          Obx((){
            if (myInterestSendDataList.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            if (myInterestSendDataList.getMyInterestSendList.isEmpty) {
              return const Center(child: Text("Data not available"));
            }
            return ListView.builder(
              itemCount: myInterestSendDataList.getMyInterestSendList.length,
              physics: const ScrollPhysics(),
              itemBuilder: (context, index) {
                var data = myInterestSendDataList.getMyInterestSendList[index];
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
                    children:  [
                      TableRow(
                          children: [
                            const Text("Full Name",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                            const Text(":",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                            Text(data.fullName ?? "",style: const TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w500),),
                          ]
                      ),
                      const TableRow(
                          children: [
                            Text("Skills",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                            Text(":",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                            Text("",style: const TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w500),),
                          ]
                      ),
                      TableRow(
                          children: [
                            const Text("Email",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                            const Text(":",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                            Text(data.email ?? "",style: const TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w500),),
                          ]
                      ),
                      TableRow(
                          children: [
                            const Text("Phone No.",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                            const Text(":",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                            Text(data.phone ?? "",style: const TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w500),),
                          ]
                      ),
                      TableRow(
                          children: [
                            const Text("Project Name",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                            const Text(":",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                            Text(data.projectName ?? "",style: const TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w500),),
                          ]
                      ),
                      TableRow(
                          children: [
                            const Text("Status",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                            const Text(":",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                            Text(data.status ?? "",style: const TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w500),),
                          ]
                      ),
                    ],
                  ),
                );
              },);
          }),
        ],
      ),
    );
  }
}
