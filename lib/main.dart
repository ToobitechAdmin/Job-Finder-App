// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:job_finder/src/screens/createcv/experience.dart';
import 'package:job_finder/src/screens/createcv/personalinfo.dart';
import 'package:job_finder/src/screens/loaders/loadscreen.dart';
import 'package:job_finder/src/screens/userauth/login.dart';
import 'package:job_finder/src/services/databse/classmodel_database/personalinfocm.dart';
import 'package:job_finder/src/services/databse/db_provider.dart';
import 'package:job_finder/src/services/databse/sqflite_services.dart';
import 'package:job_finder/src/state/profilestate.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    systemNavigationBarColor: Colors.transparent,
    statusBarColor: Colors.transparent,
  ));

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ProfileState()),
      ChangeNotifierProvider(create: (context) => DataBaseState()),
    ],
    child: const MyApp(),
  ));
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
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool data = false;
  init() async {
    final prefs = await SharedPreferences.getInstance();

    useremail = prefs.getString('email');
    freshcandidate = prefs.getBool('fresh');
    localimgpath = prefs.getString('$useremail');
    bool b = await checkuserexistance(useremail.toString());
    if (kDebugMode) {
      print(useremail);
      print(localimgpath);
      print('fresh = $freshcandidate');
    }
    if (useremail != null) {
      print(b);
      setState(() {
        data = b;
      });
    }
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    DatabaseProvider.db.database;

    init();
    Timer(
        const Duration(seconds: 2),
        () => Navigator.of(context).push(MaterialPageRoute(
            builder: ((context) => (useremail != null)
                ? (data == true)
                    ? const LoadScreen()
                    : const PersonalInfo()
                : const SignIn()))));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/splash.png'),
                  fit: BoxFit.fill))),
    );
  }
}
