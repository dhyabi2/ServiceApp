import 'package:cleaning/Modal/my_jobs_model.dart';

class AllJobsModel {
  AllJobsModel({
    required this.status,
    required this.data,
  });

  late final String status;
  late final List<JobData> data;

  AllJobsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = List.from(json['data']).map((e) => JobData.fromJson(e)).toList();
  }
}

class JobData {
  JobData(
      {required this.id,
      required this.services,
      required this.availabilityDateList,
      required this.availabilityFrom,
      required this.availabilityTo,
      required this.requestID,
      required this.other,
      required this.location,
      required this.customerDetails,
      required this.proposalDetails,
      this.proposalID,
      this.jobStatus,
      this.providerID,
      this.proposalStatus,
      this.amount});

  late final String id;
  late final String? proposalID;
  late final String? providerID;
  late final String? jobStatus;
  late final String? proposalStatus;
  late final dynamic amount;
  late final List<Services> services;
  late final List<String> availabilityDateList;
  late final String availabilityFrom;
  late final String availabilityTo;
  late final String requestID;
  late final String other;
  late final List<double> location;
  late final List<CustomerDetails> customerDetails;
  late final List<ProposalDetails> proposalDetails;

  JobData.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    proposalID = json['proposalID'];
    //requestID = json['requestID'];
    providerID = json['providerID'];
    jobStatus = json['job_status'];
    amount = json['Amount'];
    proposalStatus = json['proposal_status'];
    services = List.from(json['services']).map((e) => Services.fromJson(e)).toList();
    availabilityDateList = List.castFrom<dynamic, String>(json['availabilityDateList']);
    availabilityFrom = json['availabilityFrom'];
    availabilityTo = json['availabilityTo'];
    requestID = json['requestID'];
    other = json['other'];
    location = List.castFrom<dynamic, double>(json['location']);
    customerDetails = List.from(json['customerDetails']).map((e) => CustomerDetails.fromJson(e)).toList();
    proposalDetails = List.from(json['proposalDetails']).map((e) => ProposalDetails.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = id;
    data['proposalID'] = proposalID;

    data['providerID'] = providerID;
    data['job_status'] = jobStatus;
    data['Amount'] = amount;
    data['proposal_status'] = proposalStatus;
    data['services'] = services.map((e) => e.toJson()).toList();
    data['availabilityDateList'] = availabilityDateList;
    data['availabilityFrom'] = availabilityFrom;
    data['availabilityTo'] = availabilityTo;
    data['requestID'] = requestID;
    data['other'] = other;
    data['location'] = location;
    data['customerDetails'] = customerDetails.map((e) => e.toJson()).toList();
    data['proposalDetails'] = proposalDetails.map((e) => e.toJson()).toList();
    return data;
  }
}

class ProposalDetails {
  ProposalDetails({
    required this.id,
    required this.proposalID,
    required this.requestID,
    required this.customerID,
    required this.providerID,
    required this.Amount,
    required this.status,
    required this.v,
  });

  late final String id;
  late final String proposalID;
  late final String requestID;
  late final String customerID;
  late final String providerID;
  late final dynamic Amount;
  late final String status;
  late final int v;

  ProposalDetails.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    proposalID = json['proposalID'];
    requestID = json['requestID'];
    customerID = json['customerID'];
    providerID = json['providerID'];
    Amount = json['Amount'];
    status = json['status'];
    v = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = id;
    data['proposalID'] = proposalID;
    data['requestID'] = requestID;
    data['customerID'] = customerID;
    data['providerID'] = providerID;
    data['Amount'] = Amount;
    data['status'] = status;
    data['__v'] = v;
    return data;
  }
}

class CustomerDetails {
  CustomerDetails({
    required this.id,
    required this.customerID,
    required this.FirstName,
    required this.FamilyName,
    // required this.phone,
    // required this.latestSessionID,
    // required this.latestOTP,
    // required this.v,
    // required this.CurrentWork,
    // required this.Education,
    // required this.status,
  });

  late final String id;
  late final String customerID;
  late final String FirstName;
  late final String FamilyName;
  late final String phone;

  // late final String latestSessionID;
  // late final String latestOTP;
  // late final int v;
  // late final String CurrentWork;
  // late final String Education;
  // late final String status;

  CustomerDetails.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    customerID = json['customerID'];
    FirstName = json['FirstName'];
    FamilyName = json['FamilyName'];
    phone = json['phone'];
    // latestSessionID = json['latestSessionID'];
    // latestOTP = json['latestOTP'];
    // v = json['__v'];
    // CurrentWork = json['CurrentWork'];
    // Education = json['Education'];
    // status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = id;
    data['customerID'] = customerID;
    data['FirstName'] = FirstName;
    data['FamilyName'] = FamilyName;
    data['phone'] = phone;
    // _data['latestSessionID'] = latestSessionID;
    // _data['latestOTP'] = latestOTP;
    // _data['__v'] = v;
    // _data['CurrentWork'] = CurrentWork;
    // _data['Education'] = Education;
    // _data['status'] = status;
    return data;
  }
}
