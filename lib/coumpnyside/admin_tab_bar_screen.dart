import 'package:cleaning/coumpnyside/company_profile_page.dart';
import 'package:cleaning/utils/color.dart';
import 'package:cleaning/utils/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../companysidecontroller.dart';
import '../utils/string.dart';
import 'all_jobs.dart';
import 'notification.dart';

class AdminTabbarScreen extends StatefulWidget {
  const AdminTabbarScreen({Key? key}) : super(key: key);

  @override
  State<AdminTabbarScreen> createState() => _AdminTabbarScreenState();
}

class _AdminTabbarScreenState extends State<AdminTabbarScreen> {
  final Globlecontroller global = Get.find();
  CompanySideController companySideController = Get.put(CompanySideController());

  @override
  void initState() {
    global.tabIndex.value == 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
                child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                AllJobs(),
                CompanyNotificationPage(),
                CompanyProfilePage()
                //         : Container(),
              ],
            )),
            Obx(() {
              return TabBar(
                  padding: EdgeInsets.zero,
                  onTap: (val) {
                    global.tabIndex.value = val;
                  },
                  indicatorColor: primmarycolor,
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(color: primmarycolor, width: 2.0),
                    insets: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 70.0),
                  ),
                  labelColor: primmarycolor,
                  labelStyle: TextStyle(fontWeight: FontWeight.w700, fontFamily: CustomStrings.dnmed, fontSize: 10, color: primmarycolor),
                  tabs: [
                    Tab(
                      iconMargin: EdgeInsets.zero,
                      icon: Image.asset(
                        "assets/images/home.png",
                        scale: 2,
                        color: global.tabIndex.value == 0 ? primmarycolor : null,
                      ),
                      text: global.tabIndex.value == 0 ? "Home".tr : null,
                    ),
                    Tab(
                      icon: Image.asset(
                        "assets/images/notification.png",
                        scale: 2,
                        color: global.tabIndex.value == 1 ? primmarycolor : null,
                      ),
                      text: global.tabIndex.value == 1 ? "Notify".tr : null,
                    ),
                    Tab(
                      icon: Image.asset(
                        "assets/images/profile.png",
                        scale: 2,
                        color: global.tabIndex.value == 2 ? primmarycolor : null,
                      ),
                      text: global.tabIndex.value == 2 ? "My Profile".tr : null,
                    )
                  ]);
            }),
            // Obx(
            //   () => CustomBottomBarA(
            //     size: size,
            //     funcOne: () {
            //       global.tabIndex.value = 0;
            //     },
            //     funcTwo: () {
            //       global.tabIndex.value = 1;
            //     },
            //     funcThree: () {
            //       global.tabIndex.value = 2;
            //     },
            //     fucFour: () {
            //       global.tabIndex.value = 3;
            //     },
            //     index: global.tabIndex.value,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
