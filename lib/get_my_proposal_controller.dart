import 'dart:convert';

import 'package:cleaning/utils/Urls/urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'Modal/all_jobs_model.dart';

class GetMyProposalController extends GetxController {
  RxBool loading = false.obs;
  RxString error = "".obs;

  // RxList<JobData> allJobList = <JobData>[].obs;
  RxList<JobData> allJobList = <JobData>[].obs;

  getMyProposals(String sessionID, String providerID) async {
    loading.value = true;
    allJobList.clear();
    error("");
    try {
      final String url = "${Urls().basicUrl}${Urls().getProviderProposals}$providerID/$sessionID";
      print(url);
      final response = await http.get(
        Uri.parse(url),
        //  body: jsonEncode({"providerID": providerID, "sessionID": sessionID}),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
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
}
