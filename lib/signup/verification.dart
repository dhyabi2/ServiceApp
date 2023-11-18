import 'dart:async';

import 'package:cleaning/utils/color.dart';
import 'package:cleaning/utils/controller.dart';
import 'package:cleaning/utils/string.dart';
import 'package:cleaning/welcome_screens/first_welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_pinput/new_pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../coumpnyside/admin_tab_bar_screen.dart';
import '../keys.dart';
import '../utils/common_widgets.dart';
import '../utils/image_asset.dart';
import '../utils/signupController.dart';

class Verification extends StatefulWidget {
  const Verification({Key? key}) : super(key: key);

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  final pinController = TextEditingController();
  AuthenticationController authenticationController = Get.find();

  final focusNode = FocusNode();
  Timer? _timer;
  int _secondsRemaining = 30;
  bool showButton = false;
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      if (_secondsRemaining == 0) {
        setState(() {
          timer.cancel();
          showButton = true;
        });
      } else {
        setState(() {
          _secondsRemaining--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Globlecontroller globlecontroller = Get.find();

    final defaultPinTheme = PinTheme(
      width: 66,
      height: 66,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        color: const Color(0xffbdd2d7),
        borderRadius: BorderRadius.circular(90),
        border: Border.all(color: lightgrey),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      bottomNavigationBar: Image.asset(
        ImageAssets.bottomImg,
        scale: 2,
      ),
      body: Stack(
        children: [
          SafeArea(
              child: Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.only(left: Get.width / 20, right: Get.width / 20, top: Get.height / 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Get.height / 12,
                  ),
                  Text(
                    'Sign In'.tr,
                    style: TextStyle(color: black, fontSize: 35, fontFamily: CustomStrings.dnreg, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '4GigitMsg'.tr,
                    style: TextStyle(color: greyText2, fontSize: 16, fontFamily: CustomStrings.dbold, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "+968 ${globlecontroller.phone.text}",
                    style: TextStyle(color: darktext, fontSize: 16, fontFamily: CustomStrings.dnreg),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        ImageAssets.resendIcon,
                        scale: 2,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "sendcodeagain".tr,
                        style: TextStyle(color: blueColor, fontSize: 14, fontWeight: FontWeight.w700, fontFamily: CustomStrings.dbold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height / 20,
                  ),
                  Center(
                    child: Directionality(
                      // Specify direction if desired
                      textDirection: TextDirection.ltr,
                      child: Pinput(
                        controller: pinController,
                        // focusNode: focusNode,
                        androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
                        listenForMultipleSmsOnAndroid: true,
                        defaultPinTheme: defaultPinTheme,
                        hapticFeedbackType: HapticFeedbackType.lightImpact,
                        onCompleted: (pin) async {
                          debugPrint('onCompleted: $pin');
                          if (pinController.text.isEmpty) {
                            commonToast('Please Enter Otp'.tr);
                          } else {
                            authenticationController.loading.value = true;
                            await authenticationController.verifyApiCall(globlecontroller.phone.text, pinController.text);
                            authenticationController.loading.value = false;

                            if (authenticationController.verifyOtpStatus.value == 'ok') {
                              final SharedPreferences prefs = await SharedPreferences.getInstance();
                              await prefs.setString(Keys().sessionID, authenticationController.verifyOtpSessionID.value);
                              await prefs.setString(Keys().providerID, authenticationController.verifyOtpProviderID.value);
                              await prefs.setString(Keys().customerID, authenticationController.verifyOtpCustomerID.value);
                              await prefs.setString(Keys().type, authenticationController.verifyOtpType.value);
                              await prefs.setBool(Keys().login, true);
                              await prefs.setString(Keys().profileName, globlecontroller.username.text);

                              if (prefs.getString(Keys().type) == 'customer') {
                                Get.to(() => const FirstWelcomeScreen());
                              } else if (prefs.getString(Keys().type) == 'provider') {
                                Get.to(() => const AdminTabbarScreen());
                              }
                              // Get.to(() => const Confirm(),
                              //     transition: Transition.fadeIn);
                            }
                          }
                        },
                        onChanged: (value) {
                          debugPrint('onChanged: $value');
                        },

                        focusedPinTheme: defaultPinTheme.copyWith(
                          decoration: defaultPinTheme.decoration!.copyWith(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(90),
                            border: Border.all(color: lightgrey),
                          ),
                        ),

                        submittedPinTheme: defaultPinTheme.copyWith(
                          decoration: defaultPinTheme.decoration!.copyWith(
                            color: Colors.transparent,
                            // color:,
                            borderRadius: BorderRadius.circular(90),
                            border: Border.all(color: darktext),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: Get.height / 40,
                  ),
                ],
              ),
            ),
          )),
          Positioned(
              top: 0,
              child: Stack(
                children: [
                  Image.asset(
                    ImageAssets.topImg,
                    scale: 2,
                  ),
                  Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      top: 0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            ImageAssets.newLogo,
                            scale: 2.3,
                          ),
                          Text(
                            'Sparkle'.tr,
                            style: const TextStyle(color: Colors.white, fontSize: 20, fontFamily: CustomStrings.angkor, fontWeight: FontWeight.w400),
                          )
                        ],
                      ))
                ],
              )),
        ],
      ),
    );
  }
}
