class NotificationListModel {
  NotificationListModel({
    required this.status,
    required this.data,
  });

  late final String status;
  late final List<NotificationModel> data;

  NotificationListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = List.from(json['data']).map((e) => NotificationModel.fromJson(e)).toList();
  }
}

class NotificationModel {
  NotificationModel({
    required this.notificationId,
    this.customerID,
    this.providerID,
    required this.message,
    required this.timestamp,
  });

  late final String notificationId;
  late final String? customerID;
  late final String? providerID;
  late final String message;
  late final String timestamp;

  NotificationModel.fromJson(Map<String, dynamic> json) {
    notificationId = json['_id'];
    customerID = json['customerID'];
    providerID = json['providerID'];
    message = json['message'];
    timestamp = json['timestamp'];
    //  _V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = notificationId;
    data['customerID'] = customerID;
    data['providerID'] = providerID;
    data['message'] = message;
    data['timestamp'] = timestamp;
    // _data['__v'] = _V;
    return data;
  }
}
