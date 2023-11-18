import 'package:cleaning/Modal/provider_profile_model.dart';

class UserProfileModel {
  UserProfileModel({
    required this.status,
    required this.data,
  });

  late final String status;
  late final Userdata data;

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = Userdata.fromJson(json['data']);
  }
}

class Userdata {
  Userdata({
    required this.id,
    required this.customerID,
    required this.FirstName,
    required this.FamilyName,
    required this.phone,
    this.jobCount,
    this.customerCount,
    this.img,
    this.CurrentWork,
    // required this.latestSessionID,
    // required this.latestOTP,

    // required this.Education,
    // required this.status,
    // required this.deviceToken,
  });

  late final String id;
  late final String customerID;
  late final String FirstName;
  late final String FamilyName;
  late final String phone;
  late final int? jobCount;
  late final int? customerCount;

  // late final String latestSessionID;
  // late final String latestOTP;
  late final String? CurrentWork;

  // late final String Education;
  // late final String status;
  // late final String deviceToken;
  late final Img? img;

  Userdata.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    customerID = json['customerID'];
    FirstName = json['FirstName'];
    FamilyName = json['FamilyName'];
    phone = json['phone'];
    jobCount = json['jobCount'];
    customerCount = json['customerCount'];
    // latestSessionID = json['latestSessionID'];
    // latestOTP = json['latestOTP'];
//    _V = json['__v'];
    CurrentWork = json['CurrentWork'];
    img = json['img'] == null ? null : Img.fromJson(json['img']);
//     Education = json['Education'];
//     status = json['status'];
//     deviceToken = json['deviceToken'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = id;
    data['customerID'] = customerID;
    data['FirstName'] = FirstName;
    data['FamilyName'] = FamilyName;
    data['phone'] = phone;
    data['jobCount'] = jobCount;
    data['customerCount'] = customerCount;
    //  _data['latestSessionID'] = latestSessionID;
    //  _data['latestOTP'] = latestOTP;
    // // _data['__v'] = _V;
    data['CurrentWork'] = CurrentWork;
    data['img'] = img?.toJson();
    //  _data['Education'] = Education;
    //  _data['status'] = status;
    //  _data['deviceToken'] = deviceToken;
    return data;
  }
}
