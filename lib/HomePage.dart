import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'LocalNotificationService.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String token = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /// 1. This method call when app in terminated state and you get a notification
    /// when you click on notification app open from terminated state and you can get notification data in this method
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        print("-------------New Notification-----------------");
        _speak("new notification from getInitialMessage");
      }
    },);

    /// 2. This method only call when App in foreground it mean app must be opened
    FirebaseMessaging.onMessage.listen((message) {
      print("on listen");
      if (message.notification != null) {
        print(message.notification!.title);
        print(message.notification!.body);
        _speak(message.notification!.body ?? "");
        print("message.data11 ${message.data}");
        LocalNotificationService.createanddisplaynotification(message);
      }
    },
    );
    /// 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("-----------------------message opened from background---------------");
      if (message.notification != null) {
        print(message.notification!.title);
        print(message.notification!.body);
        // _speak(message.notification!.body ?? "");
      }
    },
    );
    FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);
    gettoken();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SelectableText(token),
            SizedBox(height: 100,),
            InkWell(onTap: () {
              _speak("on tap");
            }, child: const Text("Notification"))
          ],
        ),
      ),
    );
  }

  gettoken() async {
    await FirebaseMessaging.instance.getToken().then((value) {
      setState(() {
        token = value??"no";
      });
    });
  }

}

Future<void> backgroundMessageHandler(RemoteMessage message) async {
  print(message.data);
  _speak("form background Message Handler");
}


Future _speak(String text) async {
  // var result = await flutterTts.speak("You received 5 rupees Sachin");
  FlutterTts flutterTts = FlutterTts();
  flutterTts.speak(text).then((value) {
    print(value.toString());
  });
}
