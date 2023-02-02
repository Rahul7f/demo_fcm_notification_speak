import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late FlutterTts flutterTts;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    flutterTts = FlutterTts();

  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children:  [
            InkWell(onTap: () {
              _speak();
            }, child: Text("Notification"))
          ],
        ),
      ),
    );
  }
  Future _speak() async{
    // var result = await flutterTts.speak("You received 5 rupees Sachin");
    flutterTts.speak("").then((value) {
      print(value.toString());
    });
  }

}
