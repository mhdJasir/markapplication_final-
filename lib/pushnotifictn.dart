//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class Pushnotifictionexample extends StatefulWidget {
  @override
  _PushnotifictionexampleState createState() => _PushnotifictionexampleState();
}

class _PushnotifictionexampleState extends State<Pushnotifictionexample> {
  String messageTitle = "Empty";
  String notificationAlert = "Alert";

  //FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  @override
  void initState() {
    super.initState();

    // _firebaseMessaging.configure(
    //   onMessage: (message) async {
    //     setState(() {
    //       messageTitle = message["notification"]["title"];
    //       notificationAlert = "New Notification Alert";
    //     });
    //   },
    //   onResume: (message) async {
    //     setState(() {
    //       messageTitle = message["data"]["title"];
    //       notificationAlert = "Application opened from Notification";
    //     });
    //   },
    // );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PushNotification"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              notificationAlert,
            ),
            Text(
              messageTitle,
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }
}
