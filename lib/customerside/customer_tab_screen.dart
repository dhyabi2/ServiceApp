import 'package:cleaning/customerside/customer_profile_page.dart';
import 'package:cleaning/customersideController.dart';
import 'package:cleaning/utils/color.dart';
import 'package:cleaning/utils/controller.dart';
import 'package:cleaning/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'customer_job_post_page.dart';
import 'home/customer_home_page.dart';
import 'myjobs/mujobs.dart';
import 'notifications/notification.dart';

class CustomerTabScreen extends StatefulWidget {
    final int selectIndex;
  const CustomerTabScreen({required this.selectIndex,Key? key}) : super(key: key);

  @override
  State<CustomerTabScreen> createState() => _CustomerTabScreenState();
}

class _CustomerTabScreenState extends State<CustomerTabScreen> with TickerProviderStateMixin{
  final Globlecontroller global = Get.find();
  CustomerSideController customerSideController = Get.put(CustomerSideController());
  late TabController _tabController ;

  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this, initialIndex: widget.selectIndex);
    // global.tabIndex.value = widget.selectIndex;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Expanded(
              child: TabBarView(
                  controller: _tabController,
                  physics: NeverScrollableScrollPhysics(), children: [
                CustomerHomePage(),
                MyJobsPage(),
                CustomerJobPostPage(),
                NotificationPage(isCustomer: true),
                CustomerProfilePage(),
              ]),
            ),
           TabBar(
                  controller: _tabController,
                  padding: EdgeInsets.zero,
                  onTap: (val) {
                    _tabController.index =val;
                    setState(() {

                    });
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
                        color:_tabController.index == 0 ? primmarycolor : null,
                      ),
                      text: _tabController.index == 0 ? "Home".tr : null,
                    ),
                    Tab(
                      icon: Image.asset(
                        "assets/images/job.png",
                        scale: 2,
                        color: _tabController.index == 1 ? primmarycolor : null,
                      ),
                      text: _tabController.index == 1 ? "Jobs".tr : null,
                    ),
                    Tab(
                      icon: Image.asset(
                        "assets/images/add.png",
                        scale: 2,
                        color: _tabController.index == 2 ? primmarycolor : null,
                      ),
                      text: _tabController.index == 2 ? "Add Job".tr : null,
                    ),
                    Tab(
                      icon: Image.asset(
                        "assets/images/notification.png",
                        scale: 2,
                        color: _tabController.index == 3 ? primmarycolor : null,
                      ),
                      text: _tabController.index == 3 ? "Notify".tr : null,
                    ),
                    Tab(
                      icon: Image.asset(
                        "assets/images/profile.png",
                        scale: 2,
                        color: _tabController.index == 4 ? primmarycolor : null,
                      ),
                      text: _tabController.index == 4 ? "My Profile".tr : null,
                    )
                  ])

          ],
        ),
      ),
    );
  }
}
