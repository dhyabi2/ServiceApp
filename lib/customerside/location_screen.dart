import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cleaning/customewidget.dart';
import 'package:cleaning/utils/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../location_controller.dart';
import '../utils/common_widgets.dart';
import '../welcome_screens/second_welcome_screen.dart';
import 'customer_profile_page.dart';

class ShowMapSheet extends StatefulWidget {
  final Function(double, double) latLng;

  const ShowMapSheet({required this.latLng, Key? key}) : super(key: key);

  @override
  State<ShowMapSheet> createState() => _ShowMapSheetState();
}

class _ShowMapSheetState extends State<ShowMapSheet> {
  final TextEditingController txtSearch = TextEditingController();
  LocationController locationController = Get.put(LocationController());

  @override
  void initState() {
    locationController.locationInit();
    super.initState();
  }

  // Future<Uint8List> getBytesFromAsset(String path, int width) async {
  //   ByteData data = await rootBundle.load(path);
  //   ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
  //   ui.FrameInfo fi = await codec.getNextFrame();
  //   return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  // }
  //
  // myInit() async {
  //   try {
  //     Position p = await determinePosition();
  //     latitude = p.latitude;
  //     longitude = p.longitude;
  //     kGooglePlex = CameraPosition(
  //       target: LatLng(latitude, longitude),
  //       zoom: 14.4746,
  //     );
  //     final Uint8List markerIcon = await getBytesFromAsset(ImageAssets.mapPin, 100);
  //     //   final Marker marker = Marker(icon: BitmapDescriptor.fromBytes(markerIcon));
  //     Marker marker = Marker(
  //         icon: BitmapDescriptor.fromBytes(markerIcon),
  //         markerId: const MarkerId('event_loc'),
  //         draggable: true,
  //         visible: true,
  //         position: LatLng(latitude, longitude),
  //         onDragEnd: ((newPosition) async {
  //           latitude = newPosition.latitude;
  //           longitude = newPosition.longitude;
  //
  //           kGooglePlex = CameraPosition(
  //             target: LatLng(latitude, longitude),
  //             zoom: 14.4746,
  //           );
  //           final c = await mapController.future;
  //           c.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
  //             target: LatLng(latitude, longitude),
  //             zoom: 14.4746,
  //           )));
  //           setState(() {});
  //         }));
  //     markers[const MarkerId('event_loc')] = marker;
  //     isLoading = false;
  //     setState(() {});
  //   } catch (error) {
  //     print(error);
  //     isLoading = false;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return GetX<LocationController>(
      init: LocationController(),

      builder: (controller) {
        return Container(
          height: getScreenHeight(context)*0.6,
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SheetTitle(title: "Choose your location".tr),
              Expanded(
                child:controller. isLoading.value
                    ? const LoadingWidget()
                    : Stack(
                  children: [
                    GoogleMap(
                      mapType: MapType.terrain,
                      initialCameraPosition: controller.kGooglePlex,
                      markers: controller.markers.values.toSet(),
                      onMapCreated: (GoogleMapController c) {
                        if (!controller.mapController.isCompleted) {
                          controller.mapController.complete(c);
                        }
                      },
                    //  scrollGesturesEnabled: true,
                      // zoomGesturesEnabled: true,
                      gestureRecognizers: {
                        Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer())
                      },
                    ),
                    Positioned(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextFormField(
                                  controller: txtSearch,
                                  onChanged: (val) {
                                    controller.searchLocation2(val);
                                  },
                                  textInputAction: TextInputAction.done,
                                  decoration:  InputDecoration(
                                      hintText: "",
                                      prefixIcon: Icon(
                                        Icons.location_on_outlined,
                                        color: blueColor,
                                      ))),
                            ),
                            controller.predictionList.isEmpty
                                ? const SizedBox()
                                : Container(
                              height: getScreenHeight(context) * 0.2,
                              margin: const EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Scrollbar(
                                thumbVisibility: true,
                                // thickness: 2,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: controller.predictionList.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                                        child: GestureDetector(
                                          onTap: () {
                                            controller.fetchLocationLocation2(controller.predictionList[index].placeId);
                                          },
                                          child: Text(
                                            controller.predictionList[index].description,
                                            style:  TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: black),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 15,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: getScreenWidth(context) * 0.27, vertical: 15),
                        child: Row(
                          children: [
                            Expanded(
                              child: appButton2(
                                  onPressed: () {
                                    widget.latLng(controller.latitude.value,controller. longitude.value);
                                    Get.back();
                                  },
                                  title: "Add the location".tr,
                                  borderColor: blueColor,
                                  textColor: blueColor,
                                  bgColor: white),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}