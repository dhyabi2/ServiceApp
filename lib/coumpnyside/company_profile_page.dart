import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:cleaning/companysidecontroller.dart';
import 'package:cleaning/utils/color.dart';
import 'package:cleaning/utils/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../customerside/customer_profile_page.dart';
import '../customewidget.dart';
import '../keys.dart';
import '../utils/common_widgets.dart';
import '../utils/image_asset.dart';
import '../utils/string.dart';
import '../welcome_screens/second_welcome_screen.dart';

class CompanyProfilePage extends StatefulWidget {
  const CompanyProfilePage({Key? key}) : super(key: key);

  @override
  State<CompanyProfilePage> createState() => _CompanyProfilePageState();
}

class _CompanyProfilePageState extends State<CompanyProfilePage> {
  CompanySideController companySideController = Get.find();
  Globlecontroller globlecontroller = Get.find();
  TextStyle textStyle = TextStyle(fontSize: 16, color: greyText4, fontWeight: FontWeight.w500, fontFamily: CustomStrings.dnmed);

  @override
  void initState() {
    getProfile();
    super.initState();
  }

  getProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    companySideController.getProviderProfile(prefs.getString(Keys().sessionID)!, prefs.getString(Keys().providerID)!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: bgColor,
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
      bottomNavigationBar: Image.asset(
        ImageAssets.bottomImg2,
        scale: 2,
      ),
      body: Obx(() => companySideController.loading.value || companySideController.isOtherLoading.value
              ? Center(child: CircularProgressIndicator(color: primmarycolor))
              : Stack(
                  children: [
                    Container(
                      color: primmarycolor,
                      width: double.infinity,
                      height: getScreenWidth(context) * 0.45,
                    ),
                    SingleChildScrollView(
                      child: Container(
                        margin: EdgeInsets.only(top: Get.height / 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
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
                                    companySideController.profileName.value,
                                    style: TextStyle(color: knokgrey, fontSize: 22, fontWeight: FontWeight.w400, fontFamily: CustomStrings.dnmed),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        companySideController.profileName.value,
                                        style:
                                            TextStyle(color: blueColor, fontWeight: FontWeight.w500, fontSize: 14, fontFamily: CustomStrings.dnmed),
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
                                        companySideController.profileName.value,
                                        style: TextStyle(color: black, fontWeight: FontWeight.w500, fontSize: 14, fontFamily: CustomStrings.dnmed),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                              "assets/images/job.png",
                                              scale: 3,
                                            ),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            Text(
                                              "${companySideController.customerCount.value} Customer",
                                              style: TextStyle(
                                                  color: lightGrey, fontWeight: FontWeight.w500, fontSize: 14, fontFamily: CustomStrings.dnmed),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 16,
                                        ),
                                        Row(
                                          children: [
                                            Image.asset(
                                              ImageAssets.finishJob,
                                              scale: 2,
                                            ),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            Text(
                                              "${companySideController.jobCount.value} finished jobs",
                                              style: TextStyle(
                                                  color: lightGrey, fontWeight: FontWeight.w500, fontSize: 14, fontFamily: CustomStrings.dnmed),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
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
                            // Obx(
                            //   () => SwitchListTile(
                            //     title: const Text('English'),
                            //     value: globlecontroller.english.value,
                            //     onChanged: (bool value) {
                            //       globlecontroller.english.value = value;
                            //       globlecontroller.arabic.value = !value;
                            //       if (globlecontroller.english.isTrue) {
                            //         Get.updateLocale(const Locale('en', 'En'));
                            //       } else {
                            //         Get.updateLocale(const Locale('ar', 'Ar'));
                            //       }
                            //     },
                            //   ),
                            // ),
                            // ElevatedButton(
                            //     onPressed: () {
                            //       showDialog(
                            //           context: context,
                            //           builder: (BuildContext context) {
                            //             return LogoutDialog();
                            //           });
                            //     },
                            //     child: const Text('Log Out')),
                            // Obx(
                            //   () => SwitchListTile(
                            //     title: const Text('Arabic'),
                            //     value: globlecontroller.arabic.value,
                            //     onChanged: (bool value) async {
                            //       final SharedPreferences prefs = await SharedPreferences.getInstance();
                            //       if (value) {
                            //         await prefs.setBool(Keys().language, false);
                            //         Get.updateLocale(const Locale('ar', 'AR')); // Corrected language code
                            //       } else {
                            //         await prefs.setBool(Keys().language, true);
                            //         Get.updateLocale(const Locale('en', 'EN')); // Corrected language code
                            //       }
                            //       globlecontroller.english.value = !value;
                            //       globlecontroller.arabic.value = value;
                            //     },
                            //   ),
                            // ),
                            // Expanded(child: Container()),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: getScreenWidth(context) * 0.35,
                      top: getScreenHeight(context) * 0.15,
                      child: Container(
                        decoration: BoxDecoration(color: white, borderRadius: BorderRadius.circular(90)),
                        padding: const EdgeInsets.all(2.0),
                        child: companySideController.profilePic.value == ""
                            ? Image.asset(
                                ImageAssets.man,
                                scale: 2.2,
                              )
                            : CircleAvatar(
                                backgroundColor: lightblue,
                                radius: 50,
                                backgroundImage: MemoryImage(base64Decode(companySideController.profilePic.value)),
                              ),
                      ),
                    ),
                  ],
                )
          //: const SizedBox(),

          ),
    );
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
          return EditCompanyProfile(
            name: companySideController.profileName.value,
            description: companySideController.desc.value,
            img: companySideController.profilePic.value,
            // userProfileModel: globlecontroller.userProfileModel,
          );
        });
    getProfile();
  }
// getData() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   await companySideController.getAbout(prefs.getString(Keys().providerID)!);
// }
}

class EditCompanyProfile extends StatefulWidget {
  final String name;
  final String description;
  final String img;

