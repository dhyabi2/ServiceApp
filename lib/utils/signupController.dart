import 'dart:convert';
import 'dart:developer';

import 'package:cleaning/utils/Urls/urls.dart';
import 'package:cleaning/utils/common_widgets.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthenticationController extends GetxController {
  // 'POST',
  // Uri.parse(Urls().basicUrl + Urls().authenticate),
  RxBool loading = false.obs;
  Map authenticateData = {};
  RxString authenticateType = ''.obs;
  RxString authenticateStatus = ''.obs;

  Map verifyOtpData = {};
  RxString verifyOtpStatus = ''.obs;
  RxString verifyOtpSessionID = ''.obs;
  RxString verifyOtpCustomerID = ''.obs;
  RxString verifyOtpProviderID = ''.obs;
  RxString verifyOtpType = ''.obs;

  signUpApiCall(String firstName, String familyName, String phoneNumber,) async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      // param["deviceToken"] = token.toString();

      final response = await http.post(
        Uri.parse(Urls().basicUrl + Urls().authenticate),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'FirstName': firstName, 'FamilyName': familyName, 'PhoneNumber': phoneNumber, "deviceToken": token}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        authenticateData = jsonDecode(response.body);

        if (authenticateData["status"] != "failed") {
          authenticateType.value = authenticateData['type'];
          authenticateStatus.value = authenticateData['status'];
        }
      } else {
        debugPrint('Error in signUpApiCall');
      }
    } catch (ex) {
      debugPrint(ex.toString());
    }
  }

  signUpGoogle(String firstName, String familyName,String? googleId) async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      // param["deviceToken"] = token.toString();

      final response = await http.post(
        Uri.parse(Urls().basicUrl + Urls().authenticate),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'FirstName': firstName, 'FamilyName': familyName, 'googleID': googleId, "deviceToken": token}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        authenticateData = jsonDecode(response.body);

        verifyOtpData = jsonDecode(response.body);
        verifyOtpStatus.value = verifyOtpData['status'];
        if (verifyOtpStatus.value != "failed") {
          verifyOtpType.value = verifyOtpData['type'];
          if (verifyOtpType.value == 'customer') {
            verifyOtpCustomerID.value = verifyOtpData['customerID'];
          } else if (verifyOtpType.value == 'provider') {
            verifyOtpProviderID.value = verifyOtpData['providerID'];
          }
          verifyOtpSessionID.value = verifyOtpData['sessionID'];
        }
        } else {
        debugPrint('Error in signUpApiCall');
      }
    } catch (ex) {
      debugPrint(ex.toString());
    }
  }

  verifyApiCall(String phoneNumber, String otp) async {
    print(phoneNumber);
    final response = await http.post(
      Uri.parse(Urls().basicUrl + Urls().verifyOTP),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({"PhoneNumber": phoneNumber, "OTP": otp}),
    );
    log(response.body.toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      verifyOtpData = jsonDecode(response.body);
      verifyOtpStatus.value = verifyOtpData['status'];
      if (verifyOtpStatus.value != "failed") {
        verifyOtpType.value = verifyOtpData['type'];
        if (verifyOtpType.value == 'customer') {
          verifyOtpCustomerID.value = verifyOtpData['customerID'];
        } else if (verifyOtpType.value == 'provider') {
          verifyOtpProviderID.value = verifyOtpData['providerID'];
        }
        verifyOtpSessionID.value = verifyOtpData['sessionID'];
      } else {
        commonToast("wrong otp");
      }
    } else {
      debugPrint('Error in signUpApiCall');
    }
  }

// Future<Album> createAlbum(String title) async {
//   final response = await http.post(
//     Uri.parse('https://jsonplaceholder.typicode.com/albums'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(<String, String>{
//       'title': title,
//     }),
//   );
//
//   if (response.statusCode == 201) {
//     // If the server did return a 201 CREATED response,
//     // then parse the JSON.
//     return Album.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 201 CREATED response,
//     // then throw an exception.
//     throw Exception('Failed to create album.');
//   }
// }

// Future<RegisterModel?> registerApiCall(
//     String firebaseToken,
//     String fullName,
//     String mobile,
//     String email,
//     String deviceType,
//     String subscription,
//     String memberId,
//     String pwd,
//     ProgressLoader pl) async {
//   var request = http.MultipartRequest(
//     'POST',
//     Uri.parse(Urls().basicUrl + Urls().registration),
//   );
//   request.fields.addAll({
//     'FirebaseToken': firebaseToken,
//     'FullName': fullName,
//     'Mobile': mobile,
//     'Email': email,
//     'DeviceType': deviceType,
//     'Subscription': subscription,
//     'MemberId': memberId,
//     'Password': pwd
//   });
//
//   var response = await http.Response.fromStream(await request.send());
//
//   if (response.statusCode == 200) {
//     return RegisterModel.fromJson(jsonDecode(response.body));
//   } else {
//     await pl.hide();
//
//   }
// }
}
