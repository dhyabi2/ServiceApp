import 'package:cleaning/Modal/my_jobs_model.dart';

class ProposalListModel {
  ProposalListModel({
    required this.status,
    required this.data,
  });

  late final String status;
  late final List<ProposalModel> data;

  ProposalListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = List.from(json['data']).map((e) => ProposalModel.fromJson(e)).toList();
  }
}

class ProposalModel {
  ProposalModel({
    required this.proposalID,
    required this.requestID,
    required this.customerID,
    required this.providerID,
    required this.Amount,
    required this.status,
    required this.providerDetails,
  });

  late final String proposalID;
  late final String requestID;
  late final String customerID;
  late final String providerID;
  late final dynamic Amount;
  late final String status;

  late final List<ProviderDetails> providerDetails;

  ProposalModel.fromJson(Map<String, dynamic> json) {
    // _id = json['_id'];
    proposalID = json['proposalID'];
    requestID = json['requestID'];
    customerID = json['customerID'];
    providerID = json['providerID'];
    Amount = json['Amount'];
    status = json['status'];
    // _V = json['__v'];
    providerDetails = List.from(json['providerDetails']).map((e) => ProviderDetails.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    // _data['_id'] = _id;
    data['proposalID'] = proposalID;
    data['requestID'] = requestID;
    data['customerID'] = customerID;
    data['providerID'] = providerID;
    data['Amount'] = Amount;
    data['status'] = status;
    //  _data['__v'] = _V;
    data['providerDetails'] = providerDetails.map((e) => e.toJson()).toList();
    return data;
  }
}
//
// class ProviderDetails {
//   ProviderDetails({
//     // required this._id,
//     required this.requestID,
//     required this.customerID,
//     required this.providerID,
//     required this.Amount,
//     required this.latestSessionID,
//     required this.Name,
//     required this.phone,
//     required this.description,
//     required this.latestOTP,
//   });
//
//   // late final String _id;
//   late final String requestID;
//   late final String customerID;
//   late final String providerID;
//   late final String Amount;
//   late final String latestSessionID;
//   late final String Name;
//   late final String phone;
//   late final String description;
//   late final String latestOTP;
//
//   ProviderDetails.fromJson(Map<String, dynamic> json) {
//     //  _id = json['_id'];
//     requestID = json['requestID'];
//     customerID = json['customerID'];
//     providerID = json['providerID'];
//     Amount = json['Amount'];
//     latestSessionID = json['latestSessionID'];
//     Name = json['Name'];
//     phone = json['phone'];
//     description = json['description'];
//     latestOTP = json['latestOTP'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     // _data['_id'] = _id;
//     data['requestID'] = requestID;
//     data['customerID'] = customerID;
//     data['providerID'] = providerID;
//     data['Amount'] = Amount;
//     data['latestSessionID'] = latestSessionID;
//     data['Name'] = Name;
//     data['phone'] = phone;
//     data['description'] = description;
//     data['latestOTP'] = latestOTP;
//     return data;
//   }
// }
