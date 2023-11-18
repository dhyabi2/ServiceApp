import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cleaning/customewidget.dart';
import 'package:cleaning/utils/color.dart';
import 'package:cleaning/utils/controller.dart';
import 'package:cleaning/welcome_screens/second_welcome_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Modal/user_profile_model.dart';
import '../keys.dart';
import '../signup/login_screen.dart';
import '../utils/common_widgets.dart';
import '../utils/image_asset.dart';
import '../utils/string.dart';

class CustomerProfilePage extends StatefulWidget {
  const CustomerProfilePage({Key? key}) : super(key: key);

  @override
  State<CustomerProfilePage> createState() => _CustomerProfilePageState();
}

class _CustomerProfilePageState extends State<CustomerProfilePage> {
  Globlecontroller globlecontroller = Get.find();
  TextStyle textStyle = TextStyle(fontSize: 16, color: greyText4, fontWeight: FontWeight.w500, fontFamily: CustomStrings.dnmed);

  @override
  void initState() {
    getProfile();
    super.initState();
  }

  getProfile() async {
    globlecontroller.loading.value = true;
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    globlecontroller.getCustomerProfile(prefs.getString(Keys().sessionID)!, prefs.getString(Keys().customerID)!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Text(
            'My Profile'.tr,
            style: TextStyle(color: white),
          ),
        ),
        body: GetX<Globlecontroller>(
          init: Globlecontroller(),
          builder: (controller) {
            return controller.loading.value
                ? const LoadingWidget()
                : controller.error.value != ""
                    ? ErrorText(error: controller.error.value)
                    : Stack(
                        children: [
                          Container(
                            color: greyText2,
                            width: double.infinity,
                            height: getScreenWidth(context) * 0.5,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: Get.height / 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  //  color: white,
                                  decoration: BoxDecoration(
                                      color: white,
                                      borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(30),
                                        topLeft: Radius.circular(30),
                                      )),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 75,
                                      ),
                                      Text(
                                        controller.profileName.value,
                                        style: TextStyle(color: knokgrey, fontSize: 22, fontWeight: FontWeight.w400, fontFamily: CustomStrings.dnmed),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            controller.userProfileModel.data.CurrentWork ?? "",
                                            style: TextStyle(
                                                color: blueColor, fontWeight: FontWeight.w500, fontSize: 14, fontFamily: CustomStrings.dnmed),
                                          ),
                                          const SizedBox(
                                            width: 7,
                                          ),
                                          Container(
                                            color: black,
                                            height: 20,
                                            width: 2,
                                          ),
                                          const SizedBox(
                                            width: 7,
                                          ),
                                          Text(
                                            controller.userProfileModel.data.CurrentWork ?? "",
                                            style:
                                                TextStyle(color: black, fontWeight: FontWeight.w500, fontSize: 14, fontFamily: CustomStrings.dnmed),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: getScreenHeight(context) * 0.04,
                                ),
                                GestureDetector(
                                  onTap: showEditProfileSheet,
                                  child: Container(
                                    color: white,
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          ImageAssets.edit,
                                          scale: 2,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Modify my Profile".tr,
                                          style: textStyle,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                GestureDetector(
                                  onTap: showLanguageSheet,
                                  child: Container(
                                    color: white,
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          ImageAssets.changeLanguage,
                                          scale: 2,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Change language".tr,
                                          style: textStyle,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                GestureDetector(
                                  onTap: showAboutSheet,
                                  child: Container(
                                    color: white,
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          ImageAssets.about,
                                          scale: 2,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "About Sparkle".tr,
                                          style: textStyle,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                GestureDetector(
                                  onTap: () {
                                    showTermsSheet();
                                  },
                                  child: Container(
                                    color: white,
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          ImageAssets.terms,
                                          scale: 2,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Terms and condition".tr,
                                          style: textStyle,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                GestureDetector(
                                  onTap: () {
                                    showLogoutSheet();
                                    // showDialog(
                                    //               context: context,
                                    //               builder: (BuildContext context) {
                                    //                 return LogoutDialog();
                                    //               });
                                  },
                                  child: Container(
                                    color: white,
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          ImageAssets.logout,
                                          scale: 2,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Logout".tr,
                                          style: textStyle,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            left: getScreenWidth(context) * 0.35,
                            top: getScreenHeight(context) * 0.15,
                            child: Container(
                                decoration: BoxDecoration(color: greyText2, borderRadius: BorderRadius.circular(90)),
                                padding: const EdgeInsets.all(2.0),
                                child: controller.profilePic.value == ""
                                    ? Image.asset(
                                        ImageAssets.man,
                                        scale: 2.2,
                                      )
                                    : CircleAvatar(
                                        backgroundColor: lightblue,
                                        radius: 50,
                                        backgroundImage: MemoryImage(base64Decode(controller.profilePic.value)),
                                      )),
                          ),
                          Positioned(
                              bottom: 0,
                              child: Image.asset(
                                ImageAssets.bottomImg2,
                                scale: 2,
                              ))
                        ],
                      );
          },
        ));
  }

  showLogoutSheet() {
    showModalBottomSheet(
        backgroundColor: white,
        enableDrag: true,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))),
        context: context,
        builder: (context) {
          return const LogoutSheet();
        });
  }

  showTermsSheet() {
    showModalBottomSheet(
        backgroundColor: white,
        enableDrag: true,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))),
        context: context,
        builder: (context) {
          return const TermsSheet();
        });
  }

  showAboutSheet() {
    showModalBottomSheet(
        backgroundColor: white,
        enableDrag: true,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))),
        context: context,
        builder: (context) {
          return const AboutusSheet();
        });
  }

  showLanguageSheet() {
    showModalBottomSheet(
        backgroundColor: white,
        enableDrag: true,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))),
        context: context,
        builder: (context) {
          return LanguageSheet(
            callback: (val) async {
              if (val == Languages.arabic) {
                final SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setBool(Keys().language, false);
                Get.updateLocale(const Locale('ar', 'AR')); // Corrected language code
                globlecontroller.english.value = false;
                globlecontroller.arabic.value = true;
              } else {
                final SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setBool(Keys().language, false);
                Get.updateLocale(const Locale('en', 'En'));
                globlecontroller.english.value = true;
                globlecontroller.arabic.value = false;
              }
            },
          );
        });
  }

  showEditProfileSheet() async {
    await showModalBottomSheet(
        backgroundColor: white,
        enableDrag: true,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))),
        context: context,
        builder: (context) {
          return EditProfileSheet(
            userProfileModel: globlecontroller.userProfileModel,
          );
        });
    getProfile();
  }
}

