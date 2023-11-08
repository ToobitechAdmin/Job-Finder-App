// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:job_finder/src/components/button.dart';
import 'package:job_finder/src/components/constext.dart';
import 'package:job_finder/src/components/cvindicators.dart';
import 'package:job_finder/src/helpers/color.dart';
import 'package:job_finder/src/helpers/decoration.dart';
import 'package:job_finder/src/helpers/spacer.dart';
import 'package:job_finder/src/screens/createcv/skills.dart';
import 'package:job_finder/src/services/databse/classmodel_database/experiancecm.dart';
import 'package:job_finder/src/services/databse/classmodel_database/personalinfocm.dart';
import 'package:job_finder/src/services/databse/sqflite_services.dart';
import 'package:job_finder/src/utils/packagescard/cvtoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Experience extends StatefulWidget {
  const Experience({super.key});

  @override
  State<Experience> createState() => _ExperienceState();
}

class _ExperienceState extends State<Experience> {
  final TextEditingController jobtitle = TextEditingController();
  final TextEditingController company = TextEditingController();
  final TextEditingController fromyear = TextEditingController();
  final TextEditingController toyear = TextEditingController();
  final TextEditingController jobtitle1 = TextEditingController();
  final TextEditingController company1 = TextEditingController();
  final TextEditingController fromyear1 = TextEditingController();
  final TextEditingController toyear1 = TextEditingController();
  bool fresh = false;
  bool present = false;
  @override
  Widget build(BuildContext context) {
    // ToastContext().init(context);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Container(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 55),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: bgdecor,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              vertical(30),
              buttonback(context),
              vertical(35),
              boldtext(color.textcolor, 30, 'Create Your CV'),
              vertical(40),
              mediumtext(color.textcolor, 22, 'Experience'),
              vertical(15),
              textarea(
                'Job Title',
                jobtitle,
              ),
              vertical(15),
              textarea('Company', company),
              vertical(15),
              textarea('From Year', fromyear, icon: true, ontap: true),
              vertical(15),
              textarea('To Year', toyear, icon: true, ontap: true),
              vertical(15),
              Row(
                children: [
                  InkWell(
                    onTap: (() {
                      setState(() {
                        present = !present;
                        if (fresh == true) {
                          fresh = false;
                        }
                      });
                    }),
                    child: Icon(
                      (present)
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
                      color: color.btnbg,
                    ),
                  ),
                  horizental(10),
                  boldtext(color.textcolor, 16, 'Present')
                ],
              ),
              vertical(15),
              // const Spacer(),
              Row(
                children: [
                  InkWell(
                    onTap: (() {
                      setState(() {
                        fresh = !fresh;
                        if (present == true) {
                          present = false;
                        }
                      });
                    }),
                    child: Icon(
                      (fresh) ? Icons.check_box : Icons.check_box_outline_blank,
                      color: color.btnbg,
                    ),
                  ),
                  horizental(10),
                  boldtext(color.textcolor, 16, 'Fresh')
                ],
              ),
              // const Spacer(),
              vertical(40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buttontransparent(() {
                    if (jobtitle.text.isEmpty ||
                        company.text.isEmpty ||
                        fromyear.text.isEmpty) {
                      fluttertoast('Please Fill All Fields', context,
                          red: true);
                    } else {
                      addMore();
                    }
                  }, 0.4, boldtext(color.textcolor, 18, 'Add More'), context),
                  buttonmain(() {
                    checkdata();
                    // getqualifications();
                    // fluttertoast('You Data Has been saved');
                    // Toast.show("Show Bottom Toast", gravity: Toast.bottom);
                  },
                      color.btnbg,
                      0.4,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          boldtext(color.btntext, 18, 'Next'),
                          horizental(15),
                          Image.asset('assets/images/icons/forwardarrow.png')
                        ],
                      ),
                      context)
                ],
              ),
              vertical(15),
              Center(child: boldtext(color.textcolor, 18, 'Step 4')),
              Center(child: CircularIndicator(value: 3)),
              vertical(25)
            ],
          ),
        ),
      ),
    );
  }

