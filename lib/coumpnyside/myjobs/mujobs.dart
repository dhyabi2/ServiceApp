import 'package:cleaning/utils/color.dart';
import 'package:cleaning/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../get_my_proposal_controller.dart';
import '../../keys.dart';
import '../../utils/common_widgets.dart';
import '../SelectedServices/send_proposal_screem.dart';

class MyJobsPage extends StatefulWidget {
  const MyJobsPage({Key? key}) : super(key: key);

  @override
  State<MyJobsPage> createState() => _MyJobsPageState();
}

class _MyJobsPageState extends State<MyJobsPage> {
  // final Globlecontroller globlecontroller = Get.find();
  GetMyProposalController companySideController = Get.put(GetMyProposalController());

  @override
  void initState() {
    mtyInit();
    super.initState();
  }

  mtyInit() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    companySideController.getMyProposals(prefs.getString(Keys().sessionID)!, prefs.getString(Keys().providerID)!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightblue.withOpacity(0.2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          'allreque'.tr,
          style: TextStyle(fontSize: 18, fontFamily: CustomStrings.font, color: darktext),
        ),
      ),
      body: GetX<GetMyProposalController>(
        init: GetMyProposalController(),
        builder: (logic) {
          return companySideController.loading.value
              ? const LoadingWidget()
              : companySideController.error.value != ""
                  ? ErrorText(error: companySideController.error.value)
                  : ListView.builder(
                      itemCount: companySideController.allJobList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: Get.height / 50, left: Get.width / 20, right: Get.width / 20),
                          child: Material(
                            elevation: 2,
                            borderRadius: BorderRadius.circular(20),
                            child: GestureDetector(
                              onTap: () {
                                Get.to(() => SendPropsalScreen(
                                      jobData: companySideController.allJobList[index],
                                    ));
                              },
                              child: Container(
                                width: double.infinity,
                                height: Get.height / 6,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: white),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          Image.asset(
                                            "assets/images/pro.png",
                                            scale: 3,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  companySideController.allJobList[index].customerDetails[0].FirstName,
                                                  style: TextStyle(color: knokgrey, fontSize: 16, fontFamily: CustomStrings.dbold),
                                                ),
                                                Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: companySideController.allJobList[index].proposalStatus == "pending"
                                                            ? Colors.blue
                                                            : companySideController.allJobList[index].proposalStatus == "accepted"
                                                                ? Colors.green
                                                                : companySideController.allJobList[index].proposalStatus == "rejected"
                                                                    ? Colors.red
                                                                    : knokgrey,
                                                      ),
                                                      borderRadius: BorderRadius.circular(4)),
                                                  child: Text(
                                                    companySideController.allJobList[index].proposalStatus.toString(),
                                                    style: TextStyle(
                                                        color: companySideController.allJobList[index].proposalStatus == "pending"
                                                            ? Colors.blue
                                                            : companySideController.allJobList[index].proposalStatus == "accepted"
                                                                ? Colors.green
                                                                : companySideController.allJobList[index].proposalStatus == "rejected"
                                                                    ? Colors.red
                                                                    : knokgrey,
                                                        fontSize: 13,
                                                        fontFamily: CustomStrings.dbold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Expanded(
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Service needed : ".tr,
                                                    maxLines: 3,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: primmarycolor,
                                                      fontSize: 14,
                                                      fontFamily: CustomStrings.dnmed,
                                                    ),
                                                  ),
                                                  for (var i in companySideController.allJobList[index].services)
                                                    Expanded(
                                                      child: Text(
                                                        "${i.name}, ",
                                                        maxLines: 3,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                          color: greytext,
                                                          fontSize: 14,
                                                          fontFamily: CustomStrings.dnmed,
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 7),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Bid Amount : ".tr,
                                                  maxLines: 3,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: primmarycolor,
                                                    fontSize: 14,
                                                    fontFamily: CustomStrings.dnmed,
                                                  ),
                                                ),
                                                // for (var i in companySideController.allJobList[index].services)
                                                Text(
                                                  companySideController.allJobList[index].amount.toString(),
                                                  maxLines: 3,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: greytext,
                                                    fontSize: 14,
                                                    fontFamily: CustomStrings.dnmed,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 7),
                                            Row(
                                              children: [
                                                GestureDetector(
                                                    onTap: () async {
//${ companySideController.allJobList[index].customerDetails[0].phone}
                                                      var contact = "+968${companySideController.allJobList[index].customerDetails[0].phone}";
                                                      //  var androidUrl = "whatsapp://send?phone=+919723797904&text=";
                                                      var androidUrl = "whatsapp://send?phone=$contact&text=";
                                                      try {
                                                        await launchUrl(Uri.parse(androidUrl));
                                                      } on Exception {
                                                        commonToast("Something went wrong.");
                                                      }
                                                    },
                                                    child: Image.asset(
                                                      "assets/images/Whatsapp.png",
                                                      scale: 2.5,
                                                    )),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                GestureDetector(
                                                  onTap: () async {
                                                    double lat = companySideController.allJobList[index].location[0];
                                                    double lng = companySideController.allJobList[index].location[1];
                                                    var uri = Uri.parse("google.navigation:q=$lat,$lng&mode=d");
                                                    if (await canLaunch(uri.toString())) {
                                                      await launch(uri.toString());
                                                    } else {
                                                      throw 'Could not launch ${uri.toString()}';
                                                    }
                                                  },
                                                  child: Image.asset(
                                                    "assets/images/location.png",
                                                    scale: 2.5,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
        },
      ),
    );
  }
//
// Widget notificationList() {
//   if (companySideController.getLatestRequest.isNotEmpty) {
//     return ListView.builder(
//       itemCount: companySideController.getLatestRequest.length,
//       shrinkWrap: true,
//       itemBuilder: (context, index) {
//         return Padding(
//           padding: EdgeInsets.only(
//               bottom: Get.height / 50,
//               left: Get.width / 20,
//               right: Get.width / 20),
//           child: Material(
//             elevation: 2,
//             borderRadius: BorderRadius.circular(20),
//             child: GestureDetector(onTap: () {
//               // Get.to(()=>SelectedServices(index));
//             },
//               child: Container(
//                 width: double.infinity,
//                 height: Get.height / 9,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20), color: white),
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: Get.width / 30),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       SizedBox(
//                         width: Get.width / 1.5,
//                         child: Text(
//                           companySideController
//                               .getLatestRequest[index].requestID
//                               .toString(),
//                           maxLines: 3,
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(
//                             color: black,
//                             fontSize: 14,
//                             fontFamily: CustomStrings.dnmed,
//                           ),
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           Text(
//                             "ServicesNeeded".tr,
//                             maxLines: 3,
//                             overflow: TextOverflow.ellipsis,
//                             style: TextStyle(
//                               color: primmarycolor,
//                               fontSize: 14,
//                               fontFamily: CustomStrings.dnmed,
//                             ),
//                           ),
//                           SizedBox(
//                             width: Get.width / 3,
//                             child: Text(
//                               companySideController
//                                   .getLatestRequest[index].services
//                                   .toString()
//                                   .replaceAll('[', '')
//                                   .replaceAll(']', ''),
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                               style: TextStyle(
//                                 color: darktext,
//                                 fontSize: 14,
//                                 fontFamily: CustomStrings.dnmed,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Text(
//                             "AvailabilityTime".tr,
//                             maxLines: 3,
//                             overflow: TextOverflow.ellipsis,
//                             style: TextStyle(
//                               color: primmarycolor,
//                               fontSize: 14,
//                               fontFamily: CustomStrings.dnmed,
//                             ),
//                           ),
//                           SizedBox(
//                             width: Get.width / 3,
//                             child: Text(
//                               '${companySideController.getLatestRequest[index].availabilityFrom.toString()} - ${companySideController
//                                   .getLatestRequest[index].availabilityTo.toString()}',
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                               style: TextStyle(
//                                 color: darktext,
//                                 fontSize: 14,
//                                 fontFamily: CustomStrings.dnmed,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   } else {
//     companySideController.getProviderRequest();
//     return companySideController.loading.isTrue
//         ? Padding(
//       padding: EdgeInsets.only(top: Get.height * 0.15),
//       child: Center(
//           child: CircularProgressIndicator(color: primmarycolor)),
//     )
//         : const SizedBox();
//   }
// }
}
