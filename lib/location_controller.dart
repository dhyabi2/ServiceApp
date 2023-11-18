import 'dart:async';
import 'dart:convert';

import 'package:cleaning/utils/common_widgets.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

//
// import 'package:blessapp/application_constant/app_constant.dart';
// import 'package:blessapp/application_constant/network_call.dart';
// import 'package:blessapp/common/common_methods.dart';
// import 'package:blessapp/common/common_widgets.dart';
// import 'package:/location_list_model.dart' as location_list_model;
// import 'package:blessapp/model/location_list_model.dart';
// import 'package:blessapp/model/predictions_model.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

import 'Modal/predicition_model.dart';

//
// import '../../common/my_mixins.dart';
// import '../../screenUI/profile_management/saved_address_screen.dart';

class LocationController extends GetxController {
  RxBool isLoading = false.obs, isOtherLoading = false.obs, searching = false.obs;
  RxString error = "".obs, searchError = "".obs;
  RxDouble latitude = 0.0.obs, longitude = 0.0.obs;

  RxString building = "".obs, area = "".obs, state = "".obs, city = "".obs;

  Completer<GoogleMapController> mapController = Completer<GoogleMapController>();

  late CameraPosition kGooglePlex;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  locationInit() async {
    isLoading(true);
    LocationData l = await determinePosition();
    latitude.value = l.latitude ?? 33.33;
    longitude.value = l.longitude ?? 22.23;
    kGooglePlex = CameraPosition(
      target: LatLng(latitude.value, longitude.value),
      zoom: 14.4746,
    );
    getPlaceMarkDetails();
    addMarker();

    isLoading(false);
  }

  getPlaceMarkDetails() async {
    List<geocoding.Placemark> placemarks = await geocoding.placemarkFromCoordinates(latitude.value, longitude.value);
    building("${placemarks[0].name},${placemarks[0].street}");
    area(placemarks[0].subLocality);
    state(placemarks[0].administrativeArea);
    city(placemarks[0].locality);
  }

  RxList<Predictions> predictionList = <Predictions>[].obs;
  String apiKey = "AIzaSyDmj4a04eFbZlENStjjxlaUI830K5od7mo";

  searchLocation2(String txt) async {
    searching(true);
    searchError("");
    predictionList.clear();
    try {
      String url = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$txt&types=geocode&key=${apiKey}";

      final response = await http.get(Uri.parse(url));
      Map<String, dynamic> valueMap = json.decode(response.body);
      if (valueMap["status"] == "OK") {
        PredictionListModel predictionListModel = PredictionListModel.fromJson(valueMap);
        predictionList.addAll(predictionListModel.predictions);
      }
    } catch (error) {
      searchError(error.toString());
    } finally {
      searching(false);
    }
  }

  fetchLocationLocation2(String placeId) async {
    searching(true);
    searchError("");
    predictionList.clear();
    try {
      String url = "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=${apiKey}";
      final response = await http.get(Uri.parse(url));
      Map<String, dynamic> valueMap = json.decode(response.body);
      if (valueMap["status"] == "OK") {
        SelectedLocationModel selectedLocationModel = SelectedLocationModel.fromJson(valueMap);
        latitude.value = selectedLocationModel.result.geometry.location.lat;
        longitude.value = selectedLocationModel.result.geometry.location.lng;
        predictionList.clear();
        getPlaceMarkDetails();
        addMarker();
      }
    } catch (error) {
      searchError(error.toString());
    } finally {
      searching(false);
    }
  }

  addMarker() async {
    markers.clear();
    Marker marker = Marker(
        markerId: const MarkerId('event_loc'),
        draggable: true,
        visible: true,
        position: LatLng(latitude.value, longitude.value),
        onDragEnd: ((newPosition) async {
          latitude.value = newPosition.latitude;
          longitude.value = newPosition.longitude;

          kGooglePlex = CameraPosition(
            target: LatLng(latitude.value, longitude.value),
            zoom: 14.4746,
          );
          getPlaceMarkDetails();
          // await Future.delayed(const Duration(seconds: 1));
          final c = await mapController.future;

          c.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target: LatLng(latitude.value, longitude.value),
            zoom: 14.4746,
          )));
        }));
    markers[const MarkerId('event_loc')] = marker;
    // await Future.delayed(Duration(seconds: 1));
    final c = await mapController.future;


    c.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(latitude.value, longitude.value),
        zoom: 14.4746,
      ),
    ));
  }

  onMapCreated(GoogleMapController c) {
    if (!mapController.isCompleted) {
      mapController.complete(c);
    }
    // mapController.complete(c);
  }


  @override
  void dispose() {
    // mapController.future.d
    super.dispose();
  }
// RxList<location_list_model.LocationList> locationList = <location_list_model.LocationList>[].obs;
}
