import 'package:digdes_ui/data/services/database.dart';
import 'package:digdes_ui/firebase_options.dart';
import 'package:digdes_ui/internal/utils.dart';
import 'package:digdes_ui/ui/navigation/app_navigator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

Future initApp() async {
  await initFirebase();
  await DB.instance.init();
}

Future initFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  var messaging = FirebaseMessaging.instance;
  await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true);

  FirebaseMessaging.onMessage.listen(catchMessage);
  FirebaseMessaging.onMessageOpenedApp.listen(catchMessage);

  try {
    (await messaging.getToken() ?? 'no token').console();
  } catch (e) {
    e.toString().console();
  }
}

void catchMessage(RemoteMessage message) {
  'Got a message'.console();
  'Message data: ${message.data}'.console();
  if (message.notification != null) {
    showModal(message.notification!.title!, message.notification!.body!);
  }
}

void showModal(String title, String content) {
  var ctx = AppNavigator.key.currentContext;
  if (ctx != null) {
    showDialog(
        context: ctx,
        builder: ((context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.done))
            ],
          );
        }));
  }
}
