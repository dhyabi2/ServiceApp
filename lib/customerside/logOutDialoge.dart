import 'package:cleaning/signup/login_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../keys.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Logout'),
      content: const Text('Are you sure you want to logout?'),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Get.back(); // Dismiss the dialog with "false" as result.
          },
        ),
        TextButton(
          child: const Text('Logout'),
          onPressed: () async {
            final SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setBool(Keys().login, false);
            await FirebaseMessaging.instance.deleteToken();
            Get.offAll(const LoginScreen());
          },
        ),
      ],
    );
  }
}
