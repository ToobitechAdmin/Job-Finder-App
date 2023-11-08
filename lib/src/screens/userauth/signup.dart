// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:job_finder/src/components/button.dart';
import 'package:job_finder/src/components/constext.dart';
import 'package:job_finder/src/helpers/color.dart';
import 'package:job_finder/src/helpers/decoration.dart';
import 'package:job_finder/src/helpers/spacer.dart';
import 'package:job_finder/src/screens/userauth/login.dart';
import 'package:job_finder/src/services/databse/classmodel_database/contactcm.dart';
import 'package:job_finder/src/services/databse/sqflite_services.dart';
import 'package:job_finder/src/utils/packagescard/cvtoast.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with SingleTickerProviderStateMixin {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController pass = TextEditingController();
  String emailmsg = '';
  bool emailerror = false;
  bool special = false;
  bool small = false;
  bool capital = false;
  bool digits = false;
  AnimationController? _controller;
  Animation? _animation;

  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _animation = Tween(begin: 110.0, end: 30.0).animate(_controller!)
      ..addListener(() {
        setState(() {});
      });

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _controller!.forward();
      } else {
        _controller!.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller!.dispose();
    _focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: bgdecor,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              vertical(40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buttonback(context),
                  Image.asset('assets/images/logo.png'),
                  horizental(0),
                ],
              ),
              SizedBox(height: _animation!.value),
              boldtext(color.textcolor, 35, 'Signup'),
              vertical(20),
              // Center(
              //     child: regulartext(
              //         color.textcolor, 20, 'or enter your phone number')),
              vertical(15),
              SizedBox(
                height: 50,
                child: TextFormField(
                  style: textfieldtextstyle,
                  controller: name,
                  // focusNode: _focusNode,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 25),
                      hintText: 'Name',
                      hintStyle: textfieldtextstyle,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25)),
                      fillColor: color.textfieldbg),
                ),
              ),
              vertical(20),
              SizedBox(
                height: 50,
                child: TextFormField(
                  style: textfieldtextstyle,
                  controller: email,
                  // focusNode: _focusNode,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 25),
                      hintText: 'Email',
                      hintStyle: textfieldtextstyle,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25)),
                      fillColor: color.textfieldbg),
                ),
              ),
              (emailerror)
                  ? boldtext(Colors.red, 12, emailmsg)
                  : const SizedBox.shrink(),
              vertical(20),
              SizedBox(
                height: 50,
                child: TextFormField(
                  style: textfieldtextstyle,
                  controller: pass,
                  focusNode: _focusNode,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 25),
                      hintText: 'Password',
                      hintStyle: textfieldtextstyle,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25)),
                      fillColor: color.textfieldbg),
                ),
              ),
              vertical(30),
              vertical(15),
              Align(
                alignment: Alignment.topRight,
                child: buttonmain(() async {
                  setState(() {
                    special = false;
                    small = false;
                    capital = false;
                    digits = false;
                  });
                  checking();
                }, color.btnbg, 0.35, mediumtext(color.btntext, 18, 'Next'),
                    context),
              ),
              vertical(35),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  regulartext(color.textcolor, 16, "Already have an account?"),
                  horizental(10),
                  InkWell(
                      onTap: (() {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SignIn()));
                      }),
                      child: boldtext(color.textcolor, 18, "Signin")),
                  vertical(90)
                ],
              ),
              vertical(25)
            ],
          ),
        ),
      ),
    );
  }

  checking() async {
    for (var i = 0; i < pass.text.length; i++) {
      if (pass.text.codeUnitAt(i) >= 48 && pass.text.codeUnitAt(i) <= 57) {
        setState(() {
          digits = true;
        });
      } else if (pass.text.codeUnitAt(i) >= 65 &&
          pass.text.codeUnitAt(i) <= 90) {
        capital = true;
      } else if (pass.text.codeUnitAt(i) >= 97 &&
          pass.text.codeUnitAt(i) <= 122) {
        small = true;
      } else if ((pass.text.codeUnitAt(i) >= 33 &&
              pass.text.codeUnitAt(i) <= 47) ||
          (pass.text.codeUnitAt(i) >= 58 && pass.text.codeUnitAt(i) <= 64)) {
        special = true;
      }
    }
    if (name.text.isEmpty || email.text.isEmpty || pass.text.isEmpty) {
      fluttertoast('Please Fill All Fields', context, red: true);
    } else if (digits == false ||
        capital == false ||
        small == false ||
        special == false) {
      fluttertoast('Password Must Contain a-z , A-Z, 0-9, !-@', context,
          red: true, top: true);
    } else {
      String a = await insertusers(UserCM(
          name: name.text,
          email: email.text.toLowerCase(),
          password: pass.text));

      if (a == 'created') {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const SignIn()));
      } else if (a == 'exists') {
        setState(() {
          emailerror = true;
          emailmsg = 'Already exists';
        });
      } else {
        fluttertoast('Network error', context, red: true);
      }
    }
  }
}
