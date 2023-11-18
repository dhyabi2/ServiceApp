import 'package:cleaning/Modal/all_jobs_model.dart';
import 'package:cleaning/utils/color.dart';
import 'package:cleaning/utils/controller.dart';
import 'package:cleaning/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../companysidecontroller.dart';
import '../keys.dart';
import '../utils/common_widgets.dart';
import '../utils/image_asset.dart';
import 'job_detail_screen.dart';

class AllJobs extends StatefulWidget {
  const AllJobs({Key? key}) : super(key: key);

  @override
  State<AllJobs> createState() => _AllJobsState();
}

class _AllJobsState extends State<AllJobs> {
  final Globlecontroller globlecontroller = Get.find();
  CompanySideController companySideController = Get.find();
  List jobTypes = ["All", "Unsubmitted", "Under review", "Accepted"];

  @override
  void initState() {
    getData("all");
    super.initState();
  }

  int selectedJobType = 0;

  getData(status) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    companySideController.getAppJobsAPI(prefs.getString(Keys().sessionID)!, prefs.getString(Keys().providerID)!, status);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      // bottomNavigationBar:   Image.asset(ImageAssets.bottomImg2),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: false,
        backgroundColor: bgColor,
        title: Image.asset(
          ImageAssets.sparkleImg,
          scale: 2,
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'All jobs'.tr,
                      style: TextStyle(
                        color: black,
                        fontSize: 22,
                        fontFamily: CustomStrings.dnreg,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Obx(() {
                      return CircleAvatar(
                        radius: 10,
                        backgroundColor: lightblue,
                        child: Text(
                          companySideController.allJobList.length.toString(),
                          style: TextStyle(
                            color: primmarycolor,
                            fontSize: 12,
                            fontFamily: CustomStrings.dnmed,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      );
                    })
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Sort by date'.tr,
                      style: TextStyle(
                        color: blueColor,
                        fontSize: 14,
                        fontFamily: CustomStrings.dnmed,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Image.asset(
                      ImageAssets.sort,
                      scale: 2,
                      color: blueColor,
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            SizedBox(
              height: Get.height * 0.05,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  //   physics: NeverScrollableScrollPhysics(),
                  itemCount: jobTypes.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        selectedJobType = index;
                        switch (selectedJobType) {
                          case 0:
                            getData("all");
                            break;
                          case 1:
                            getData("unsubmitted");
                            break;
                          case 2:
                            getData("under_review");
                            break;
                          case 3:
                            getData("accepted");
                            break;
                        }
                        setState(() {});
                      },
                      child: Container(
                          width: Get.width * 0.3,
                          height: Get.height * 0.01,
                          decoration: BoxDecoration(
                              color: selectedJobType == index ? blueColor : white,
                              border: Border.all(color: blueColor),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(index == 0 ? 8 : 0),
                                  bottomLeft: Radius.circular(index == 0 ? 8 : 0),
                                  bottomRight: Radius.circular(index == jobTypes.length - 1 ? 8 : 0),
                                  topRight: Radius.circular(index == jobTypes.length - 1 ? 8 : 0))),
                          child: Center(
                            child: Text(
                              jobTypes[index].toString().tr,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: index == selectedJobType ? white : blueColor,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: CustomStrings.dnmed),
                            ),
                          )),
                    );
                  }),
            ),
            const SizedBox(
              height: 16,
            ),
            allJobs(),
          ],
        ),
      ),
    );
  }

  Widget allJobs() {
    return Obx(() {
      return companySideController.loading.value
          ? const LoadingWidget()
          : companySideController.error.value != ""
              ? ErrorText(error: companySideController.error.value)
              : ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: companySideController.allJobList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return JobPost(
                      jobData: companySideController.allJobList[index],
                      onTap: () {},
                    );
                  },
                );
    });
  }
}

class JobPost extends StatefulWidget {
  final JobData jobData;
  final GestureTapCallback onTap;

  const JobPost({required this.jobData, required this.onTap, Key? key}) : super(key: key);

  @override
  State<JobPost> createState() => _JobPostState();
}

class _JobPostState extends State<JobPost> {
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
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        decoration: ShapeDecoration(
          color: white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0xFFD3E1E4)),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                  Expanded(
                    child: status == "unsubmited"
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
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    '2 days ago',
                    style: TextStyle(
                      color: Color(0xFF709DA7),
                      fontSize: 12,
                      fontFamily: CustomStrings.dnmed,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Job services'.tr,
              style: const TextStyle(
                color: Color(0xFF2F4246),
                fontSize: 14,
                fontFamily: CustomStrings.dnmed,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 55,
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.jobData.services.length, //customerSideController.myjobList[index].services.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7.0),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: lightblue.withOpacity(0.2),
                        backgroundImage: NetworkImage(widget.jobData.services[i].img),
                      ),
                    );
                  }),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                    backgroundColor: white,
                    enableDrag: true,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))),
                    context: context,
                    builder: (context) {
                      return JobDetailScreen(
                        jobData: widget.jobData,
                      );
                    });
              },
              child: Container(
                height: Get.height / 17,
                decoration: BoxDecoration(color: white, borderRadius: BorderRadius.circular(4), border: Border.all(color: blueColor)),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        status == "unsubmited" ? "Start Bidding".tr : "View details".tr,
                        style: TextStyle(
                          color: blueColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          fontFamily: CustomStrings.dnmed,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Image.asset(
                        status == "unsubmited" ? ImageAssets.arrow1 : ImageAssets.eye2,
                        scale: 2,
                        color: blueColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '${"JOB ID".tr} : ${widget.jobData.requestID}',
              style: TextStyle(
                color: greyText4,
                fontSize: 11,
                fontFamily: CustomStrings.dnmed,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
