import 'package:cleaning/customerside/customer_profile_page.dart';
import 'package:cleaning/utils/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Modal/all_jobs_model.dart';
import '../customewidget.dart';
import '../keys.dart';
import '../send_proposal_controller.dart';
import '../utils/color.dart';
import '../utils/image_asset.dart';
import '../utils/string.dart';
import 'admin_tab_bar_screen.dart';

class JobDetailScreen extends StatefulWidget {
  final JobData jobData;

  const JobDetailScreen({required this.jobData, Key? key}) : super(key: key);

  @override
  State<JobDetailScreen> createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends State<JobDetailScreen> {
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
    if (widget.jobData.proposalDetails.isEmpty) {
      status = "unsubmited";
    } else {
      if (widget.jobData.proposalDetails[0].status == "pending") {
        status = "underReview";
      } else {
        status = "accepted";
      }
      _txtAmount.text = widget.jobData.proposalDetails[0].Amount.toString() + " OMR".tr;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: GetX<SendProposalController>(
        init: SendProposalController(),
        builder: (controller) {
          return LoadingStateWidget(
            isLoading: controller.isOtherLoading.value,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SheetTitle(title: "Job details".tr),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: Container()),
                      Image.asset(
                        status == "unsubmited"
                            ? ImageAssets.unSubmittedIcon
                            : status == "underReview"
                                ? ImageAssets.underReviewIcon
                                : status == "accepted"
                                    ? ImageAssets.acceptedIcon
                                    : "",
                        scale: 2,
                      ),
                      const SizedBox(width: 8),
                      status == "unsubmited"
                          ? Text(
                              'Proposal unsubmitted',
                              style: TextStyle(
                                color: lightGrey,
                                fontSize: 14,
                                fontFamily: CustomStrings.dnmed,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          : status == "underReview"
                              ? Text(
                                  'Under review',
                                  style: TextStyle(
                                    color: yellowColor,
                                    fontSize: 14,
                                    fontFamily: CustomStrings.dnmed,
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
                              : status == "accepted"
                                  ? Text(
                                      'Proposal Accepted',
                                      style: TextStyle(
                                        color: greenColor,
                                        fontSize: 14,
                                        fontFamily: CustomStrings.dnmed,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    )
                                  : const SizedBox(),
                    ],
                  ),
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
                          padding: EdgeInsets.only(top: Get.height / 80, right: 5),
                          child: Container(
                            decoration: BoxDecoration(
                                color: white, border: Border.all(width: 2, color: lightBlueColor), borderRadius: BorderRadius.circular(10)),
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
                  Text(
                    'Amount'.tr,
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
                  textField(controller: _txtAmount, hintText: "Amount".tr, maxLength: 8, keyboardType: TextInputType.number),
                  const SizedBox(
                    height: 16,
                  ),
                  status != "unsubmited"
                      ? const SizedBox()
                      : appButton2(
                          title: "Submit".tr,
                          onPressed: () async {
                            if (_txtAmount.text.isEmpty) {
                              commonToast('enterTotalAmount'.tr);
                              return;
                            }

                            final SharedPreferences prefs = await SharedPreferences.getInstance();

                            await controller.submitProposalApi(
                                customerID: widget.jobData.customerDetails[0].customerID,
                                requestID: widget.jobData.requestID,
                                providerID: prefs.getString(Keys().providerID)!,
                                amount: _txtAmount.text,
                                sessionID: prefs.getString(Keys().sessionID)!);
                            if (controller.submitProposal.value == 'ok') {
                              // showCustomDialog(context);
                              await Future.delayed(const Duration(seconds: 1));
                              Get.offAll(() => const AdminTabbarScreen());
                            }
                          },
                          borderColor: blueColor,
                          textColor: blueColor,
                          bgColor: white)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
