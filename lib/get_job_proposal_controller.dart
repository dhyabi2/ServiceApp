import 'dart:convert';
import 'dart:developer';

import 'package:cleaning/utils/Urls/urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'Modal/proposal_list_model.dart';

class GetJobProposalController extends GetxController {
  RxBool loading = false.obs, isOtherLoading = false.obs;
  RxString error = "".obs;
  RxList<ProposalModel> proposalList = <ProposalModel>[].obs;

  getMyJobProposals({required String sessionID, required String customerID, required String requestID}) async {
    loading.value = true;
    proposalList.clear();
    error("");
    try {
      final String url = "${Urls().basicUrl}${Urls().getJobProposals}";
      print(url);
      print({"customerID": customerID, "SessionID": sessionID, "requestID": requestID});
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode({"customerID": customerID, "SessionID": sessionID, "requestID": requestID}),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      log(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        ProposalListModel proposalListModel = ProposalListModel.fromJson(jsonData);
        proposalList.addAll(proposalListModel.data);
        // proposalList.addAll(proposalListModel.data);
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

  respondToProposal(
      {required String sessionID,
      required String customerID,
      required String requestID,
      required bool requestStatus,
      required String proposalID}) async {
    isOtherLoading.value = true;
    proposalList.clear();
    error("");
    try {
      final String url = "${Urls().basicUrl}${Urls().acceptProposals}";
      print(url);
      print({"customerID": customerID, "SessionID": sessionID, "requestID": requestID});
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode(
            {"proposalID": proposalID, "requestStatus": requestStatus, "customerID": customerID, "SessionID": sessionID, "requestID": requestID}),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        getMyJobProposals(requestID: requestID, customerID: customerID, sessionID: sessionID);
      } else {
        debugPrint('Error in getAppJobsAPI');
        error('Error in getAppJobsAPI');
      }
    } catch (ex) {
      error(ex.toString());
    } finally {
      isOtherLoading.value = false;
    }
  }
}
