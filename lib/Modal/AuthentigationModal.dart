class AuthenticateModal {
  String? status;
  String? type;

  AuthenticateModal({this.status, this.type});

  AuthenticateModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['type'] = type;
    return data;
  }
}
