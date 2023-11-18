class ProviderUserProfileModel {
  ProviderUserProfileModel({
    required this.status,
    required this.data,
  });

  late final String status;
  late final Data data;

  ProviderUserProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = Data.fromJson(json['data']);
  }
}

class Data {
  Data({
    required this.providerDetails,
    required this.jobCount,
    required this.customerCount,
  });

  late final ProviderDetails providerDetails;
  late final int jobCount;
  late final int customerCount;

  Data.fromJson(Map<String, dynamic> json) {
    providerDetails = ProviderDetails.fromJson(json['providerDetails']);
    jobCount = json['jobCount'];
    customerCount = json['customerCount'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['providerDetails'] = providerDetails.toJson();
    data['jobCount'] = jobCount;
    data['customerCount'] = customerCount;
    return data;
  }
}

class ProviderDetails {
  ProviderDetails({
    required this.id,
    required this.requestID,
    required this.customerID,
    required this.providerID,
    required this.Amount,
    required this.latestSessionID,
    required this.Name,
    required this.phone,
    required this.description,
    required this.latestOTP,
    required this.deviceToken,
    this.img,
  });

  late final String id;
  late final String requestID;
  late final String customerID;
  late final String providerID;
  late final dynamic Amount;
  late final String latestSessionID;
  late final String Name;
  late final String phone;
  late final String description;
  late final String latestOTP;
  late final String deviceToken;
  late final Img? img;

  ProviderDetails.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    requestID = json['requestID'];
    customerID = json['customerID'];
    providerID = json['providerID'];
    Amount = json['Amount'];
    latestSessionID = json['latestSessionID'];
    Name = json['Name'];
    phone = json['phone'];
    description = json['description'];
    latestOTP = json['latestOTP'];
    deviceToken = json['deviceToken'];
    img = json['img'] == null ? null : Img.fromJson(json['img']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = id;
    data['requestID'] = requestID;
    data['customerID'] = customerID;
    data['providerID'] = providerID;
    data['Amount'] = Amount;
    data['latestSessionID'] = latestSessionID;
    data['Name'] = Name;
    data['phone'] = phone;
    data['description'] = description;
    data['latestOTP'] = latestOTP;
    data['deviceToken'] = deviceToken;
    data['img'] = img?.toJson();
    return data;
  }
}

class Img {
  Img({
    required this.originalname,
    required this.size,
    required this.mimetype,
    required this.data,
  });

  late final String originalname;
  late final String size;
  late final String mimetype;
  late final String data;

  Img.fromJson(Map<String, dynamic> json) {
    originalname = json['originalname'];
    size = json['size'];
    mimetype = json['mimetype'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['originalname'] = originalname;
    data['size'] = size;
    data['mimetype'] = mimetype;
    data['data'] = data;
    return data;
  }
}
