import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../ApiServies/auth/updateProfile_api.dart';
import '../../Utils/commonButton.dart';
import '../../Utils/commonStyles.dart';

class CertificateScreen extends StatefulWidget {
  const CertificateScreen({super.key});

  @override
  State<CertificateScreen> createState() => _CertificateScreenState();
}

class _CertificateScreenState extends State<CertificateScreen> {
  final myCertificateList = Get.put(UpdateProfileApiServices());

  @override
  void initState() {
    super.initState();
    myCertificateList.getCertificateApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Certificate", style: TextStyles.appBarTitle),
      ),
      body: Obx(() {
        if (myCertificateList.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (myCertificateList.getMyCertificateList.isEmpty) {
          return const Center(child: Text("No Certificate available."));
        }
        return ListView.builder(
          itemCount: myCertificateList.getMyCertificateList.length,
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          itemBuilder: (context, index) {
            var data = myCertificateList.getMyCertificateList[index];
            return Row(
              children: [
                Flexible(
                  child: Container(
                    height: 35,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: appColor,
                      border: Border.all(color: Colors.grey, width: 0.5),
                    ),
                    child: Text(data.certificateName, style: TextStyles.buttonStyle),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    onTapDeleteCertificate(context, "${data.id}");
                  },
                  child: const Icon(Icons.delete_forever, color: Colors.red, size: 35),
                ),
              ],
            );
          },
        );
      }),
    );
  }

  void onTapDeleteCertificate(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            height: 165,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Are You Sure?", style: TextStyles.appBarTitle),
                const SizedBox(height: 20),
                Text("You won't be able to revert this!", style: TextStyles.labelStyle),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: ()async {
                        await myCertificateList.deleteCertificateApi(id: id);
                        Navigator.pop(context);
                        myCertificateList.getCertificateApi();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 100,
                        height: 35,
                        decoration: BoxDecoration(
                            color: appColor,
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: const Text("Yes, Delete it!",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 14)),
                      ),
                    ),
                    GestureDetector(
                      onTap: ()async {
                        Navigator.pop(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 80,
                        height: 35,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.blue,width: 0.5),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: const Text("Cancel",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w500,fontSize: 14)),
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

