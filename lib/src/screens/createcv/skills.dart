import 'package:flutter/material.dart';
import 'package:job_finder/src/components/button.dart';
import 'package:job_finder/src/components/constext.dart';
import 'package:job_finder/src/components/cvindicators.dart';
import 'package:job_finder/src/helpers/color.dart';
import 'package:job_finder/src/helpers/decoration.dart';
import 'package:job_finder/src/helpers/spacer.dart';
import 'package:job_finder/src/screens/loaders/loadscreen.dart';
import 'package:job_finder/src/services/databse/classmodel_database/personalinfocm.dart';
import 'package:job_finder/src/services/databse/classmodel_database/skillscm.dart';
import 'package:job_finder/src/services/databse/sqflite_services.dart';
import 'package:job_finder/src/utils/packagescard/cvtoast.dart';
import 'package:page_transition/page_transition.dart';

class Skills extends StatefulWidget {
  const Skills({super.key});

  @override
  State<Skills> createState() => _SkillsState();
}

class _SkillsState extends State<Skills> {
  final TextEditingController skills1 = TextEditingController();
  final TextEditingController skills2 = TextEditingController();
  final TextEditingController skills3 = TextEditingController();
  final TextEditingController skills4 = TextEditingController();
  final TextEditingController skills5 = TextEditingController();
  final TextEditingController skills6 = TextEditingController();
  final TextEditingController skills7 = TextEditingController();
  final TextEditingController skills8 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: bgdecor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            vertical(30),
            buttonback(context),
            vertical(35),
            boldtext(color.textcolor, 30, 'Create Your CV'),
            vertical(40),
            mediumtext(color.textcolor, 22, 'Skills'),
            vertical(15),
            textarea('Enter Skill', skills1, icon: true),
            vertical(15),
            textarea('Enter Skill', skills2, icon: true),
            vertical(15),
            textarea('Enter Skill', skills3, icon: true),
            vertical(15),
            textarea('Enter Skill', skills4, icon: true),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buttontransparent(() {
                  if (skills1.text.isEmpty ||
                      skills2.text.isEmpty ||
                      skills3.text.isEmpty ||
                      skills4.text.isEmpty) {
                    fluttertoast('Please Fill All Fields', context, red: true);
                  } else {
                    addMore();
                  }
                }, 0.4, boldtext(color.textcolor, 18, 'Add More'), context),
                buttonmain(() {
                  checkdata();
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
            Center(child: boldtext(color.textcolor, 18, 'Step 5')),
            Center(child: CircularIndicator(value: 4)),
            vertical(25)
          ],
        ),
      ),
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
                mediumtext(color.textcolor, 22, 'Skills'),
                vertical(15),
                textarea('Enter Skill', skills5, icon: true),
                vertical(15),
                textarea('Enter Skill', skills6, icon: true),
                vertical(15),
                textarea('Enter Skill', skills7, icon: true),
                vertical(15),
                textarea('Enter Skill', skills8, icon: true),
                vertical(25),
                Align(
                  alignment: Alignment.centerRight,
                  child: buttonmain(() {
                    if (skills5.text.isEmpty &&
                        skills6.text.isEmpty &&
                        skills7.text.isEmpty &&
                        skills8.text.isEmpty) {
                      fluttertoast('Please Enter at least One Skill', context,
                          red: true);
                    } else {
                      if (skills5.text.isNotEmpty) {
                        insertskills(
                            SkillCM(skill: skills5.text, email: useremail));
                      }
                      if (skills6.text.isNotEmpty) {
                        insertskills(
                            SkillCM(skill: skills6.text, email: useremail));
                      }
                      if (skills7.text.isNotEmpty) {
                        insertskills(
                            SkillCM(skill: skills7.text, email: useremail));
                      }
                      if (skills8.text.isNotEmpty) {
                        insertskills(
                            SkillCM(skill: skills8.text, email: useremail));
                      }
                      fluttertoast(
                        'Data Has Been Saved',
                        context,
                      );
                      skills5.clear();
                      skills6.clear();
                      skills7.clear();
                      skills8.clear();
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

  Widget textarea(String hint, TextEditingController controler, {bool? icon}) {
    return SizedBox(
      height: 60,
      child: TextFormField(
        style: textfieldtextstyle,
        controller: controler,
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

  checkdata() {
    if (skills1.text.isEmpty &&
        skills2.text.isEmpty &&
        skills3.text.isEmpty &&
        skills4.text.isEmpty) {
      fluttertoast('Please Enter at least One Skill', context, red: true);
    } else {
      if (skills1.text.isNotEmpty) {
        insertskills(SkillCM(skill: skills1.text, email: useremail));
      }
      if (skills2.text.isNotEmpty) {
        insertskills(SkillCM(skill: skills2.text, email: useremail));
      }
      if (skills3.text.isNotEmpty) {
        insertskills(SkillCM(skill: skills3.text, email: useremail));
      }
      if (skills4.text.isNotEmpty) {
        insertskills(SkillCM(skill: skills4.text, email: useremail));
      }

      Navigator.push(
          context,
          PageTransition(
              child: const LoadScreen(), type: PageTransitionType.rightToLeft));
    }
  }
}
