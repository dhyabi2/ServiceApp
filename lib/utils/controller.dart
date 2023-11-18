import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../Modal/user_profile_model.dart';
import 'Urls/urls.dart';

class Globlecontroller extends GetxController {
  RxString language = "en".obs;
  RxString dropdownvalue = '968'.obs;
  RxInt tabIndex = 0.obs;
  RxInt selectsrev = 0.obs;
  RxBool english = true.obs;
  RxBool arabic = false.obs;
  RxBool selectServicesShow = false.obs;
  RxBool setAvailabilityShow = false.obs;
  RxBool anyOtherRequirement = false.obs;
  RxInt selectServices = 0.obs;
  RxDouble selectedLatitude = 0.0.obs;
  RxDouble selectedLongitude = 0.0.obs;
  RxString formattedDate = "".obs;
  RxString selectTime = "".obs;
  DateRangePickerController dateController = DateRangePickerController();
  TextEditingController anyOtherRequirementController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  RxString profileName = ''.obs;
  RxString desc = ''.obs;
  RxString profilePic = ''.obs;

  var items = [
    '968',
  ].obs;

  TextEditingController username = TextEditingController();
  TextEditingController familyname = TextEditingController();
  TextEditingController phone = TextEditingController();

  void selecttab(int index) {
    selectsrev.value = index;
  }

  updateLanguage(Locale locale) {
    Get.updateLocale(locale);
  }

  RxBool loading = false.obs;
  RxBool isOtherLoading = false.obs;
  RxString error = "".obs;
  late UserProfileModel userProfileModel;

  getCustomerProfile(String sessionID, String customerID) async {
    loading.value = true;
    error("");
    profileName("");
    profilePic("");
    try {
      log('${Urls().basicUrl}${Urls().getProfile}');
      log(customerID);
      log(sessionID);
      final response = await http.post(Uri.parse('${Urls().basicUrl}${Urls().getProfile}'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode({"customerID": customerID, "SessionID": sessionID}));
      log(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        userProfileModel = UserProfileModel.fromJson(jsonData);
        profileName.value = "${userProfileModel.data.FirstName} ${userProfileModel.data.FamilyName}";
        if (userProfileModel.data.img != null) {
          profilePic.value = userProfileModel.data.img!.data;
        }
        // debugPrint(response.body);
        loading.value = false;
      } else {
        debugPrint('Error in getCustomerNotification');
        error('Error in getCustomerNotification');
        loading.value = false;
      }
    } catch (Error) {
      loading.value = false;
      error(Error.toString());
    }
  }

  clearAllData() {
    selectedLatitude(0.0);
    selectedLongitude(0.0);
    selectTime("");
    formattedDate("");
    anyOtherRequirementController.clear();
  }

  updateProfile(Map<String, String> map, XFile? img) async {
    isOtherLoading.value = true;
    error("");
    profileName("");
    try {
      log('${Urls().basicUrl}${Urls().editProfile}');
      var request = http.MultipartRequest('POST', Uri.parse('${Urls().basicUrl}${Urls().editProfile}'));
      request.headers.addAll(
        {
          'Content-Type': 'application/json',
        },
      );
      if (img != null) {
        request.files.add(await http.MultipartFile.fromPath('img', img.path));
      }
      request.fields.addAll(map);
      http.StreamedResponse response = await request.send();
      log(response.statusCode.toString());

      if (response.statusCode == 200 || response.statusCode == 201) {
        isOtherLoading.value = false;
        Get.back();
      } else {
        debugPrint('Error in edit profile');
        error('Error in edit profile');
        isOtherLoading.value = false;
      }
    } catch (Error) {
      isOtherLoading.value = false;
      error(Error.toString());
    }
  }

  updateProviderProfile(Map<String, String> map, XFile? img) async {
    isOtherLoading.value = true;
    error("");
    profileName("");
    try {
      log('${Urls().basicUrl}${Urls().editProviderProfile}');
      var request = http.MultipartRequest('POST', Uri.parse('${Urls().basicUrl}${Urls().editProviderProfile}'));
      request.headers.addAll(
        {
          'Content-Type': 'application/json',
        },
      );
      if (img != null) {
        request.files.add(await http.MultipartFile.fromPath('img', img.path));
      }
      request.fields.addAll(map);
      http.StreamedResponse response = await request.send();
      log(response.statusCode.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        isOtherLoading.value = false;
        Get.back();
      } else {
        debugPrint('Error in getCustomerNotification');
        error('Error in getCustomerNotification');
        isOtherLoading.value = false;
      }
    } catch (Error) {
      isOtherLoading.value = false;
      error(Error.toString());
    }
  }

  RxString imgName = "".obs;

  uploadProfilePic(XFile? img) async {
    loading.value = true;
    error("");
    imgName("");
    try {
      var request = http.MultipartRequest('POST', Uri.parse('${Urls().basicUrl}upload'));
      request.files.add(await http.MultipartFile.fromPath('image', img!.path));

      http.StreamedResponse response = await request.send();
      log("aa====");
      if (response.statusCode == 200) {
        String a = await response.stream.bytesToString();
        final Map<String, dynamic> jsonData = json.decode(a);
        log("b====$jsonData");
        imgName.value = jsonData["fileName"];
        log("imgName====${imgName.value}");
      } else {
        log(response.reasonPhrase ?? "");
      }
    } catch (Error) {
      loading.value = false;
      error(Error.toString());
    }
  }
}
