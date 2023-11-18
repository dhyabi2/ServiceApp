import 'package:cleaning/utils/color.dart';
import 'package:cleaning/utils/image_asset.dart';
import 'package:cleaning/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'customer_tab_screen.dart';

class CongratsScreen extends StatelessWidget {
  const CongratsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: Image.asset(
            ImageAssets.rightTick2,
            scale: 2,
          )),
          const SizedBox(
            height: 24,
          ),
          Text(
            'The Job posted successfully '.tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: black,
              fontSize: 22,
              fontFamily: CustomStrings.dnreg,
              fontWeight: FontWeight.w300,
              //     height: 0.06,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          GestureDetector(
            onTap: () {
              // Get.offAll(()=>);
              Get.offAll(() => const CustomerTabScreen(
                selectIndex: 0,
              ));
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'Return to home page'.tr,
                style: TextStyle(
                  color: blueColor,
                  fontSize: 14,
                  fontFamily: CustomStrings.dnreg,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
