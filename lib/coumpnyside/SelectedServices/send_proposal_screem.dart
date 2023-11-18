import 'package:cleaning/Modal/all_jobs_model.dart';
import 'package:cleaning/utils/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../customewidget.dart';
import '../../keys.dart';
import '../../send_proposal_controller.dart';
import '../../utils/color.dart';
import '../../utils/string.dart';
import '../admin_tab_bar_screen.dart';

class SendPropsalScreen extends StatefulWidget {
  final JobData jobData;

  const SendPropsalScreen({required this.jobData, Key? key}) : super(key: key);

  @override
  State<SendPropsalScreen> createState() => _SendPropsalScreenState();
}

class _SendPropsalScreenState extends State<SendPropsalScreen> {
  bool selectServicesShow = true, setAvailabilityShow = true, showReq = true;
  TextEditingController amountController = TextEditingController();
  TextEditingController txtController = TextEditingController();
  SendProposalController sendProposalController = Get.put(SendProposalController());

  @override
  void initState() {
    txtController.text = widget.jobData.other;
    sendProposalController.getServices();
    if (widget.jobData.proposalID != null) {
      amountController.text = widget.jobData.amount.toString() + " OMR".tr;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        backgroundColor: lightblue.withOpacity(0.2),
        body: GetX<SendProposalController>(
          init: SendProposalController(),
          builder: (controller) {
            if (controller.loading.value) {
              return const LoadingWidget();
            }
            return LoadingStateWidget(
              isLoading: controller.isOtherLoading.value,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: Get.width / 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(Icons.keyboard_arrow_left_outlined, color: primmarycolor, size: 40)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Services'.tr,
                          style: TextStyle(color: darktext, fontSize: 22, fontFamily: CustomStrings.font),
                        ),
                        GestureDetector(
                            onTap: () {
                              selectServicesShow = !selectServicesShow;
                              setState(() {});
                            },
                            child: Image(
                                fit: BoxFit.fill,
                                image: AssetImage(selectServicesShow ? 'assets/images/DownArrow.png' : 'assets/images/UpArrow.png'),
                                height: Get.height * 0.04))
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    selectServicesShow
                        ? ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: widget.jobData.services.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: Get.height * 0.01,
                                ),
                                child: Material(
                                  elevation: 5,
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    height: Get.height / 10,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: Get.width / 30,
                                          ),
                                          cachedImageForItem(
                                            controller.serviceList.singleWhere((element) => element.name == widget.jobData.services[index].name).img,
                                            width: Get.width * 0.1,
                                            height: Get.height * 0.05,
                                          ),
                                          SizedBox(
                                            width: Get.width * 0.02,
                                          ),
                                          Text(
                                            widget.jobData.services[index].name,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontFamily: CustomStrings.dnreg,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(children: [
                                        CircleAvatar(
                                            backgroundColor: primmarycolor,
                                            radius: 16,
                                            child: Text(
                                              widget.jobData.services[index].quantity.toString(),
                                              style: const TextStyle(fontFamily: CustomStrings.dnreg, color: Colors.white),
                                            )),
                                        SizedBox(
                                          width: Get.width / 30,
                                        ),
                                      ]),
                                    ]),
                                  ),
                                ),
                              );
                            },
                          )
                        : const SizedBox(),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Availability'.tr,
                              style: TextStyle(color: darktext, fontSize: 22, fontFamily: CustomStrings.font),
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            GestureDetector(
                                onTap: () {
                                  setAvailabilityShow = !setAvailabilityShow;
                                  setState(() {});
                                },
                                child: Image(
                                    fit: BoxFit.fill,
                                    image: AssetImage(setAvailabilityShow ? 'assets/images/DownArrow.png' : 'assets/images/UpArrow.png'),
                                    height: Get.height * 0.04))
                          ],
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        setAvailabilityShow
                            ? Material(
                                elevation: 5,
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Availability Date".tr,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              // color: primmarycolor,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: CustomStrings.dnreg,
                                            ),
                                          ),
                                          Text(
                                            widget.jobData.availabilityDateList[0],
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: primmarycolor,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: CustomStrings.dnreg,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "AvailabilityFrom".tr,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              // color: primmarycolor,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: CustomStrings.dnreg,
                                            ),
                                          ),
                                          Text(
                                            widget.jobData.availabilityFrom,
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: primmarycolor,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: CustomStrings.dnreg,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "AvailabilityTime".tr,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              // color: primmarycolor,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: CustomStrings.dnreg,
                                            ),
                                          ),
                                          Text(
                                            widget.jobData.availabilityTo,
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: primmarycolor,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: CustomStrings.dnreg,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: Get.width * 0.02),
                              child: Text(
                                'SpecialRequirements'.tr,
                                style: TextStyle(color: darktext, fontSize: 22, fontFamily: CustomStrings.font),
                              ),
                            ),
                            GestureDetector(
                                onTap: () {
                                  showReq = !showReq;
                                  setState(() {});
                                },
                                child: Image(
                                    fit: BoxFit.fill,
                                    image: AssetImage(showReq ? 'assets/images/DownArrow.png' : 'assets/images/UpArrow.png'),
                                    height: Get.height * 0.04))
                          ],
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        showReq
                            ? Material(
                                elevation: 5,
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  color: Colors.white,
                                  margin: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                                  height: Get.height * 0.1,
                                  width: Get.width,
                                  padding: EdgeInsets.only(top: Get.height * 0.02),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                                    child: TextField(
                                      maxLines: null,
                                      controller: txtController,

                                      //     globlecontroller.specialRequirementsController,
                                      style: const TextStyle(fontSize: 18, fontFamily: CustomStrings.font),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18, fontFamily: CustomStrings.font),
                                        hintText: 'NA'.tr,
                                        //const TextStyle(fontSize: 18,fontFamily:  CustomStrings.font),
                                      ),
                                      expands: true,
                                      keyboardType: TextInputType.multiline,
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: Get.width * 0.02,
                          ),
                          child: Row(
                            children: [
                              Container(
                                  height: Get.height * 0.09,
                                  width: Get.width * 0.09,
                                  decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/money.png')))),
                              SizedBox(
                                width: Get.width * 0.02,
                              ),
                              Text(
                                'yourBid'.tr,
                                style: TextStyle(color: darktext, fontSize: 22, fontFamily: CustomStrings.font),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            color: Colors.white,
                            margin: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                            height: Get.height * 0.09,
                            width: Get.width,
                            padding: EdgeInsets.only(top: Get.height * 0.02),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
                              child: TextField(
                                controller: amountController,
                                style: const TextStyle(fontSize: 18, fontFamily: CustomStrings.font),
                                textInputAction: TextInputAction.done,

                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'enterTotalAmount'.tr,
                                ),
                                // expands: true,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        widget.jobData.proposalID != null
                            ? Padding(
                                padding: EdgeInsets.symmetric(horizontal: Get.width / 20),
                                child: appButton(
                                  title: "Status: ".tr + widget.jobData.proposalStatus.toString().tr,
                                  onTap: () {},
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.symmetric(horizontal: Get.width / 20),
                                child: appButton(
                                  title: "Submit".tr,
                                  onTap: () async {
                                    if (amountController.text.isEmpty) {
                                      commonToast('enterTotalAmount'.tr);
                                      return;
                                    }

                                    final SharedPreferences prefs = await SharedPreferences.getInstance();

                                    await controller.submitProposalApi(
                                        customerID: widget.jobData.customerDetails[0].customerID,
                                        requestID: widget.jobData.requestID,
                                        providerID: prefs.getString(Keys().providerID)!,
                                        amount: amountController.text,
                                        sessionID: prefs.getString(Keys().sessionID)!);
                                    if (controller.submitProposal.value == 'ok') {
                                      showCustomDialog(context);
                                      await Future.delayed(const Duration(seconds: 1));
                                      Get.offAll(() => const AdminTabbarScreen());
                                    }
                                  },
                                ),
                              ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void showCustomDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 700),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Container(
            height: Get.height * 0.5,
            width: Get.width,
            margin: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(40)),
            child: Column(children: [
              Padding(
                padding: EdgeInsets.only(top: Get.height * 0.07),
                child: Image(
                  image: const AssetImage('assets/images/trueIcon.png'),
                  height: Get.height * 0.3,
                ),
              ),
              Material(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
                  child: SizedBox(
                    width: Get.width,
                    child: Text(
                      'anyOtherRequirement'.tr,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              )
            ]),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: const Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }
}
