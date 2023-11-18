import 'dart:async';
import 'dart:ui' as ui;

import 'package:cleaning/customersideController.dart';
import 'package:cleaning/customewidget.dart';
import 'package:cleaning/utils/color.dart';
import 'package:cleaning/utils/controller.dart';
import 'package:cleaning/utils/image_asset.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../keys.dart';
import '../utils/common_widgets.dart';
import '../utils/string.dart';
import '../welcome_screens/second_welcome_screen.dart';
import 'congrats_screen.dart';
import 'customer_profile_page.dart';
import 'location_screen.dart';

class CustomerJobPostPage extends StatefulWidget {
  const CustomerJobPostPage({Key? key}) : super(key: key);

  @override
  State<CustomerJobPostPage> createState() => _CustomerJobPostPageState();
}

class _CustomerJobPostPageState extends State<CustomerJobPostPage> {
  TextStyle t1 = const TextStyle(
        color: Color(0xFF007AFF),
        fontSize: 14,
        fontFamily: CustomStrings.dnmed,
        fontWeight: FontWeight.w500,
      ),
      t2 = const TextStyle(
        color: Color(0xFF668F98),
        fontSize: 12,
        fontFamily: CustomStrings.dnmed,
        fontWeight: FontWeight.w500,
      ),
      hintTextStyle = const TextStyle(
        color: Color(0xFF668F98),
        fontSize: 14,
        fontFamily: CustomStrings.dnmed,
        fontWeight: FontWeight.w500,
      );

  final Globlecontroller globlecontroller = Get.find();
  CustomerSideController customerSideController = Get.find();

