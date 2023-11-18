import 'package:cached_network_image/cached_network_image.dart';
import 'package:cleaning/utils/string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

import 'color.dart';

commonToast(String massage) {
  return Fluttertoast.showToast(
      msg: massage, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: primmarycolor, textColor: Colors.white, fontSize: 16.0);
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class LoadingStateWidget extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const LoadingStateWidget({required this.isLoading, required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [child, Positioned(left: 0, right: 0, child: isLoading ? const LoadingWidget() : const SizedBox())],
    );
  }
}

class ErrorText extends StatelessWidget {
  final String error;

  const ErrorText({required this.error, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      error,
      style: TextStyle(color: primmarycolor, fontSize: 16, fontFamily: CustomStrings.dbold),
    );
  }
}

Widget cachedImageForItem(String url, {double? height, double? width, BoxFit? boxFit}) => CachedNetworkImage(
      imageUrl: url,
      height: height,
      width: width,
      fit: boxFit,
      placeholder: (context, url) => CupertinoActivityIndicator(radius: 30.0, animating: true, color: primmarycolor),
    );

 determinePosition() async {
  Location location = Location();

  bool serviceEnabled;
  PermissionStatus permissionGranted;
  LocationData locationData;

  serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      throw Exception("Enable location");
    }
  }

  permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      throw Exception("allow location permission.");
    }
  }

  locationData = await location.getLocation();
  return locationData;

}

class AppBarBottomBorder extends StatelessWidget {
  const AppBarBottomBorder({super.key});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(4.0),
      child: Container(
        color: appBarBorderColor,
        height: 2.0,
      ),
    );
  }
}

sendWhatsAppMessage(number) {
  // log("aaa");
  var whatsappUrl = "whatsapp://send?phone=+968$number" "&text=hello";
  try {
    launchUrl(Uri.parse(whatsappUrl));
  } catch (e) {
    //To handle error and display error message
    commonToast("Unable to open whatsapp");
  }
}
