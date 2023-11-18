import 'dart:convert';

import 'package:cleaning/Modal/my_jobs_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../get_job_proposal_controller.dart';
import '../../keys.dart';
import '../../utils/color.dart';
import '../../utils/common_widgets.dart';
import '../../utils/image_asset.dart';
import '../../utils/string.dart';
import '../customer_profile_page.dart';

class JobProposalListScreen extends StatefulWidget {
  final JobDetails jobData;
  final Customerdetails customerdetails;

  const JobProposalListScreen({required this.jobData, required this.customerdetails, Key? key}) : super(key: key);

  @override
  State<JobProposalListScreen> createState() => _JobProposalListScreenState();
}

class _JobProposalListScreenState extends State<JobProposalListScreen> {
  GetJobProposalController jobProposalController = Get.put(GetJobProposalController());
  final TextEditingController _txtAmount = TextEditingController();
  final TextStyle _txtDesc = const TextStyle(
    color: Color(0xFF3E3E3E),
    fontSize: 14,
    fontFamily: CustomStrings.dnmed,
    fontWeight: FontWeight.w500,
  );

  ShapeDecoration shapeDecoration = ShapeDecoration(
    shape: RoundedRectangleBorder(
      side: const BorderSide(width: 1, color: Color(0xFF9FBDC4)),
      borderRadius: BorderRadius.circular(8),
    ),
  );
  String status = "";

  @override
  void initState() {
    myInit();

    super.initState();
  }