//-----------------------------------------------------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------Custom Yesr picker------------------------------------------------
//-----------------------------------------------------------------------------------------------------------------------------------------
  void pickYear(BuildContext context, TextEditingController controller) {
    showDialog(
      context: context,
      builder: (context) {
        final Size size = MediaQuery.of(context).size;
        return AlertDialog(
          backgroundColor: const Color(0xff151414),
          title: Center(child: boldtext(color.textcolor, 18, 'Select a Year')),
          contentPadding: const EdgeInsets.all(10),
          content: SizedBox(
            height: size.height / 3,
            width: size.width,
            child: GridView.count(
              crossAxisCount: 3,
              children: [
                ...List.generate(
                  123,
                  (index) => InkWell(
                    onTap: () {
                      setState(() {
                        controller.text = (2022 - index).toString();
                      });
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      child: Chip(
                        backgroundColor: const Color(0xff313131),
                        label: SizedBox(
                            height: 25,
                            width: size.width / 3,
                            child: Center(
                              child: boldtext(color.textcolor, 14,
                                  (2022 - index).toString()),
                            )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  //-----------------------------------------------------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------Add More------------------------------------------------
//-----------------------------------------------------------------------------------------------------------------------------------------

  addMore() {
    return showModalBottomSheet(
        backgroundColor: Colors.black.withOpacity(0.65),
        barrierColor: Colors.black.withOpacity(0.95),
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.8,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
                image: DecorationImage(
                    image: AssetImage(
                      'assets/images/bg.png',
                    ),
                    fit: BoxFit.fill)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                vertical(20),
                mediumtext(color.textcolor, 22, 'Experience'),
                vertical(15),
                textarea(
                  'Job Title',
                  jobtitle1,
                ),
                vertical(15),
                textarea('Company', company1),
                vertical(15),
                textarea('From Year', fromyear1, icon: true, ontap: true),
                vertical(15),
                textarea('To Year', toyear1, icon: true, ontap: true),
                vertical(25),
                Align(
                  alignment: Alignment.centerRight,
                  child: buttonmain(() {
                    if (jobtitle1.text.isEmpty ||
                        company1.text.isEmpty ||
                        fromyear1.text.isEmpty ||
                        (toyear1.text.isEmpty && present == false)) {
                      fluttertoast('Please Fill All Fields', context,
                          red: true);
                    } else {
                      insertexperiance(ExperianceCM(
                          jobtitle: jobtitle1.text,
                          companyname: company1.text,
                          fromyear: fromyear1.text,
                          toyear: toyear1.text,
                          email: useremail));

                      fluttertoast('You Data Has been saved', context);
                      jobtitle1.clear();
                      company1.clear();
                      fromyear1.clear();
                      toyear1.clear();
                      Navigator.pop(context);
                    }
                  }, color.btnbg, 0.4, boldtext(color.btntext, 16, 'Save'),
                      context),
                )
              ],
            ),
          );
        });
  }

  //-----------------------------------------------------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------Text Form Field------------------------------------------------
//-----------------------------------------------------------------------------------------------------------------------------------------

  Widget textarea(String hint, TextEditingController controler,
      {bool? icon, bool? ontap}) {
    return SizedBox(
      height: 60,
      child: TextFormField(
        style: textfieldtextstyle,
        controller: controler,
        readOnly: (ontap == true) ? true : false,
        onTap: () {
          if (ontap == true) {
            pickYear(context, controler);
          }
        },
        decoration: InputDecoration(
            suffixIcon: (icon == true)
                ? const Icon(
                    Icons.arrow_drop_down_rounded,
                    size: 25,
                    color: Colors.white,
                  )
                : null,
            hintText: hint,
            hintStyle: textfieldtextstyle,
            contentPadding: const EdgeInsets.only(left: 25),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
            fillColor: color.textfieldbg),
      ),
    );
  }

  checkdata() async {
    if (fresh) {
      freshcandidate = true;
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool('fresh', true);
      Navigator.push(
          context,
          PageTransition(
              child: const Skills(), type: PageTransitionType.rightToLeft));
    } else if (jobtitle.text.isEmpty ||
        company.text.isEmpty ||
        fromyear.text.isEmpty ||
        (toyear.text.isEmpty && present == false)) {
      fluttertoast('Please Fill All Fields', context, red: true);
    } else {
      insertexperiance(ExperianceCM(
          jobtitle: jobtitle.text,
          companyname: company.text,
          fromyear: fromyear.text,
          toyear: present == false ? toyear.text : 'PRESENT',
          email: useremail));

      Navigator.push(
          context,
          PageTransition(
              child: const Skills(), type: PageTransitionType.rightToLeft));
    }
  }
}

bool? freshcandidate;