  const EditCompanyProfile({required this.name, required this.img, required this.description, Key? key}) : super(key: key);

  @override
  State<EditCompanyProfile> createState() => _EditCompanyProfileState();
}

class _EditCompanyProfileState extends State<EditCompanyProfile> {
  TextEditingController txtFName = TextEditingController(), txtLName = TextEditingController(), txtJob = TextEditingController();
  Globlecontroller globlecontroller = Get.find();
  Uint8List? bytes;

  @override
  void initState() {
    txtFName.text = widget.name;
    txtJob.text = widget.description;
    if (widget.img != "") {
      bytes = base64Decode(widget.img);
    }
    // txtLName.text = widget.userProfileModel.data.FamilyName;
    // txtJob.text = widget.userProfileModel.data.CurrentWork;
    super.initState();
  }

  XFile? profilePic;

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
                SheetTitle(title: "Edit my company profile".tr),
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
                  "Company name".tr,
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
                  "Company Description".tr,
                  style: descTextStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Add any requirement for the services (Optional) '.tr,
                  style: const TextStyle(
                    color: Color(0xFF668F98),
                    fontSize: 14,
                    fontFamily: CustomStrings.dnmed,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),

                textField(controller: txtJob, hintText: "", suffix: ImageAssets.edit2, keyboardType: TextInputType.text),
                const SizedBox(
                  height: 16,
                ),

                Padding(
                  padding: EdgeInsets.only(left: getScreenWidth(context) * 0.2, right: 10),
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
                                Map<String, String> map = {};
                                map["Name"] = txtFName.text.trim();
                                map["description"] = txtJob.text.trim();
                                map["providerID"] = prefs.getString(Keys().providerID)!;

                                if (profilePic != null) {
                                  map["img"] = globlecontroller.imgName.value;
                                }
                                log(map.toString());
                                globlecontroller.updateProviderProfile(map, profilePic);
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
