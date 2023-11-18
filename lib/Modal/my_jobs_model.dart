import 'package:cleaning/Modal/provider_profile_model.dart';

class MyJobsModel {
  MyJobsModel({
    required this.status,
    required this.data,
  });

  late final String status;
  late final MyJobInfo data;

  MyJobsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = MyJobInfo.fromJson(json['data']);
  }
}

class MyJobInfo {
  MyJobInfo({
    required this.customerdetails,
    required this.jobDetails,
  });

  late final Customerdetails customerdetails;
  late final List<JobDetails> jobDetails;

  MyJobInfo.fromJson(Map<String, dynamic> json) {
    customerdetails = Customerdetails.fromJson(json['customerdetails']);
    jobDetails = List.from(json['jobDetails']).map((e) => JobDetails.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['customerdetails'] = customerdetails.toJson();
    data['jobDetails'] = jobDetails.map((e) => e.toJson()).toList();
    return data;
  }
}

class Customerdetails {
  Customerdetails({
    required this.FirstName,
    required this.FamilyName,
  });

  late final String FirstName;
  late final String FamilyName;

  Customerdetails.fromJson(Map<String, dynamic> json) {
    FirstName = json['FirstName'];
    FamilyName = json['FamilyName'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['FirstName'] = FirstName;
    data['FamilyName'] = FamilyName;
    return data;
  }
}

class JobDetails {
  JobDetails({
    required this.id,
    required this.customerID,
    required this.services,
    required this.availabilityDateList,
    required this.availabilityFrom,
    required this.availabilityTo,
    required this.requestID,
    required this.createdAt,
    required this.other,
    required this.status,
    required this.location,
    required this.proposal,
  });

  late final String id;
  late final String customerID;
  late final List<Services> services;
  late final List<String> availabilityDateList;
  late final String availabilityFrom;
  late final String availabilityTo;
  late final String requestID;
  late final String createdAt;
  late final String other;
  late final String status;
  late final List<double> location;
  late final List<Proposal> proposal;

  JobDetails.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    customerID = json['customerID'];
    services = List.from(json['services']).map((e) => Services.fromJson(e)).toList();
    availabilityDateList = List.castFrom<dynamic, String>(json['availabilityDateList']);
    availabilityFrom = json['availabilityFrom'];
    availabilityTo = json['availabilityTo'];
    requestID = json['requestID'];
    other = json['other'];
    createdAt = json['created_at'];
    status = json['status'];
    location = List.castFrom<dynamic, double>(json['location']);
    proposal = List.from(json['proposal']).map((e) => Proposal.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = id;
    data['customerID'] = customerID;
    data['services'] = services.map((e) => e.toJson()).toList();
    data['availabilityDateList'] = availabilityDateList;
    data['availabilityFrom'] = availabilityFrom;
    data['availabilityTo'] = availabilityTo;
    data['requestID'] = requestID;
    data['other'] = other;
    data['created_at'] = createdAt;
    data['status'] = status;
    data['location'] = location;
    data['proposal'] = proposal.map((e) => e.toJson()).toList();
    return data;
  }
}

class Services {
  Services({
    required this.name,
    required this.description,
    required this.img,
    required this.quantity,
  });

  late final String name;
  late final String description;
  late final String img;
  late final String quantity;

  Services.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    img = json['img'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['img'] = img;
    data['quantity'] = quantity;
    return data;
  }
}

class Proposal {
  Proposal(
      {required this.id,
      required this.proposalID,
      required this.requestID,
      required this.customerID,
      required this.providerID,
      required this.Amount,
      required this.status,
      required this.providerDetails});

  late final String id;
  late final String proposalID;
  late final String requestID;
  late final String customerID;
  late final String providerID;
  late final dynamic Amount;
  late final String status;
  late final ProviderDetails providerDetails;

  Proposal.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    proposalID = json['proposalID'];
    requestID = json['requestID'];
    customerID = json['customerID'];
    providerID = json['providerID'];
    Amount = json['Amount'];
    status = json['status'];
    providerDetails = ProviderDetails.fromJson(json['providerDetails']);
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
    data['providerDetails'] = providerDetails.toJson();
    return data;
  }
}

class ProviderDetails {
  ProviderDetails({
    required this.providerID,
    required this.Name,
    required this.phone,
    required this.description,
    this.img,
  });

  late final String providerID;

  late final String Name;
  late final String phone;
  late final String description;
  late final Img? img;

  ProviderDetails.fromJson(Map<String, dynamic> json) {
    providerID = json['providerID'];
    Name = json['Name'];
    phone = json['phone'];
    description = json['description'];
    img = json['img'] == null ? null : Img.fromJson(json['img']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['providerID'] = providerID;
    data['Name'] = Name;
    data['phone'] = phone;
    data['description'] = description;
    data['img'] = img?.toJson();
    return data;
  }
}
