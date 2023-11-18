import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'Modal/all_jobs_model.dart';
import 'Modal/notification_list_model.dart';
import 'Modal/provider_profile_model.dart';
import 'utils/Urls/urls.dart';

class CompanySideController extends GetxController {
  RxString profileName = ''.obs;
  RxString profilePic = ''.obs;
  RxString desc = ''.obs;
  RxString profileDescriptions = ''.obs;
  RxString profilePhone = ''.obs;
  Map profileData = {};
  RxBool loading = false.obs;
  Map providerProposalData = {};
  RxList getProviderProposalsList = [].obs;
  List request = [];
  RxString submitProposal = ''.obs;
  RxString error = "".obs;

  RxList<JobData> allJobList = <JobData>[].obs;

  getAppJobsAPI(String sessionID, String providerID, String status) async {
    loading.value = true;

    error("");
    try {
      final String url = Urls().basicUrl + Urls().allrequests;
      print(url);
      print({"providerID": providerID, "sessionID": sessionID});
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode({"providerID": providerID, "sessionID": sessionID, "status": status}),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        allJobList.clear();
        AllJobsModel allJobsModel = AllJobsModel.fromJson(jsonData);
        allJobList.addAll(allJobsModel.data);
      } else {
        debugPrint('Error in getAppJobsAPI');
        error('Error in getAppJobsAPI');
      }
    } catch (ex) {
      error(ex.toString());
    } finally {
      loading.value = false;
    }
  }

  submitProposalApi(
      {required String customerID, required String requestID, required String providerID, required String amount, required String sessionID}) async {
    loading.value = true;
    final response = await http.post(
      Uri.parse(Urls().basicUrl + Urls().submitProposal),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "requestID": requestID,
        "customerID": customerID,
        "providerID": providerID,
        "Amount": amount,
        "sessionID": sessionID,
      }),
    );
    loading.value = false;
    if (response.statusCode == 200 || response.statusCode == 201) {
      debugPrint(response.body);
      Map data = json.decode(response.body);
      submitProposal.value = data['status'];
      return json.decode(response.body);
    } else {
      debugPrint('Error in submitRequest');
    }
  }

  RxList<NotificationModel> notificationList = <NotificationModel>[].obs;

  getProviderNotification(String sessionID, String providerID) async {
    loading.value = true;
    error("");
    notificationList.clear();
    try {
      print('${Urls().basicUrl}${Urls().providerNotificationList}$providerID/$sessionID');
      final response = await http.get(
        Uri.parse('${Urls().basicUrl}${Urls().providerNotificationList}$providerID/$sessionID'),
      );
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        NotificationListModel notificationListModel = NotificationListModel.fromJson(jsonData);
        notificationList.addAll(notificationListModel.data);

        debugPrint(response.body);
      } else {
        debugPrint('Error in getCustomerNotification');
        error('Error in getCustomerNotification');
      }

      loading.value = false;
    } catch (Error) {
      error(Error.toString());
    }
  }

  RxInt jobCount = 0.obs, customerCount = 0.obs;

  getProviderProfile(String sessionID, String providerID) async {
    loading.value = true;
    error("");
    profileName("");
    profilePic("");
    desc("");
    jobCount(0);
    customerCount(0);
    try {
      log('${Urls().basicUrl}${Urls().getProviderProfile}');
      log(providerID);
      log(sessionID);
      final response = await http.post(Uri.parse('${Urls().basicUrl}${Urls().getProviderProfile}'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode({"providerID": providerID, "sessionID": sessionID}));
      //   log(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        ProviderUserProfileModel userProfileModel = ProviderUserProfileModel.fromJson(jsonData);
        profileName.value = userProfileModel.data.providerDetails.Name;
        if (userProfileModel.data.providerDetails.img != null) {
          profilePic.value = userProfileModel.data.providerDetails.img!.data;
        }
        desc.value = userProfileModel.data.providerDetails.description;
        jobCount(userProfileModel.data.jobCount);
        customerCount(userProfileModel.data.customerCount);
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

  RxString bufferImg = "".obs;
  RxBool isOtherLoading = false.obs;

  getProfilePic(String name) async {
    isOtherLoading.value = true;
    error("");
    bufferImg("");
    try {
      final response = await http.get(
        Uri.parse('${Urls().basicUrl}images?name=$name'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      // log(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        bufferImg(jsonData["images"][0]["data"]);
        isOtherLoading.value = false;
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
}
