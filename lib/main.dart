import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'HomePage.dart';
import 'firebase_options.dart';

late FlutterTts flutterTts;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// initialize firebase  services in app
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  flutterTts = FlutterTts();

  final fcmToken = await FirebaseMessaging.instance.getToken();
  print('token: ${fcmToken} token end');
  print('FCM TOKEN: ${fcmToken}');
  await FirebaseMessaging.instance.setAutoInitEnabled(true); //TODO
  await FirebaseMessaging.instance.subscribeToTopic("ssixer");
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');
    final notification = message.notification;
    _speak("new new");
    if (notification != null) {
      print(
          'Message also contained a notification: ${notification.title.toString()}');
    }
  });
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  runApp(const MyApp());
}

Future _speak(String text) async {
  // var result = await flutterTts.speak("You received 5 rupees Sachin");
  flutterTts.speak(text).then((value) {
    print(value.toString());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
