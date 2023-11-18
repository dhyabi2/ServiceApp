class ServiceListModel {
  ServiceListModel({
    required this.data,
  });

  late final List<Service> data;

  ServiceListModel.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data']).map((e) => Service.fromJson(e)).toList();
  }
}

class Service {
  Service({
    required this.serviceId,
    required this.category,
    required this.name,
    required this.description,
    required this.img,
  });

  late final String serviceId;
  late final String category;
  late final String name;
  late final String description;
  late final String img;
  bool isSelected = false;

  Service.fromJson(Map<String, dynamic> json) {
    serviceId = json['_id'];
    category = json['category'];
    name = json['name'];
    description = json['description'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = serviceId;
    data['category'] = category;
    data['name'] = name;
    data['description'] = description;
    data['img'] = img;
    return data;
  }
}