  TextEditingController txtLoc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: bgColor,
          centerTitle: true,
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Text(
            'Create a job'.tr,
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(4.0),
            child: Container(
              color: appBarBorderColor,
              height: 2.0,
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Obx(
              () => LoadingStateWidget(
                isLoading: customerSideController.loading.value,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title(),
                    listview(),
                    serviece(),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: Get.width / 20),
                      child: Row(
                        children: [
                          Text(
                            'Choose availability'.tr,
                            style: TextStyle(color: black, fontSize: 16, fontFamily: CustomStrings.dnmed),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Container(
                              height: 2,
                              color: appBarBorderColor,
                              width: double.infinity,
                            ),
                          )
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              // width: 186,
                              height: 122,
                              padding: const EdgeInsets.all(16),
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(width: 1, color: Color(0xFFD3E1E4)),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        ImageAssets.calendar,
                                        scale: 2,
                                      ),
                                      const SizedBox(width: 8),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5.0),
                                        child: Text('Choose a date '.tr, style: t2),
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: showDateBottomSheet,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 2,
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            ImageAssets.add,
                                            color: blueColor,
                                            scale: 3,
                                          ),
                                          const SizedBox(
                                            width: 7,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 3.0),
                                            child: Text(
                                                globlecontroller.formattedDate.value == "" ? 'Add a date'.tr : globlecontroller.formattedDate.value,
                                                maxLines: 2,
                                                //  textAlign: TextAlign.center,
                                                style: t1),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Container(
                              // width: 186,
                              height: 122,
                              padding: const EdgeInsets.all(16),
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(width: 1, color: Color(0xFFD3E1E4)),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        ImageAssets.time,
                                        scale: 2,
                                      ),
                                      const SizedBox(width: 8),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5.0),
                                        child: Text('Choose a time '.tr, style: t2),
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: showTimeBottomSheet,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 2,
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            ImageAssets.add,
                                            color: blueColor,
                                            scale: 3,
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 3.0),
                                            child: Text(globlecontroller.selectTime.value == "" ? 'Add a time'.tr : globlecontroller.selectTime.value,
                                                //  textAlign: TextAlign.center,
                                                style: t1),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // const SizedBox(height: 15,),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        color: white,
                        child: TextFormField(
                          readOnly: true,
                          controller: txtLoc,
                          onTap: () {
                            showMapBottomSheet();
                          },
                          style: TextStyle(
                            fontSize: Get.height / 50,
                            color: darktext,
                          ),
                          decoration: InputDecoration(
                            hintText: "Add a location".tr,
                            hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w300, fontFamily: CustomStrings.dnmed, color: greyText2),
                            prefixIcon: Image.asset(
                              ImageAssets.loc2,
                              scale: 1,
                            ),
                            suffixIcon: Image.asset(
                              ImageAssets.loc1,
                              scale: 1,
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: Get.height / 70, horizontal: Get.width / 30),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: lightgrey),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: lightgrey,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        )),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: Get.width / 20),
                      child: Row(
                        children: [
                          Text(
                            'Any Special requirements ?'.tr,
                            style: TextStyle(color: black, fontSize: 16, fontFamily: CustomStrings.dnmed),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Container(
                              height: 2,
                              color: appBarBorderColor,
                              width: double.infinity,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                      child: Text('Add any requirement for the services (Optional) '.tr, style: hintTextStyle),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      color: white,
                      child: TextField(
                        maxLines: 5,
                        maxLength: 300,
                        controller: globlecontroller.anyOtherRequirementController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: "Write here".tr,
                            hintStyle: hintTextStyle),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      child: Row(
                        children: [
                          Expanded(
                              child: appButton2(
                                  onPressed: () {
                                    globlecontroller.clearAllData();
                                    customerSideController.subName.clear();
                                  },
                                  title: "Discard".tr,
                                  borderColor: blueColor,
                                  textColor: blueColor,
                                  img: ImageAssets.close,
                                  bgColor: white)),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                              child: appButton2(
                                  onPressed: () async {
                                    if (globlecontroller.dateController.selectedDate == null ||
                                        globlecontroller.selectTime.value == "" ||
                                        globlecontroller.selectedLatitude.value == 0.0 ||
                                        globlecontroller.anyOtherRequirementController.text.isEmpty) {
                                      commonToast('Please Enter all value'.tr);
                                    } else {
                                      final SharedPreferences prefs = await SharedPreferences.getInstance();
                                      List date = [];
                                      date.add(globlecontroller.formattedDate.value);
                                      customerSideController.loading.value = true;
                                      bool response = await customerSideController.submitReport(
                                          prefs.getString(Keys().customerID)!,
                                          prefs.getString(Keys().sessionID)!,
                                          customerSideController.subName,
                                          date,
                                          globlecontroller.selectTime.value,
                                          globlecontroller.selectTime.value,
                                          [globlecontroller.selectedLatitude.value, globlecontroller.selectedLongitude.value],
                                          globlecontroller.anyOtherRequirementController.text);
                                      customerSideController.loading.value = false;
                                      if (response == true) {
                                        //   showCustomDialog(context);
                                        await Future.delayed(const Duration(seconds: 1));
                                        globlecontroller.clearAllData();
                                        customerSideController.subName.clear();
                                        Get.to(() => const CongratsScreen());
                                      }
                                    }
                                  },
                                  title: "Submit Job".tr,
                                  borderColor: blueColor,
                                  textColor: white,
                                  img: ImageAssets.send,
                                  bgColor: blueColor)),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: Get.height / 30,
                    ),

                    Obx(
                      () => customerSideController.loading.isTrue
                          ? Padding(
                              padding: EdgeInsets.only(top: Get.height * 0.3),
                              child: Center(
                                child: CircularProgressIndicator(color: primmarycolor),
                              ),
                            )
                          : const SizedBox(),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget title() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 25, horizontal: Get.width / 20),
      child: Row(
        children: [
          Text(
            'Choose a service'.tr,
            style: TextStyle(color: black, fontSize: 16, fontFamily: CustomStrings.dnmed),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Container(
              height: 2,
              color: appBarBorderColor,
              width: double.infinity,
            ),
          )
        ],
      ),
    );
  }

  Widget listview() {
    return SizedBox(
      height: Get.height * 0.05,
      child: ListView.builder(
          padding: EdgeInsets.only(
            left: Get.width * 0.05,
          ),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: customerSideController.categoryList.length,
          itemBuilder: (context, index) {
            return Obx(
              () => GestureDetector(
                onTap: () {
                  customerSideController.serviceIndex.value = index;
                  customerSideController.serviceList2.clear();
                  for (var service in customerSideController.serviceList) {
                    if (service.category == customerSideController.categoryList[index]) {
                      customerSideController.serviceList2.add(service);
                    }
                  }
                },
                child: Container(
                    width: Get.width * 0.2,
                    height: Get.height * 0.01,
                    decoration: BoxDecoration(
                        color: customerSideController.serviceIndex.value == index ? blueColor : white,
                        border: Border.all(color: blueColor),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(index == 0 ? 8 : 0),
                            bottomLeft: Radius.circular(index == 0 ? 8 : 0),
                            bottomRight: Radius.circular(index == customerSideController.categoryList.length - 1 ? 8 : 0),
                            topRight: Radius.circular(index == customerSideController.categoryList.length - 1 ? 8 : 0))),
                    child: Center(
                      child: Text(
                        customerSideController.categoryList[index],
                        style: TextStyle(fontSize: 15, color: index == customerSideController.serviceIndex.value ? white : blueColor),
                      ),
                    )),
              ),
            );
          }),
    );
  }

  Widget serviece() {
    return GridView.builder(
      padding: EdgeInsets.only(left: Get.width / 20, right: Get.width / 20, top: 5),
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 7, mainAxisExtent: 23.5 / 0.1),
      itemCount: customerSideController.serviceList2.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            customerSideController.serviceList2[index].isSelected = !customerSideController.serviceList2[index].isSelected;
            if (customerSideController.serviceList2[index].isSelected) {
              customerSideController.subName.add({"service": customerSideController.serviceList2[index].serviceId, "quantity": "1"});
            } else {
              customerSideController.subName.removeWhere((element) => element["service"] == customerSideController.serviceList2[index].serviceId);
            }
            setState(() {});
          },
          child: Obx(
            () => Container(
              color: Colors.transparent,
              padding: EdgeInsets.only(top: Get.height / 80, right: 5),
              child: Container(
                decoration: BoxDecoration(
                    color: white,
                    border: Border.all(width: 2, color: customerSideController.serviceList2[index].isSelected ? blueColor : lightBlueColor),
                    borderRadius: BorderRadius.circular(10)),
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
                        child: Image.network(
                          customerSideController.serviceList2[index].img,
                          scale: 6,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(1.5),
                      child: Center(
                        child: Text(
                          customerSideController.serviceList2[index].name,
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
                          customerSideController.serviceList2[index].description,
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
                    CircleAvatar(
                      radius: 13,
                      backgroundColor: blueColor,
                      child: CircleAvatar(
                        radius: 12,
                        backgroundColor: customerSideController.serviceList2[index].isSelected ? blueColor : white,
                        child: Center(
                            child: customerSideController.serviceList2[index].isSelected
                                ? Image.asset(
                                    ImageAssets.minus,
                                    // color: blueColor,
                                    // size: 20,
                                  )
                                : Image.asset(
                                    ImageAssets.add,
                                    color: blueColor,
                                    // size: 20,
                                  )),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  showDateBottomSheet() {
    showModalBottomSheet(
        backgroundColor: white,
        enableDrag: true,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))),
        context: context,
        builder: (context) {
          return ShowDateSheet(
            selectedDate: (val) {
              globlecontroller.dateController = val;
              final DateTime now = globlecontroller.dateController.selectedDate!;
              final DateFormat formatter = DateFormat('yyyy-MM-dd');
              globlecontroller.formattedDate.value = formatter.format(now);
              // print( globlecontroller.dateController);
            },
          );
        });
  }

  showTimeBottomSheet() {
    showModalBottomSheet(
        backgroundColor: white,
        enableDrag: true,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))),
        context: context,
        builder: (context) {
          return ShowTimeSheet(
            time: (DateTime val) {
              globlecontroller.selectTime.value = '${val.hour} : ${val.minute}';
            },
          );
        });
  }

  showMapBottomSheet() {
    showModalBottomSheet(
        backgroundColor: white,   isScrollControlled: true,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))),
        context: context,
        builder: (context) {
          return  FractionallySizedBox(
            heightFactor: 0.9,
            child:ShowMapSheet(
              latLng: (double lat, double long) {
                globlecontroller.selectedLatitude.value = lat;
                globlecontroller.selectedLongitude.value = long;
                txtLoc.text = "location selected";
              },
            ),
          );
        });
  }
}

