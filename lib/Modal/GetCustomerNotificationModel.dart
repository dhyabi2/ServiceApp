class getRequestsByCustomerModal {
  String? status;
  List<Data>? data;

  getRequestsByCustomerModal({this.status, this.data});

  getRequestsByCustomerModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? customerID;
  List<String>? services;
  List<String>? availabilityDateList;
  String? availabilityFrom;
  String? availabilityTo;
  String? requestID;
  String? other;
  int? iV;

  Data({
    this.sId,
    this.customerID,
    this.services,
    this.availabilityDateList,
    this.availabilityFrom,
    this.availabilityTo,
    this.requestID,
    this.other,
    this.iV,
  });

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    customerID = json['customerID'];
    services = List<String>.from(json['services']);
    availabilityDateList = List<String>.from(json['availabilityDateList']);
    availabilityFrom = json['availabilityFrom'];
    availabilityTo = json['availabilityTo'];
    requestID = json['requestID'];
    other = json['other'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['customerID'] = customerID;
    data['services'] = services;
    data['availabilityDateList'] = availabilityDateList;
    data['availabilityFrom'] = availabilityFrom;
    data['availabilityTo'] = availabilityTo;
    data['requestID'] = requestID;
    data['other'] = other;
    data['__v'] = iV;
    return data;
  }
}
