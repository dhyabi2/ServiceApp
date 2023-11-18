import 'package:cleaning/utils/color.dart';
import 'package:cleaning/utils/common_widgets.dart';
import 'package:cleaning/utils/controller.dart';
import 'package:cleaning/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../customersideController.dart';
import '../../keys.dart';
import '../../utils/image_asset.dart';

class NotificationPage extends StatefulWidget {
  final bool isCustomer;

  const NotificationPage({required this.isCustomer, Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final Globlecontroller globlecontroller = Get.find();
  CustomerSideController customerSideController = Get.find();

  @override
  void initState() {
    getApi();
    super.initState();
  }

  getApi() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    customerSideController.getCustomerNotification(prefs.getString(Keys().sessionID)!, prefs.getString(Keys().customerID)!);
  }

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
            'Notifications'.tr,
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(4.0),
            child: Container(
              color: appBarBorderColor,
              height: 2.0,
            ),
          ),
        ),
        body: Obx(
          () => customerSideController.loading.isFalse ? notificationlist() : const LoadingWidget(),
        ));
  }

  Widget notificationlist() {
    return customerSideController.notificationList.isEmpty
        ? Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        ImageAssets.dotImg,
                        scale: 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 3.0, top: 3),
                        child: Image.asset(ImageAssets.dotImg, scale: 3, color: const Color(0xff9fbdc4)),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              ImageAssets.noNotificationImg,
                              scale: 2,
                            ),
                          ),
                          Positioned(
                              right: 3,
                              bottom: 17,
                              child: Image.asset(
                                ImageAssets.dotImg,
                                scale: 2,
                              )),
                          Positioned(top: 5, right: 15, child: Image.asset(ImageAssets.dotImg, scale: 3, color: const Color(0xff9fbdc4)))
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text("No notifications", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400, fontFamily: CustomStrings.dnmed, color: black)),
              const SizedBox(
                height: 20,
              ),
              const Text("we will notify you when there is\n something new",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, fontFamily: CustomStrings.dnmed, color: Color(0xff9fbdc4)))
            ],
          ))
        : ListView.builder(
            itemCount: customerSideController.notificationList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(color: white),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 10),
                  child: Row(
                    children: [
                      Image.asset(
                        ImageAssets.noNotificationImg,
                        scale: 2,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          customerSideController.notificationList[index].message,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: knokgrey,
                            fontSize: 14,
                            fontFamily: CustomStrings.dnmed,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          customerSideController.notificationList[index].timestamp.split("GMT")[0],
                          style: TextStyle(color: greytext, fontSize: 12, fontWeight: FontWeight.w500, fontFamily: CustomStrings.dnmed),
                        ),
                      ),
                      // SizedBox(
                      //   width: Get.width / 5,
                      // ),
                      // Image.asset(
                      //   "assets/images/rate.png",
                      //   scale: 4,
                      // ),
                    ],
                  ),
                ),
              );
            },
          );
  }

  Widget button({required String data, required Color color}) {
    return Container(
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width / 12, vertical: Get.height / 110),
          child: Text(
            data,
            style: TextStyle(color: white, fontFamily: CustomStrings.dnreg),
          ),
        ),
      ),
    );
  }
}