class ShowDateSheet extends StatefulWidget {
  final Function(DateRangePickerController) selectedDate;

  const ShowDateSheet({required this.selectedDate, Key? key}) : super(key: key);

  @override
  State<ShowDateSheet> createState() => _ShowDateSheetState();
}

class _ShowDateSheetState extends State<ShowDateSheet> {
  DateRangePickerController dateController = DateRangePickerController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SheetTitle(title: "Choose a date ".tr),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: SfDateRangePicker(
              backgroundColor: lightblue.withOpacity(0.2),
              controller: dateController,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: getScreenWidth(context) * 0.25, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Text(
                      "Discard".tr,
                      style: TextStyle(
                        fontFamily: CustomStrings.dnmed,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: blueColor,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Expanded(
                    child: appButton2(
                        borderColor: blueColor,
                        textColor: blueColor,
                        onPressed: () async {
                          widget.selectedDate(dateController);
                          Get.back();
                        },
                        bgColor: white,
                        title: "Save changes".tr))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ShowTimeSheet extends StatefulWidget {
  final Function(DateTime) time;

  const ShowTimeSheet({required this.time, Key? key}) : super(key: key);

  @override
  State<ShowTimeSheet> createState() => _ShowTimeSheetState();
}

class _ShowTimeSheetState extends State<ShowTimeSheet> {
  @override
  void initState() {
    super.initState();
  }

  DateTime _selectedTime = DateTime.now();
  String time = "-";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          SheetTitle(title: "Choose a time ".tr),
          Expanded(
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.time,
              initialDateTime: DateTime.now(),
              onDateTimeChanged: (newTime) {
                setState(() {
                  _selectedTime = newTime;
                  //  time = "${_selectedTime.hour} : ${_selectedTime.minute}";
                });
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: getScreenWidth(context) * 0.25, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Text(
                      "Discard".tr,
                      style: TextStyle(
                        fontFamily: CustomStrings.dnmed,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: blueColor,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Expanded(
                    child: appButton2(
                        borderColor: blueColor,
                        textColor: blueColor,
                        onPressed: () async {
                          widget.time(_selectedTime);
                          Get.back();
                        },
                        bgColor: white,
                        title: "Save changes".tr))
              ],
            ),
          ),
        ],
      ),
    );
  }
}


