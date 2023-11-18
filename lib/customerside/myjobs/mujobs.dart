import 'dart:convert';

import 'package:cleaning/customewidget.dart';
import 'package:cleaning/utils/color.dart';
import 'package:cleaning/utils/common_widgets.dart';
import 'package:cleaning/utils/controller.dart';
import 'package:cleaning/utils/string.dart';
import 'package:cleaning/welcome_screens/second_welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp/whatsapp.dart';

import '../../customersideController.dart';
import '../../keys.dart';
import '../../utils/image_asset.dart';
import 'job_proposal_list.dart';

class MyJobsPage extends StatefulWidget {
  const MyJobsPage({Key? key}) : super(key: key);

  @override
  State<MyJobsPage> createState() => _MyJobsPageState();
}

class _MyJobsPageState extends State<MyJobsPage> {
  final Globlecontroller globlecontroller = Get.find();
  CustomerSideController customerSideController = Get.find();
  WhatsApp whatsapp = WhatsApp();
  bool isJobDone = false;

  @override
  void initState() {
    // TODO: implement initState
    getMyPostedJobs("pending");
    super.initState();
  }

  getMyPostedJobs(String status) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString(Keys().customerID)!);
    print(
      prefs.getString(Keys().sessionID)!,
    );

    customerSideController.getMyJobData(prefs.getString(Keys().customerID)!, prefs.getString(Keys().sessionID)!, status);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(4.0),
            child: Container(
              color: appBarBorderColor,
              height: 2.0,
            ),
          ),
          backgroundColor: Colors.transparent,
          centerTitle: true,
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Text(
            'View Jobs'.tr,
            // style: TextStyle(fontSize: 18, fontFamily: CustomStrings.font, color: darktext),
          ),
        ),
        body: Obx(() {
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: getScreenWidth(context) * 0.08, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            isJobDone = false;
                            getMyPostedJobs("pending");
                            setState(() {});
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 12),
                            decoration: BoxDecoration(
                                color: !isJobDone ? primmarycolor : Colors.white,
                                border: Border.all(color: primmarycolor),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                )),
                            child: Text("Jobs in progress".tr,
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: !isJobDone ? Colors.white : primmarycolor,
                                    fontFamily: CustomStrings.dnreg)),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            isJobDone = true;
                            getMyPostedJobs("completed");
                            setState(() {});
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 12),
                            decoration: BoxDecoration(
                                color: isJobDone ? primmarycolor : Colors.white,
                                border: Border.all(color: primmarycolor),
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                )),
                            child: Text("Jobs done".tr,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: isJobDone ? Colors.white : primmarycolor,
                                    fontFamily: CustomStrings.dnreg)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                customerSideController.loading.isFalse ? myJobList() : const LoadingWidget(),
              ],
            ),
          );
        }));
  }

  Widget myJobList() {
    return Obx(
      () => customerSideController.myjobList.isEmpty
          ? Center(
              child: Text(
              "No job has been created by you.".tr,
              style: const TextStyle(fontFamily: CustomStrings.dbold),
            ))
          : ListView.builder(
              itemCount: customerSideController.myjobList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: Get.height / 50, left: Get.width / 20, right: Get.width / 20),
                  child: Material(
                    elevation: 2,
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: white),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                customerSideController.myjobList[index].other,
                                style: TextStyle(
                                  color: black,
                                  fontSize: 14,
                                  fontFamily: CustomStrings.dnmed,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                customerSideController.myjobList[index].createdAt.contains("T")
                                    ? customerSideController.myjobList[index].createdAt.split("T")[0]
                                    : "",
                                style: TextStyle(
                                  color: lightGrey,
                                  fontSize: 12,
                                  fontFamily: CustomStrings.dnmed,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            '${'You have'.tr} ${customerSideController.myjobList[index].proposal.length} ${"proposals".tr}',
                            style: TextStyle(
                              color: lightGrey,
                              fontSize: 14,
                              fontFamily: CustomStrings.dbold,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: customerSideController.myjobList[index].proposal.isNotEmpty ? 16 : 0,
                          ),
                          customerSideController.myjobList[index].proposal.isNotEmpty
                              ? SizedBox(
                                  height: 130,
                                  child: ListView.builder(
                                      itemCount: customerSideController.myjobList[index].proposal.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, i) {
                                        return Container(
                                          margin: const EdgeInsets.only(right: 10),
                                          width: 142,
                                          // height: 116,
                                          padding: const EdgeInsets.all(14),
                                          decoration: ShapeDecoration(
                                            color: const Color(0xFFF1F5F6),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              customerSideController.myjobList[index].proposal[i].providerDetails.img == null
                                                  ? const CircleAvatar(
                                                      backgroundColor: Color(0x33B0D6FF),
                                                      radius: 30,
                                                    )
                                                  : CircleAvatar(
                                                      backgroundColor: const Color(0x33B0D6FF),
                                                      radius: 30,
                                                      backgroundImage: MemoryImage(base64Decode(
                                                          customerSideController.myjobList[index].proposal[i].providerDetails.img!.data)),
                                                    ),
                                              const SizedBox(height: 16),
                                              Text(
                                                customerSideController.myjobList[index].proposal[i].providerDetails.Name,
                                                style: TextStyle(
                                                  color: black,
                                                  fontSize: 14,
                                                  fontFamily: CustomStrings.dbold,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                )
                              : const SizedBox(),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            'Services for the job'.tr,
                            style: TextStyle(
                              color: lightGrey,
                              fontSize: 14,
                              fontFamily: CustomStrings.dbold,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          // const SizedBox(
                          //   height: 16,
                          // ),
                          SizedBox(
                            height: 59,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: customerSideController.myjobList[index].services.length,
                                itemBuilder: (context, i) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                                    child: CircleAvatar(
                                      radius: 22,
                                      backgroundColor: lightblue.withOpacity(0.2),
                                      backgroundImage: NetworkImage(customerSideController.myjobList[index].services[i].img),
                                    ),
                                  );
                                }),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          appButton2(
                              onPressed: () {
                                Get.to(() => JobProposalListScreen(
                                      customerdetails: customerSideController.requestModal.data.customerdetails,
                                      jobData: customerSideController.myjobList[index],
                                    ));
                              },
                              title: "View details".tr,
                              borderColor: primmarycolor,
                              textColor: primmarycolor,
                              img: ImageAssets.eye2,
                              bgColor: white)
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

// void openWhatsApp(String phoneNumber) async {
//   String url = "https://wa.me/$phoneNumber";
//
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     throw "Could not launch $url";
//   }
// }
}
