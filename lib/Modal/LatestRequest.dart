class LatestRequestsModal {
  String? sId;
  String? customerID;
  List<String>? services;
  List<String>? availabilityDateList;
  String? availabilityFrom;
  String? availabilityTo;
  String? requestID;
  String? other;
  int? iV;

  LatestRequestsModal(
      {this.sId,
      this.customerID,
      this.services,
      this.availabilityDateList,
      this.availabilityFrom,
      this.availabilityTo,
      this.requestID,
      this.other,
      this.iV});

  LatestRequestsModal.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    customerID = json['customerID'];
    services = json['services'].cast<String>();
    availabilityDateList = json['availabilityDateList'].cast<String>();
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
