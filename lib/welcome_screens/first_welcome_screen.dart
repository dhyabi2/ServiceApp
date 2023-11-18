import 'package:cleaning/customewidget.dart';
import 'package:cleaning/utils/color.dart';
import 'package:cleaning/utils/image_asset.dart';
import 'package:cleaning/utils/string.dart';
import 'package:cleaning/welcome_screens/second_welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../customerside/customer_tab_screen.dart';

class FirstWelcomeScreen extends StatefulWidget {
  const FirstWelcomeScreen({super.key});

  @override
  State<FirstWelcomeScreen> createState() => _FirstWelcomeScreenState();
}

class _FirstWelcomeScreenState extends State<FirstWelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Image.asset(
            ImageAssets.sparkleImg,
            scale: 2,
          )),
      bottomNavigationBar: Image.asset(
        ImageAssets.bottomImg,
        scale: 2,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Image.asset(
            ImageAssets.rightTick,
            scale: 2,
          )),
          const SizedBox(
            height: 15,
          ),
          Text(
            "Welcome To Sparkle".tr,
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.w400, color: black2, fontFamily: CustomStrings.dnreg),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.33),
            child: appButton(
                title: "Take a tour".tr,
                onTap: () {
                  Get.to(() => const SecondWelcomeScreen());
                },
                clr: blueColor),
          ),
          const SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => const CustomerTabScreen(
                selectIndex: 0,
              ));
            },
            child: Text(
              "Skip for now".tr,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: blueColor, fontFamily: CustomStrings.dbold),
            ),
          ),
        ],
      ),
    );
  }
}
