// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:job_finder/src/components/button.dart';
import 'package:job_finder/src/components/constext.dart';
import 'package:job_finder/src/helpers/color.dart';
import 'package:job_finder/src/helpers/decoration.dart';
import 'package:job_finder/src/helpers/spacer.dart';
import 'package:job_finder/src/screens/createcv/personalinfo.dart';
import 'package:job_finder/src/screens/loaders/loadscreen.dart';
import 'package:job_finder/src/screens/userauth/signup.dart';
import 'package:job_finder/src/services/databse/classmodel_database/personalinfocm.dart';
import 'package:job_finder/src/services/databse/sqflite_services.dart';
import 'package:job_finder/src/utils/packagescard/cvtoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController email = TextEditingController();
  final TextEditingController pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 55),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: bgdecor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            vertical(50),
            Center(child: Image.asset('assets/images/logo.png')),
            vertical(45),
            boldtext(color.textcolor, 35, 'Login'),
            vertical(20),
            regulartext(color.textcolor, 20, 'Login Now'),
            vertical(15),
            SizedBox(
              height: 50,
              child: TextFormField(
                style: textfieldtextstyle,
                controller: email,
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
            vertical(20),
            SizedBox(
              height: 50,
              child: TextFormField(
                style: textfieldtextstyle,
                controller: pass,
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
            Padding(
              padding: const EdgeInsets.only(right: 40),
              child: InkWell(
                onTap: (() {}),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Align(
                      alignment: Alignment.topRight,
                      child: boldtext(color.textcolor, 18, 'Forgot')),
                ),
              ),
            ),
            vertical(15),
            Align(
              alignment: Alignment.topRight,
              child: buttonmain(() async {
                bool a = await getusers(email.text.toLowerCase(), pass.text);
                bool b = await checkuserexistance(email.text.toLowerCase());
                // getusers(email.text, pass.text);

                if (a == true) {
                  savelocal(email.text);
                  if (b == true) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const LoadScreen()));
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const PersonalInfo()));
                  }
                } else {
                  fluttertoast('Incorrect Authentication', context, red: true);
                }
              }, color.btnbg, 0.35, mediumtext(color.btntext, 18, 'Sign In'),
                  context),
            ),
            vertical(35),
            //-------------------------------------------------Facebook button---------------------------
            buttonmain(
                () {},
                color.textcolor,
                1,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.facebook,
                      color: Colors.blue,
                    ),
                    horizental(20),
                    mediumtext(Colors.black, 18, 'Continue With Facebook')
                  ],
                ),
                context),
            // ElevatedButton(
            //     onPressed: () {
            //       deletedatabase();
            //     },
            //     child: Text('delete database')),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                regulartext(color.textcolor, 16, "Don't have an account?"),
                horizental(10),
                InkWell(
                    onTap: (() {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SignUp()));
                    }),
                    child: boldtext(color.textcolor, 18, "Signup")),
                // vertical(90)
              ],
            )
          ],
        ),
      ),
    );
  }
}

savelocal(String email) async {
  final prefs = await SharedPreferences.getInstance();
  useremail = email;
  prefs.setBool('login', true);
  prefs.setString('email', email);
}
