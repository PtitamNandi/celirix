import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';
import 'loginservices.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  OpenURL openURL = OpenURL();
  // @override
  // void initState() {
  //   super.initState();

  //   // openURL.launchURLApp('https://celirix.com/login');
  // }
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
 
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id, 
                channel.name,
                channelDescription: channel.description,
                importance: Importance.max,
                priority: Priority.high,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
                largeIcon: const DrawableResourceAndroidBitmap('justwater'),
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body!)],
                  ),
                ),
              );
            });
      }
    });
  }

  void showNotification() {
    setState(() {
      _counter++;
    });
    flutterLocalNotificationsPlugin.show(
      0,
      "Testing $_counter",
      "How you doin ?",
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          importance: Importance.high,
          color: Colors.blue,
          playSound: true,
          icon: '@mipmap/ic_launcher',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // SizedBox(
            //   height: 50,
            // ),
            Image.asset(
              'images/celirix_logo_big.png',
              height: 130.0,
              width: 130.0,
            ),
            SizedBox(
              height: 300,
              width: 300,
              child: SvgPicture.asset('images/img-auth-3.svg'),
            ),
            Text(
              "A Platform to make your life easier ",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: size.width - 50,
              height: 45,
              child: ElevatedButton(
                child: Text("Visit us".toUpperCase(),
                    style: TextStyle(fontSize: 14)),
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.deepPurple.shade900),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                      side: BorderSide(color: Colors.deepPurple.shade900),
                    ),
                  ),
                ),
                onPressed: () async {
                  openURL.launchURLApp('https://celirix.com');
                },
              ),
            ),
            SizedBox(
              width: size.width - 50,
              height: 45,
              child: ElevatedButton(
                child: Text("Login to Celirix".toUpperCase(),
                    style: TextStyle(fontSize: 14)),
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.deepPurple.shade900),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                      side: BorderSide(color: Colors.deepPurple.shade900),
                    ),
                  ),
                ),
                onPressed: () async {
                  openURL.launchURLApp('https://celirix.com/login');
                },
              ),
            ),
            SizedBox(
              width: size.width - 50,
              height: 45,
              child: ElevatedButton(
                  child: Text("notification".toUpperCase(),
                      style: TextStyle(fontSize: 14)),
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.deepPurple.shade900),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                        side: BorderSide(color: Colors.deepPurple.shade900),
                      ),
                    ),
                  ),
                  onPressed: showNotification
                  // onPressed: () {
                  // openURL.launchURLApp('https://celirix.com/login');
                  // },
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
