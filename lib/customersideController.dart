import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'Modal/latest_proposal_model.dart';
import 'Modal/my_jobs_model.dart';
import 'Modal/notification_list_model.dart';
import 'Modal/service_model.dart';
import 'utils/Urls/urls.dart';

class CustomerSideController extends GetxController {
  RxBool loading = false.obs;
  RxString error = "".obs;
  RxList<Service> serviceList = <Service>[].obs;
  RxList<Service> serviceList2 = <Service>[].obs;
  RxList<String> categoryList = <String>[].obs;
  RxList subName = [].obs;
  RxInt serviceIndex = 0.obs;
  RxInt serviceLength = 0.obs;

  submitReport(
    String customerID,
    String sessionID,
    List services,
    List availabilityDate,
    String availabilityTimeFrom,
    String availabilityTimeTo,
    List location,
    String other,
  ) async {
    Map map = {
      "customerID": customerID,
      "SessionID": sessionID,
      "services": services,
      "availabilityDate": availabilityDate,
      "availabilityTimeFrom": availabilityTimeFrom,
      "availabilityTimeTo": availabilityTimeTo,
      "location": location,
      "other": other,
    };
    print(map);
    final response = await http.post(
      Uri.parse(Urls().basicUrl + Urls().submitRequest),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "customerID": customerID,
        "SessionID": sessionID,
        "services": services,
        "availabilityDate": availabilityDate,
        "availabilityTimeFrom": availabilityTimeFrom,
        "availabilityTimeTo": availabilityTimeTo,
        "location": location,
        "other": other,
      }),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      Map data = jsonDecode(response.body);
      debugPrint(response.body);
      if (data['status'] == 'ok') {
        return true;
      } else {
        return false;
      }
    } else {
      debugPrint('Error in submitReport');
      return false;
    }
  }

  getServices() async {
    try {
      loading.value = true;
      log(Urls().basicUrl + Urls().allServices);
      final response = await http.get(
        Uri.parse(Urls().basicUrl + Urls().allServices),
      );
      serviceList.clear();
      categoryList.clear();
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> valueMap = json.decode(response.body);
        ServiceListModel serviceListModel = ServiceListModel.fromJson(valueMap);
        serviceList.addAll(serviceListModel.data);
        for (var service in serviceList) {
          if (!categoryList.contains(service.category)) {
            categoryList.add(service.category);
          }
        }
        serviceIndex.value = 0;
        for (var service in serviceList) {
          if (service.category == categoryList[serviceIndex.value]) {
            serviceList2.add(service);
          }
        }
        // serviceLength.value = subcategory[0].length;
      } else {
        debugPrint('Error in getServices');
      }
    } catch (error) {
      log(error.toString());
    } finally {
      loading.value = false;
    }
  }

  RxList<JobDetails> myjobList = <JobDetails>[].obs;
  late MyJobsModel requestModal;

  Future<void> getMyJobData(String customerId, String sessionId, String status) async {
    loading.value = true;
    myjobList.clear();
    error("");
    try {
      String url = '${Urls().basicUrl}${Urls().myJob}';
      log(url);
      // log(customerId);
      log(customerId);
      log(sessionId);

      final response = await http.post(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode({"customerID": customerId, "SessionID": sessionId, "Status": status}));
      log(response.body);
      loading.value = false;

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        requestModal = MyJobsModel.fromJson(jsonData);
        myjobList.addAll(requestModal.data.jobDetails);
        // Add the new data to customerNotification list
        //  customerNotification.add(requestModal);
      } else {
        error("Something went wrong.");
        loading.value = false;
        // Handle error
      }
    } catch (e) {
      print(e);
      error(e.toString());
      loading.value = false;
      // Ha)ndle error
    }
  }

  RxList<NotificationModel> notificationList = <NotificationModel>[].obs;

  getCustomerNotification(String sessionID, String customerID) async {
    loading.value = true;
    error("");
    notificationList.clear();
    try {
      final response = await http.get(
        Uri.parse('${Urls().basicUrl}${Urls().customerNotificationList}$customerID/$sessionID'),
      );
      // print(response.body);
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

  RxList<ProposalData> proposalList = <ProposalData>[].obs;

  Future<void> getLatestProposals(String customerId, String sessionId) async {
    loading.value = true;
    proposalList.clear();
    error("");
    try {
      String url = '${Urls().basicUrl}${Urls().getProposalsForCustomer}';
      log(url);
      final response = await http.post(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            "customerID": customerId,
            "SessionID": sessionId,
          }));
      log(response.body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        LatestProposalListModel proposalListModel = LatestProposalListModel.fromJson(jsonData);
        proposalList.addAll(proposalListModel.data);
        loading.value = false;
        // Add the new data to customerNotification list
        //  customerNotification.add(requestModal);
      } else {
        error("Something went wrong.");
        loading.value = false;
        // Handle error
      }
    } catch (e) {
      print(e);
      error(e.toString());
      loading.value = false;
      // Ha)ndle error
    }
  }

  @override
  void onInit() {
    getServices();
    super.onInit();
  }
}
