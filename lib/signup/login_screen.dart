import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cleaning/signup/sign_up_screen.dart';
import 'package:cleaning/signup/verification.dart';
import 'package:cleaning/utils/color.dart';
import 'package:cleaning/utils/common_widgets.dart';
import 'package:cleaning/utils/controller.dart';
import 'package:cleaning/utils/image_asset.dart';
import 'package:cleaning/utils/signupController.dart';
import 'package:cleaning/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:google_sign_in/google_sign_in.dart';
import '../coumpnyside/admin_tab_bar_screen.dart';
import '../customewidget.dart';
import '../keys.dart';
import '../welcome_screens/first_welcome_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  Globlecontroller globlecontroller = Get.find();
  AuthenticationController authenticationController = Get.put(AuthenticationController());

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  bool isChecked = true;
  List<String> list = <String>['English', 'Arabic'];
  late String dropdownValue;

  @override
  void initState() {
    // dropdownValue = list.first;
    myInit();
    super.initState();
  }

  myInit() async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // print(prefs.getBool(Keys().language));
    // bool? data2 = prefs.getBool(Keys().language);
    // await prefs.setBool(Keys().language, false);
    // Get.updateLocale(const Locale('ar', 'AR')); // Corrected language code
    // globlecontroller.english.value = false;
    // globlecontroller.arabic.value = true;
    if(globlecontroller.english.value ==true){
      dropdownValue = list.first;
    }else{
      dropdownValue = list[1];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_drop_down),
            elevation: 16,
            style: TextStyle(color: black, fontSize: 16, fontFamily: CustomStrings.dnreg),
            underline: Container(
                // height: 2,
                // color: Colors.deepPurpleAccent,
                ),
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                dropdownValue = value!;
                if (dropdownValue == list.first) {
                  Get.updateLocale(const Locale('en', 'En'));
                } else {
                  Get.updateLocale(const Locale('ar', 'Ar'));
                }
              });
            },
            items: list.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          )
        ],
      ),
      bottomNavigationBar: Image.asset(
        ImageAssets.bottomImg,
        scale: 2,
      ),
      body: Obx(() {
        return LoadingStateWidget(
          isLoading: authenticationController.loading.value,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width / 20, vertical: Get.height / 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Get.height / 8,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.updateLocale(const Locale('es'));
                          // MyApp().changeLanguage(Locale('ar'));
                        },
                        child: Text(
                          'Sign In'.tr,
                          style: TextStyle(color: black, fontSize: 35, fontFamily: CustomStrings.dnreg, fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        height: Get.height / 40,
                      ),
                      // Text(
                      //   'firstname'.tr,
                      //   style: TextStyle(color: black, fontSize: 16, fontFamily: CustomStrings.dnreg),
                      // ),
                      // SizedBox(height: 5),
                      // textField(controller: globlecontroller.username),
                      // SizedBox(
                      //   height: Get.height / 40,
                      // ),
                      // Text(
                      //   'familyname'.tr,
                      //   style: TextStyle(color: black, fontSize: 16, fontFamily: CustomStrings.dnreg),
                      // ),
                      // SizedBox(height: 5),
                      // textField(controller: globlecontroller.familyname,),
                      // SizedBox(
                      //   height: Get.height / 40,
                      // ),
                      // Text(
                      //   'phonenum'.tr,
                      //   style: TextStyle(color: black, fontSize: 16, fontFamily: CustomStrings.dnreg),
                      // ),
                      SizedBox(height: 5),
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
                          if (globlecontroller.phone.text.isEmpty) {
                            commonToast('Please Enter mobile no.'.tr);
                          } else {
                            if (globlecontroller.phone.text.length == 8) {
                              authenticationController.loading.value = true;
                              await authenticationController.signUpApiCall(
                                  globlecontroller.username.text, globlecontroller.familyname.text, globlecontroller.phone.text);
                              authenticationController.loading.value = false;
                              if (authenticationController.authenticateStatus.value == 'ok') {
                                Get.to(() => Verification());
                              } else {
                                commonToast("Invalid number".tr);
                              }
                            } else {
                              commonToast('Please Enter 8 Length Phone Number'.tr);
                            }
                          }
                        },
                        clr: blueColor,
                        title: 'login'.tr,
                      ),
                      SizedBox(
                        height: Get.height / 40,
                      ),
                      appButton2(
                          onPressed: _loginWithGoogle, borderColor: black2, textColor: black2, title: "Continue with Google".tr, img: ImageAssets.googleLogo),
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
                          print("aaaa");
                          Get.to(SignUpScreen());
                        },
                        borderColor: blueColor,
                        textColor: blueColor,
                        title: "Signup".tr,
                      ),
                    ],
                  ),
                ),
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
                                  style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: CustomStrings.angkor, fontWeight: FontWeight.w400),
                                )
                              ],
                            ))
                      ],
                    )),
                // Positioned(
                //     bottom: 0,
                //     child: Image.asset(ImageAssets.bottomImg,scale: 2,))
              ],
            ),
          ),
        );
      }),
    );
  }


  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> _loginWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      _forceAuthInit();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );
        UserCredential result = await auth.signInWithCredential(authCredential);
        User? user = result.user;
        if (user != null) {
          commonToast(user.displayName.toString());
          _googleSignInController({
            "name": user.displayName.toString(),
            "email": user.email.toString(),
            "googleId": user.uid.toString(),
          });
        }
      } else {
        commonToast("Something went wrong");
      }
    } catch (ex) {
      log("error====$ex");
    }
  }

  _googleSignInController(Map<String, String> map) async {
    authenticationController.loading.value = true;
    await authenticationController.signUpGoogle(
        map["name"]!, map["name"]!, map["googleId"]!,);
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

    }}



  Future<void> _forceAuthInit() async {
    await FirebaseAuth.instance.authStateChanges().first;
  }
}