  myInit() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    jobProposalController.getMyJobProposals(
        sessionID: prefs.getString(Keys().sessionID)!, customerID: prefs.getString(Keys().customerID)!, requestID: widget.jobData.requestID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: bgColor,
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(Icons.keyboard_arrow_left_outlined, color: primmarycolor, size: 40)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 20.0, left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GetX<GetJobProposalController>(
              init: GetJobProposalController(),
              builder: (controller) {
                return controller.loading.value
                    ? const LoadingWidget()
                    : controller.error.value != ""
                        ? ErrorText(error: controller.error.value)
                        : controller.proposalList.isEmpty
                            ? const SizedBox()
                            : LoadingStateWidget(
                                isLoading: controller.isOtherLoading.value,
                                child: SizedBox(
                                  height: 340,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    padding: const EdgeInsets.only(top: 10),
                                    itemCount: controller.proposalList.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        width: 267,
                                        height: 340,
                                        margin: const EdgeInsets.only(right: 10),
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                        decoration: ShapeDecoration(
                                          color: white,
                                          shape: RoundedRectangleBorder(
                                            side: const BorderSide(width: 1, color: Color(0xFFD3E1E4)),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                //
                                                controller.proposalList[index].providerDetails[0].img == null
                                                    ? const CircleAvatar(
                                                        radius: 25,
                                                        backgroundColor: Color(0x33B0D6FF),
                                                      )
                                                    : CircleAvatar(
                                                        radius: 25,
                                                        backgroundColor: const Color(0x33B0D6FF),
                                                        backgroundImage:
                                                            MemoryImage(base64Decode(controller.proposalList[index].providerDetails[0].img!.data)),
                                                      ),

                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: Text(
                                                    controller.proposalList[index].providerDetails[0].Name,
                                                    maxLines: 3,
                                                    style: const TextStyle(
                                                      color: Color(0xFF2F4246),
                                                      fontSize: 14,
                                                      fontFamily: CustomStrings.dbold,
                                                      fontWeight: FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 16),
                                            Expanded(
                                              child: Text(
                                                controller.proposalList[index].providerDetails[0].description,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 3,
                                                style: const TextStyle(
                                                  color: Color(0xFF668F98),
                                                  fontSize: 16,
                                                  fontFamily: CustomStrings.dnmed,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 16),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Bid Amount  '.tr,
                                                  style: const TextStyle(
                                                    color: Color(0xFF161616),
                                                    fontSize: 12,
                                                    // fontFamily: 'DM Sans',
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: CustomStrings.dnmed,
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                SizedBox(
                                                  width: double.infinity,
                                                  child: Text(
                                                    controller.proposalList[index].Amount.toString(),
                                                    style: const TextStyle(
                                                      color: Color(0xFF007AFF),
                                                      fontSize: 16,
                                                      fontFamily: CustomStrings.dnmed,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 16),
                                            Container(
                                              width: double.infinity,
                                              height: 48,
                                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                              decoration: ShapeDecoration(
                                                color: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(width: 1, color: Color(0xFF007AFF)),
                                                  borderRadius: BorderRadius.circular(4),
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    ImageAssets.whatsapp,
                                                    scale: 2,
                                                  ),
                                                  Text(
                                                    'Chat now'.tr,
                                                    style: TextStyle(
                                                      color: blueColor,
                                                      fontSize: 14,
                                                      fontFamily: CustomStrings.dbold,
                                                      fontWeight: FontWeight.w700,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            controller.proposalList[index].status == "pending"
                                                ? Row(
                                                    children: [
                                                      Expanded(
                                                        child: ElevatedButton(
                                                            onPressed: () async {
                                                              final SharedPreferences prefs = await SharedPreferences.getInstance();

                                                              controller.respondToProposal(
                                                                sessionID: prefs.getString(Keys().sessionID)!,
                                                                customerID: prefs.getString(Keys().customerID)!,
                                                                proposalID: controller.proposalList[index].proposalID,
                                                                requestID: controller.proposalList[index].requestID,
                                                                requestStatus: true,
                                                              );
                                                            },
                                                            style: ButtonStyle(
                                                                backgroundColor: MaterialStateProperty.all<Color>(primmarycolor),
                                                                padding: MaterialStateProperty.all<EdgeInsets>(
                                                                    const EdgeInsets.only(left: 12, right: 12, top: 2, bottom: 2)),
                                                                elevation: MaterialStateProperty.all<double>(0),
                                                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(7.0),
                                                                ))),
                                                            child: Text(
                                                              "Accept".tr,
                                                              style: const TextStyle(
                                                                fontSize: 12,
                                                                fontFamily: CustomStrings.dnmed,
                                                              ),
                                                            )),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        child: ElevatedButton(
                                                            onPressed: () async {
                                                              final SharedPreferences prefs = await SharedPreferences.getInstance();

                                                              controller.respondToProposal(
                                                                sessionID: prefs.getString(Keys().sessionID)!,
                                                                customerID: prefs.getString(Keys().customerID)!,
                                                                proposalID: controller.proposalList[index].proposalID,
                                                                requestID: controller.proposalList[index].requestID,
                                                                requestStatus: false,
                                                              );
                                                            },
                                                            style: ButtonStyle(
                                                                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                                                padding: MaterialStateProperty.all<EdgeInsets>(
                                                                    const EdgeInsets.only(left: 12, right: 12, top: 2, bottom: 2)),
                                                                elevation: MaterialStateProperty.all<double>(0),
                                                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(7.0),
                                                                ))),
                                                            child: Text(
                                                              "Reject".tr,
                                                              style: const TextStyle(
                                                                fontSize: 12,
                                                                fontFamily: CustomStrings.dnmed,
                                                              ),
                                                            )),
                                                      )
                                                    ],
                                                  )
                                                : controller.proposalList[index].status == "accepted"
                                                    ? Row(
                                                        children: [
                                                          Expanded(
                                                            child: ElevatedButton(
                                                                onPressed: () async {},
                                                                style: ButtonStyle(
                                                                    backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                                                                    padding: MaterialStateProperty.all<EdgeInsets>(
                                                                        const EdgeInsets.only(left: 12, right: 12, top: 2, bottom: 2)),
                                                                    elevation: MaterialStateProperty.all<double>(0),
                                                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                                      borderRadius: BorderRadius.circular(7.0),
                                                                    ))),
                                                                child: Text(
                                                                  "Accepted".tr,
                                                                  style: const TextStyle(
                                                                    fontSize: 12,
                                                                    fontFamily: CustomStrings.dnmed,
                                                                  ),
                                                                )),
                                                          ),
                                                        ],
                                                      )
                                                    : controller.proposalList[index].status == "rejected"
                                                        ? Row(
                                                            children: [
                                                              Expanded(
                                                                child: ElevatedButton(
                                                                    onPressed: () async {},
                                                                    style: ButtonStyle(
                                                                        backgroundColor: MaterialStateProperty.all<Color>(greytext),
                                                                        padding: MaterialStateProperty.all<EdgeInsets>(
                                                                            const EdgeInsets.only(left: 12, right: 12, top: 2, bottom: 2)),
                                                                        elevation: MaterialStateProperty.all<double>(0),
                                                                        shape:
                                                                            MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                                          borderRadius: BorderRadius.circular(7.0),
                                                                        ))),
                                                                    child: Text(
                                                                      "Rejected".tr,
                                                                      style: const TextStyle(
                                                                        fontSize: 12,
                                                                        fontFamily: CustomStrings.dnmed,
                                                                      ),
                                                                    )),
                                                              ),
                                                            ],
                                                          )
                                                        : const SizedBox()
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
              },
            ),
            //  const SheetTitle(title: "Job details"),

            const SizedBox(
              height: 16,
            ),
            Text(
              'Services for the job'.tr,
              style: TextStyle(
                color: black,
                fontSize: 14,
                fontFamily: CustomStrings.dnreg,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(
              height: 16,
            ),
            GridView.builder(
              padding: EdgeInsets.zero,
              //  padding: EdgeInsets.only(left: Get.width / 20, right: Get.width / 20, top: 5),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 7, mainAxisExtent: 23.5 / 0.1),
              itemCount: widget.jobData.services.length,
              // customerSideController.serviceList2.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {},
                  child: Container(
                    color: Colors.transparent,
                    padding: EdgeInsets.only(top: Get.height / 70, right: 5),
                    child: Container(
                      decoration:
                          BoxDecoration(color: white, border: Border.all(width: 2, color: lightBlueColor), borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Spacer(),
                          CircleAvatar(
                            radius: 45,
                            backgroundColor: greyColor,
                            child: CircleAvatar(
                              radius: 44,
                              backgroundColor: white,
                              child: cachedImageForItem(widget.jobData.services[index].img),
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(1.5),
                            child: Center(
                              child: Text(
                                widget.jobData.services[index].name,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: CustomStrings.dbold,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(1.5),
                            child: Center(
                              child: Text(
                                widget.jobData.services[index].description,
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: CustomStrings.dnmed,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Availability'.tr,
              style: TextStyle(
                color: black,
                fontSize: 14,
                fontFamily: CustomStrings.dnreg,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: shapeDecoration,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          ImageAssets.calendar,
                          scale: 2,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Date'.tr,
                          style: const TextStyle(
                            color: Color(0xFF9FBDC4),
                            fontSize: 12,
                            fontFamily: CustomStrings.dnmed,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(widget.jobData.availabilityDateList[0], style: _txtDesc),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: shapeDecoration,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          ImageAssets.time,
                          scale: 2,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Time'.tr,
                          style: const TextStyle(
                            color: Color(0xFF9FBDC4),
                            fontSize: 12,
                            fontFamily: CustomStrings.dnmed,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${widget.jobData.availabilityFrom} - ${widget.jobData.availabilityTo}',
                          style: _txtDesc,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: shapeDecoration,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    ImageAssets.loc2,
                    scale: 2,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Location'.tr,
                    style: const TextStyle(
                      color: Color(0xFF9FBDC4),
                      fontSize: 12,
                      fontFamily: CustomStrings.dnmed,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Selected location'.tr,
                    style: _txtDesc,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'SpecialRequirements'.tr,
              style: TextStyle(
                color: black,
                fontSize: 14,
                fontFamily: CustomStrings.dnreg,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: shapeDecoration,
              child: Text(
                widget.jobData.other,
                style: descTextStyle,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
