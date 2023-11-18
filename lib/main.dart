import 'dart:developer';

import 'package:cleaning/splashscreen.dart';
import 'package:cleaning/utils/color.dart';
import 'package:cleaning/utils/controller.dart';
import 'package:cleaning/utils/localstring.dart';
import 'package:cleaning/utils/string.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'keys.dart';
import 'notification_handlers.dart';

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarBrightness: Brightness.light, statusBarIconBrightness: Brightness.light
          // transparent status bar
          ));
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
  await Firebase.initializeApp();
  if (defaultTargetPlatform == TargetPlatform.iOS) iOSPermission();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  const DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(onDidReceiveLocalNotification: onDidReceiveLocalNotification);
  const initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
  const initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsDarwin);
  flutterLocalNotificationsPlugin.initialize(initializationSettings);
  AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title// description
      importance: Importance.high,
      enableLights: true,
      enableVibration: true,
      playSound: true,
      showBadge: true);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  _firebaseMessaging.getInitialMessage();
  _firebaseMessaging.getNotificationSettings();
  _firebaseMessaging.app.setAutomaticDataCollectionEnabled(true);
  _firebaseMessaging.requestPermission(
    alert: true,
    sound: true,
  );
  _firebaseMessaging.setAutoInitEnabled(true);
  _firebaseMessaging.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  // String? token = await _firebaseMessaging.getToken();
  // log("Token===$token");
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification notification = message.notification!;
    log('A new onMessage event was published!${message.data}');
    onDidReceiveLocalNotification(
      1234,
      notification.title!,
      notification.body!,
      "GET PAYLOAD FROM message OBJECT",
    );
    // if (message.data['type'] == 'chat') {
    //   chatNotificationCount.value++;
    // } else {}
  });
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    log('A new onMessageOpenedApp event was published!${message.data}');
    log('A new onMessageOpenedApp event was published!${message.notification}');
    onSelectNotification(message);
  });

  final Globlecontroller globlecontroller = Get.put(Globlecontroller());

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool data = false;
  Globlecontroller globlecontroller =Get.find();
  @override
  void initState() {
    // TODO: implement initState
    getLangauge();
    super.initState();
  }

  getLangauge() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getBool(Keys().language));
    bool? data2 = prefs.getBool(Keys().language);
    await prefs.setBool(Keys().language, false);
    Get.updateLocale(const Locale('ar', 'AR')); // Corrected language code
    globlecontroller.english.value = false;
    globlecontroller.arabic.value = true;
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: LocaleString(),
      locale: const Locale('en', 'EN'),
      theme: ThemeData(
          appBarTheme:
              AppBarTheme(titleTextStyle: TextStyle(color: black, fontSize: 22, fontWeight: FontWeight.w400, fontFamily: CustomStrings.dnmed))),
      // data == true ? const Locale('en', 'EN') : const Locale('ar', 'AR'),
      home: const Scaffold(
        backgroundColor: Colors.black,
        body: SplashScreen(),
      ),
    );
  }
}

void iOSPermission() {
  _firebaseMessaging.setAutoInitEnabled(true);
  _firebaseMessaging.getNotificationSettings();
  _firebaseMessaging.requestPermission(alert: true, badge: true, sound: true);
}
