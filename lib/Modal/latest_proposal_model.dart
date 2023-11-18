import 'package:cleaning/Modal/my_jobs_model.dart';

class LatestProposalListModel {
  LatestProposalListModel({
    required this.status,
    required this.data,
  });

  late final String status;
  late final List<ProposalData> data;

  LatestProposalListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = List.from(json['data']).map((e) => ProposalData.fromJson(e)).toList();
  }
}

class ProposalData {
  ProposalData({
    // required this._id,
    required this.proposalID,
    required this.requestID,
    required this.customerID,
    required this.providerID,
    required this.Amount,
    required this.proposalStatus,
    required this.providerDetails,
    required this.requestDetails,
  });

  // late final String _id;
  late final String proposalID;
  late final String requestID;
  late final String customerID;
  late final String providerID;
  late final dynamic Amount;
  late final String proposalStatus;
  late final ProviderDetails providerDetails;
  late final RequestDetails requestDetails;

  ProposalData.fromJson(Map<String, dynamic> json) {
    // _id = json['_id'];
    proposalID = json['proposalID'];
    requestID = json['requestID'];
    customerID = json['customerID'];
    providerID = json['providerID'];
    Amount = json['Amount'];
    proposalStatus = json['proposal_status'];
    providerDetails = ProviderDetails.fromJson(json['providerDetails']);
    requestDetails = RequestDetails.fromJson(json['requestDetails']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    // _data['_id'] = _id;
    data['proposalID'] = proposalID;
    data['requestID'] = requestID;
    data['customerID'] = customerID;
    data['providerID'] = providerID;
    data['Amount'] = Amount;
    data['proposal_status'] = proposalStatus;
    data['providerDetails'] = providerDetails.toJson();
    data['requestDetails'] = requestDetails.toJson();
    return data;
  }
}

class RequestDetails {
  RequestDetails({
    required this.customerID,
    required this.availabilityDateList,
    required this.availabilityFrom,
    required this.availabilityTo,
    required this.requestID,
    required this.other,
    required this.location,
    required this.jobStatus,
    required this.createdAt,
    required this.services,
  });

  late final String customerID;
  late final List<String> availabilityDateList;
  late final String availabilityFrom;
  late final String availabilityTo;
  late final String requestID;
  late final String other;
  late final List<double> location;
  late final String jobStatus;
  late final String createdAt;
  late final List<Services> services;

  RequestDetails.fromJson(Map<String, dynamic> json) {
    customerID = json['customerID'];
    availabilityDateList = List.castFrom<dynamic, String>(json['availabilityDateList']);
    availabilityFrom = json['availabilityFrom'];
    availabilityTo = json['availabilityTo'];
    requestID = json['requestID'];
    other = json['other'];
    location = List.castFrom<dynamic, double>(json['location']);
    jobStatus = json['job_status'];
    createdAt = json['created_at'];
    services = List.from(json['services']).map((e) => Services.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['customerID'] = customerID;
    data['availabilityDateList'] = availabilityDateList;
    data['availabilityFrom'] = availabilityFrom;
    data['availabilityTo'] = availabilityTo;
    data['requestID'] = requestID;
    data['other'] = other;
    data['location'] = location;
    data['job_status'] = jobStatus;
    data['created_at'] = createdAt;
    data['services'] = services.map((e) => e.toJson()).toList();
    return data;
  }
}
