import 'dart:async';

import 'package:cleaning/keys.dart';
import 'package:cleaning/utils/color.dart';
import 'package:cleaning/utils/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'coumpnyside/admin_tab_bar_screen.dart';
import 'customerside/customer_tab_screen.dart';
import 'onbording.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(Keys().login) == true) {
      if (prefs.getString(Keys().type) == 'customer') {
        Timer(
          const Duration(seconds: 4),
          () => Get.offAll(
            () => const CustomerTabScreen(
              selectIndex: 0,
            ),
          ),
        );
      } else if (prefs.getString(Keys().type) == 'provider') {
        Timer(
          const Duration(seconds: 4),
          () => Get.offAll(
            () => const AdminTabbarScreen(),
          ),
        );
      }
    } else {
      Timer(
        const Duration(seconds: 4),
        () => Get.offAll(
          () => const BoardingPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primmarycolor,
      body: Center(
        child: Image.asset(
          width: double.infinity,
          ImageAssets.splashScreen,
          scale: 3,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
