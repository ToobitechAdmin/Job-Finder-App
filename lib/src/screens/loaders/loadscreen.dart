import 'dart:async';

import 'package:flutter/material.dart';
import 'package:job_finder/src/screens/homepage/home.dart';
import 'package:job_finder/src/services/databse/sqflite_services.dart';
import 'package:provider/provider.dart';

class LoadScreen extends StatefulWidget {
  const LoadScreen({super.key});

  @override
  State<LoadScreen> createState() => _LoadScreenState();
}

class _LoadScreenState extends State<LoadScreen> {
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Home())));
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<DataBaseState>(context).getpersonal();
    Provider.of<DataBaseState>(context).getcontact();
    Provider.of<DataBaseState>(context).getqualifications();
    Provider.of<DataBaseState>(context).getexperiance();
    Provider.of<DataBaseState>(context).getskills();
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/updating.png'),
                fit: BoxFit.fill)),
      ),
    );
  }
}
