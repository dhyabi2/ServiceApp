import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'main.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  log('A new onBackgroundMessage event was published!=========${message.data}');
  if (message.data.isNotEmpty) {
    flutterLocalNotificationsPlugin.show(
        message.data.hashCode,
        message.notification!.title!,
        message.notification!.body!,
        NotificationDetails(
          android: AndroidNotificationDetails(
            message.notification!.title!,
            message.notification!.body!,
          ),
        ));
  }
}
//
// Future<void> showNotification(
//   int notificationId,
//   String notificationTitle,
//   String notificationContent,
//   String payload, {
//   String channelId = '1234',
//   String channelTitle = 'Android Channel',
// }) async {
//   showOverlayNotification(
//     (context) {
//       return Card(
//         shadowColor: AllColors.blueColor.withOpacity(0.5),
//         color: AllColors.whiteColor,
//         elevation: 1,
//         borderOnForeground: true,
//         surfaceTintColor: AllColors.lightBlueColor,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
//         margin: const EdgeInsets.only(top: 45, left: 15, right: 15),
//         child: Container(
//           width: double.infinity,
//           padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 notificationTitle,
//                 style: const TextStyle(
//                   fontSize: 15,
//                   color: AllColors.blackColor,
//                   fontWeight: FontWeight.w500,
//                   letterSpacing: 1,
//                   height: 1.2,
//                 ),
//               ),
//               Text(notificationContent,
//                   style: const TextStyle(
//                     fontSize: 12,
//                     color: AllColors.textGreyColor,
//                     fontWeight: FontWeight.w300,
//                     letterSpacing: 1,
//                     height: 1.2,
//                   )),
//             ],
//           ),
//         ),
//       );
//     },
//     duration: const Duration(milliseconds: 3000),
//   );
//   log("inside");
//   // AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
//   //   channelId,
//   //   channelTitle,
//   //   playSound: true,
//   //   importance: Importance.high,
//   //   priority: Priority.high,
//   // );
//   // DarwinNotificationDetails iOSPlatformChannelSpecifics =
//   //     DarwinNotificationDetails(presentSound: true, subtitle: notificationContent, presentAlert: true);
//   // NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
//   // flutterLocalNotificationsPlugin.show(
//   //   notificationId,
//   //   notificationTitle,
//   //   notificationContent,
//   //   platformChannelSpecifics,
//   //   payload: payload,
//   // );
// }

void onDidReceiveLocalNotification(int id, String? title, String? body, String? payload) async {
  // showNotification(id, title!, body!, "GET PAYLOAD FROM message OBJECT");
  flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          title!,
          body!,
        ),
      ));
}

Future onSelectNotification(RemoteMessage payload) async {
//  String notificationType = payload.data['type'];
  // switch (notificationType) {
  //   case "0":
  //     break;
  // }
}
