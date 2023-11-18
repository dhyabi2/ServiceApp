import 'package:cleaning/signup/verification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../customewidget.dart';
import '../utils/color.dart';
import '../utils/common_widgets.dart';
import '../utils/controller.dart';
import '../utils/image_asset.dart';
import '../utils/signupController.dart';
import '../utils/string.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  Globlecontroller globlecontroller = Get.find();
  AuthenticationController authenticationController = Get.put(AuthenticationController());

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              "privacyPolicyText".tr,
              textAlign: TextAlign.center,
              style: TextStyle(color: greyText3, fontSize: 12, fontFamily: CustomStrings.dnmed, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Image.asset(
            ImageAssets.bottomImg,
            scale: 2,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: Get.width / 20, vertical: Get.height / 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Signup'.tr,
              style: TextStyle(color: black, fontSize: 35, fontFamily: CustomStrings.dnreg, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: Get.height / 40,
            ),
            Text(
              'Create your account and enjoy our services'.tr,
              style: TextStyle(color: black, fontSize: 15, fontFamily: CustomStrings.dbold, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: Get.height / 50,
            ),
            textField(controller: globlecontroller.familyname, hintText: 'Last name'.tr),
            SizedBox(
              height: Get.height / 40,
            ),
            textField(controller: globlecontroller.username, hintText: 'First name'.tr),
            SizedBox(
              height: Get.height / 40,
            ),
            const SizedBox(height: 5),
            textField(
                controller: globlecontroller.phone,
                hintText: "Phone Number".tr,
                prefix: ImageAssets.phoneIcon,
                maxLength: 8,
                keyboardType: TextInputType.phone),
            SizedBox(
              height: Get.height / 40,
            ),
            Row(
              children: [
                Checkbox(
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.all(blueColor),
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                ),
                Text(
                  "Remember me".tr,
                  style: TextStyle(color: black, fontSize: 14, fontFamily: CustomStrings.dnmed, fontWeight: FontWeight.w500),
                )
              ],
            ),
            SizedBox(
              height: Get.height / 40,
            ),
            appButton(
              onTap: () async {
                FocusScope.of(context).unfocus();
                if (globlecontroller.username.text.isEmpty || globlecontroller.familyname.text.isEmpty || globlecontroller.phone.text.isEmpty) {
                  commonToast('Please Enter all value');
                } else {
                  if (globlecontroller.phone.text.length == 8) {
                    authenticationController.loading.value = true;
                    await authenticationController.signUpApiCall(
                        globlecontroller.username.text, globlecontroller.familyname.text, globlecontroller.phone.text);
                    authenticationController.loading.value = false;
                    if (authenticationController.authenticateStatus.value == 'ok') {
                      Get.to(() => const Verification());
                    } else {
                      commonToast('Error');
                    }
                  } else {
                    commonToast('Please Enter 8 Length Phone Number'.tr);
                  }
                }
              },
              clr: blueColor,
              title: 'Create my account'.tr,
            ),
            SizedBox(
              height: Get.height / 40,
            ),
            Center(
              child: Text(
                "You don't have an account ?".tr,
                style: TextStyle(color: greyText3, fontSize: 15, fontFamily: CustomStrings.dnmed, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: Get.height / 40,
            ),
            appButton2(
              onPressed: () {
                Get.back();
              },
              borderColor: blueColor,
              textColor: blueColor,
              title: "Sign In".tr,
            ),
            Obx(
              () => authenticationController.loading.isTrue
                  ? Padding(
                      padding: EdgeInsets.only(top: Get.height * 0.15),
                      child: Center(child: CircularProgressIndicator(color: primmarycolor)),
                    )
                  : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
