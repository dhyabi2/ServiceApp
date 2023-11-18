import 'dart:convert';

import 'package:cleaning/Modal/service_model.dart';
import 'package:cleaning/utils/Urls/urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SendProposalController extends GetxController {
  RxBool loading = false.obs, isOtherLoading = false.obs;
  RxString error = "".obs;
  RxList<Service> serviceList = <Service>[].obs;

  getServices() async {
    loading.value = true;
    serviceList.clear();
    final response = await http.get(
      Uri.parse(Urls().basicUrl + Urls().allServices),
    );
    //category.clear();
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      List services = jsonDecode(response.body);
      for (int i = 0; i < services.length; i++) {
        //    serviceList.add(services[i]['category']);
        //  print(services[i]['list']);
        for (int j = 0; j < services[i]['list'].length; j++) {
          print(services[i]['list'][j]);
          serviceList.add(Service.fromJson(services[i]['list'][j]));
        }
        //  serviceList.addAll(Service.fromJson(services[i]['list']));
      }
      // serviceLength.value = subcategory[0].length;
    } else {
      debugPrint('Error in getServices');
    }
    loading.value = false;
  }

  RxString submitProposal = ''.obs;

  submitProposalApi(
      {required String customerID, required String requestID, required String providerID, required String amount, required String sessionID}) async {
    isOtherLoading.value = true;
    error("");
    try {
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
      isOtherLoading.value = false;
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint(response.body);
        Map data = json.decode(response.body);
        submitProposal.value = data['status'];
        //  return json.decode(response.body);
      } else {
        debugPrint('Error in submitRequest');
        error('Error in submitRequest');
      }
    } catch (ex) {
      error(ex.toString());
    } finally {
      isOtherLoading.value = false;
    }
  }
}