TextStyle subTitle = TextStyle(
      fontFamily: CustomStrings.dnmed,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: greyColor,
    ),
    descTextStyle = TextStyle(
      fontFamily: CustomStrings.dnmed,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: black2,
    );

class EditProfileSheet extends StatefulWidget {
  final UserProfileModel userProfileModel;

  const EditProfileSheet({required this.userProfileModel, super.key});

  @override
  State<EditProfileSheet> createState() => _EditProfileSheetState();
}

class _EditProfileSheetState extends State<EditProfileSheet> {
  TextEditingController txtFName = TextEditingController(), txtLName = TextEditingController(), txtJob = TextEditingController();
  Globlecontroller globlecontroller = Get.find();
  XFile? profilePic;
  Uint8List? bytes;

  @override
  void initState() {
    txtFName.text = widget.userProfileModel.data.FirstName;
    txtLName.text = widget.userProfileModel.data.FamilyName;
    txtJob.text = widget.userProfileModel.data.CurrentWork ?? "";
    if (widget.userProfileModel.data.img != null) {
      bytes = base64Decode(widget.userProfileModel.data.img!.data);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: LoadingStateWidget(
          isLoading: globlecontroller.isOtherLoading.value,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SheetTitle(title: "Modify your profile".tr),
                GestureDetector(
                  onTap: () async {
                    final ImagePicker picker = ImagePicker();
                    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                    if (image != null) {
                      profilePic = image;
                      setState(() {});
                      // globlecontroller.uploadProfilePic(profilePic);
                    }
                  },
                  child: Stack(
                    children: [
                      Center(
                          child: profilePic != null
                              ? CircleAvatar(radius: 40, backgroundImage: FileImage(File(profilePic!.path)))
                              : bytes != null
                                  ? CircleAvatar(radius: 40, backgroundImage: MemoryImage(bytes!))
                                  : Image.asset(
                                      ImageAssets.man,
                                      scale: 3,
                                    )),
                      Positioned(
                          right: getScreenWidth(context) * 0.36,
                          bottom: 7,
                          child: Image.asset(
                            ImageAssets.edit,
                            scale: 2,
                          ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "firstname".tr,
                  style: descTextStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 16,
                ),
                textField(controller: txtFName, hintText: "", suffix: ImageAssets.edit2, keyboardType: TextInputType.text),
                //  const SizedBox(height: 16,),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "familyname".tr,
                  style: descTextStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 16,
                ),
                textField(controller: txtLName, hintText: "", suffix: ImageAssets.edit2, keyboardType: TextInputType.text),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "Job".tr,
                  style: descTextStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 16,
                ),
                textField(controller: txtJob, hintText: "", suffix: ImageAssets.edit2, keyboardType: TextInputType.text),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: _character == Languages.arabic ? 10 : getScreenWidth(context) * 0.2,
                      right: _character == Languages.arabic ? getScreenWidth(context) * 0.2 : 10),
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
                                final SharedPreferences prefs = await SharedPreferences.getInstance();
                                globlecontroller.updateProfile({
                                  "FirstName": txtFName.text.trim(),
                                  "FamilyName": txtLName.text.trim(),
                                  "CurrentWork": txtJob.text.trim(),
                                  "customerID": prefs.getString(Keys().customerID)!,
                                  "SessionID": prefs.getString(Keys().sessionID)!
                                }, profilePic);
                              },
                              bgColor: white,
                              title: "Save changes".tr))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class LogoutSheet extends StatelessWidget {
  const LogoutSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SheetTitle(title: "Logout".tr),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            "Are you sure to logout from Sparkle ?".tr,
            style: descTextStyle,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.only(left: getScreenWidth(context) * 0.4, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Text(
                    "Close".tr,
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
                  child: appButton(
                      onTap: () async {
                        final SharedPreferences prefs = await SharedPreferences.getInstance();
                        await prefs.setBool(Keys().login, false);
                        await FirebaseMessaging.instance.deleteToken();
                        Get.offAll(const LoginScreen());
                      },
                      clr: redColor,
                      title: "Logout".tr))
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class TermsSheet extends StatelessWidget {
  const TermsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SheetTitle(title: "Terms and conditions".tr),
          Text(
            "By accessing and using Sparkle, you agree to our user account policies, service request processes, payment terms, and user conduct guidelines. We value your privacy; refer to our Privacy Policy for details. Sparkle reserves the right to terminate access for violations or updates to these terms. For questions, contact us at :",
            style: descTextStyle,
            textAlign: TextAlign.start,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Contact us".tr,
            style: TextStyle(
              fontFamily: CustomStrings.dnmed,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: greyColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          Text(
            "Sparkle.support@gmail.com",
            style: descTextStyle,
            textAlign: TextAlign.start,
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

class AboutusSheet extends StatelessWidget {
  const AboutusSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SheetTitle(title: "Terms and conditions".tr),
          Text(
            "About Sparkle".tr,
            style: subTitle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Welcome to Sparkle: Your essential service connection! 🌟 Seamlessly book personalized home services, set your availability and preferences, and let providers propose prices. Effortless, efficient, and always there for you. Let's simplify your life, one service at a time! 💫",
            style: descTextStyle,
            textAlign: TextAlign.start,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Contact us".tr,
            style: subTitle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          Text(
            "Sparkle.support@gmail.com",
            style: descTextStyle,
            textAlign: TextAlign.start,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Connect with us :".tr,
            style: subTitle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Image.asset(
                ImageAssets.insta,
                scale: 2,
              ),
              const SizedBox(
                width: 15,
              ),
              Image.asset(
                ImageAssets.fb,
                scale: 2,
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Version 2.1",
            style: descTextStyle,
            textAlign: TextAlign.start,
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

enum Languages { english, arabic }

Languages? _character = Languages.english;

class LanguageSheet extends StatefulWidget {
  final Function(Languages) callback;

  const LanguageSheet({required this.callback, super.key});

  @override
  State<LanguageSheet> createState() => _LanguageSheetState();
}

class _LanguageSheetState extends State<LanguageSheet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SheetTitle(title: "Language"),
          RadioListTile<Languages>(
            title: Text(
              'English',
              style: descTextStyle,
            ),
            value: Languages.english,
            groupValue: _character,
            onChanged: (Languages? value) {
              setState(() {
                _character = value;
              });
            },
          ),
          RadioListTile<Languages>(
            title: Text(
              'Arabic',
              style: descTextStyle,
            ),
            value: Languages.arabic,
            groupValue: _character,
            onChanged: (Languages? value) {
              setState(() {
                _character = value;
              });
            },
          ),
          Padding(
            padding: EdgeInsets.only(
                left: _character == Languages.arabic ? 10 : getScreenWidth(context) * 0.2,
                right: _character == Languages.arabic ? getScreenWidth(context) * 0.2 : 10),
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
                          widget.callback(_character!);
                          Get.back();
                        },
                        bgColor: white,
                        title: "Save changes".tr))
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

class SheetTitle extends StatelessWidget {
  final String title;

  const SheetTitle({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 17),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.close,
              color: greytext,
            ),
          ),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontFamily: CustomStrings.dnmed,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: black,
                height: 24 / 16,
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
