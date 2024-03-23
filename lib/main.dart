import 'dart:io';

import 'package:breastfirst/api/model/diskstorage.dart';
import 'package:breastfirst/api/secret.dart';
import 'package:breastfirst/pages/homepage.dart';
import 'package:breastfirst/pages/login-screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';


final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await init();

  bool loggedin = await Localstorage().getUserIDLocal() != null;
  runApp(MyApp(isLoggedin: loggedin));
  // runApp(const MyApp());
}

Future init() async{

  if (Platform.isIOS) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
          apiKey: ApiKey,
          appId: AppId,
          messagingSenderId: MessagingSenderID,
          projectId: ProjectID,
        )).then((value) => {
      FirebaseMessaging
          .instance // This is to enable the notification run while app is in terminated mode
          .getInitialMessage()
          .then((RemoteMessage? message) {
        if (message != null) {}
      }),

    });
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  } else {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform
    );
  }

  await WidgetsFlutterBinding.ensureInitialized();
}

class MyApp extends StatelessWidget {
  final isLoggedin;
  const MyApp({Key? key, this.isLoggedin = true}) : super(key: key);
 // const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(/**/
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    //  home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: isLoggedin == true ? const MyHomePage() : SignInPage(),
    );
  }
}


