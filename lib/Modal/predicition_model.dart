

class PredictionListModel {
  PredictionListModel({
    required this.predictions,
    required this.status,
  });
  late final List<Predictions> predictions;
  late final String status;

  PredictionListModel.fromJson(Map<String, dynamic> json){
    predictions = List.from(json['predictions']).map((e)=>Predictions.fromJson(e)).toList();
    status = json['status'];
  }


}
class Predictions {
  late final String description;
  late final String placeId;

  Predictions({required this.placeId, required this.description});

  Predictions.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    placeId = json['place_id'];
  }
}
class SelectedLocationModel {
  SelectedLocationModel({

    required this.result,
    required this.status,
  });

  late final Result result;
  late final String status;

  SelectedLocationModel.fromJson(Map<String, dynamic> json){

    result = Result.fromJson(json['result']);
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    data['result'] = result.toJson();
    data['status'] = status;
    return data;
  }
}

class Result {
  Result({

    required this.geometry,

  });

  late final Geometry geometry;


  Result.fromJson(Map<String, dynamic> json){

    geometry = Geometry.fromJson(json['geometry']);

  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    data['geometry'] = geometry.toJson();

    return data;
  }
}


class Geometry {
  Geometry({
    required this.location,
  });
  late final GeoMetryLoc location;


  Geometry.fromJson(Map<String, dynamic> json){
    location = GeoMetryLoc.fromJson(json['location']);

  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['location'] = location.toJson();

    return data;
  }
}

class GeoMetryLoc {
  GeoMetryLoc({
    required this.lat,
    required this.lng,
  });
  late final double lat;
  late final double lng;

  GeoMetryLoc.fromJson(Map<String, dynamic> json){
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}
