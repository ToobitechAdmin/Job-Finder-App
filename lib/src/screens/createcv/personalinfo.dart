// ignore_for_file: unnecessary_this

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:job_finder/src/components/button.dart';
import 'package:job_finder/src/components/constext.dart';
import 'package:job_finder/src/components/cvindicators.dart';
import 'package:job_finder/src/helpers/color.dart';
import 'package:job_finder/src/helpers/decoration.dart';
import 'package:job_finder/src/helpers/spacer.dart';
import 'package:job_finder/src/screens/createcv/contactinfo.dart';
import 'package:job_finder/src/services/databse/classmodel_database/personalinfocm.dart';
import 'package:job_finder/src/services/databse/sqflite_services.dart';
import 'package:job_finder/src/utils/packagescard/cvtoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({super.key});

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  final TextEditingController name = TextEditingController();
  final TextEditingController gender = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController email = TextEditingController();
  List<PersonalInformationCM> data = [];
  String? imgpath;
  DateTime pre_backpress = DateTime.now();

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // print(usercheck.length);
    email.text = useremail.toString();
    return WillPopScope(
      onWillPop: () async {
        final timegap = DateTime.now().difference(pre_backpress);
        final cantExit = timegap >= const Duration(seconds: 2);

        pre_backpress = DateTime.now();
        if (cantExit) {
          fluttertoast('Press Back button again to Exit', context, red: true);
          return false;
        } else {
          return await SystemChannels.platform
              .invokeMethod('SystemNavigator.pop');
        }
      },
      child: Scaffold(
        // resizeToAvoidBottomInset: false,

        body: Container(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 55),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: bgdecor,
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.92),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  vertical(30),
                  // buttonback(context),
                  vertical(35),
                  boldtext(color.textcolor, 30, 'Create Your CV'),
                  vertical(10),
                  regulartext(color.textcolor, 18, 'OR    Upload CV'),
                  vertical(20),
                  mediumtext(color.textcolor, 22, 'Personal Information'),
                  vertical(15),
                  textarea(
                    'Full Name',
                    name,
                  ),
                  vertical(15),
                  textarea('Gender', gender, icon: true),
                  vertical(15),
                  textarea(
                    'Phone',
                    phone,
                  ),
                  vertical(15),
                  textarea(
                    'Email',
                    email,
                  ),
                  vertical(15),
                  (imgpath != null)
                      ? Center(
                          child: CircleAvatar(
                            radius: 35,
                            backgroundImage:
                                FileImage(File(imgpath.toString())),
                          ),
                        )
                      : const SizedBox.shrink(),
                  vertical(40),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buttontransparent(() {
                        if (email.text.isEmpty ||
                            gender.text.isEmpty ||
                            phone.text.isEmpty ||
                            name.text.isEmpty) {
                          fluttertoast('Please Fill All Fields', context,
                              red: true);
                        } else {
                          uploadphoto();
                        }
                      }, 0.4, boldtext(color.textcolor, 18, 'Upload Photo'),
                          context),
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
                              Image.asset(
                                  'assets/images/icons/forwardarrow.png')
                            ],
                          ),
                          context)
                    ],
                  ),
                  vertical(15),
                  Center(child: boldtext(color.textcolor, 18, 'Step 1')),
                  Center(child: CircularIndicator(value: 0)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  uploadphoto() async {
    final prefs = await SharedPreferences.getInstance();
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    File file = File(image!.path);
    // getting a directory path for saving
    if (kDebugMode) {
      print('file   :  $file');
    }
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String path = appDocDir.path;
    if (kDebugMode) {
      print('app dir path = $path');
    }
    var last = file.toString().split('/').last;
    if (kDebugMode) {
      print(last.toString());
    }
    final File localimg = await file.copy('$path/$last');
    if (kDebugMode) {
      print('local img  = $localimg');
    }
    setState(() {
      imgpath = localimg.path;
      localimgpath = localimg.path;
    });
    prefs.setString('$useremail', imgpath.toString());
// final String path = await path();
  }

  Widget textarea(String hint, TextEditingController controler, {bool? icon}) {
    return SizedBox(
      height: 60,
      child: TextFormField(
        style: textfieldtextstyle,
        keyboardType: (hint.contains('Phone'))
            ? TextInputType.number
            : TextInputType.name,
        readOnly: (hint == 'Gender') ? true : false,
        onTap: () {
          if (hint == 'Gender') {
            genderbottom();
          }
        },
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

  genderbottom() {
    return showModalBottomSheet(
        backgroundColor: Colors.black.withOpacity(0.65),
        barrierColor: Colors.black.withOpacity(0.95),
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: 300,
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buttonmain(() {
                  this.setState(() {
                    gender.text = 'MALE';
                  });
                  Navigator.pop(context);
                }, color.btnbg, 0.6, boldtext(color.btntext, 18, 'MALE'),
                    context),
                vertical(30),
                buttonmain(() {
                  this.setState(() {
                    gender.text = 'FEMALE';
                  });
                  Navigator.pop(context);
                }, color.btnbg, 0.6, boldtext(color.btntext, 18, 'FEMALE'),
                    context),
              ],
            ),
          );
        });
  }

  checkdata() {
    if (email.text.isEmpty ||
        gender.text.isEmpty ||
        phone.text.isEmpty ||
        name.text.isEmpty) {
      fluttertoast('Please Fill All Fields', context, red: true);
    } else {
      insertpersonal(PersonalInformationCM(
          fullname: name.text,
          gender: gender.text,
          number: phone.text,
          email: email.text));

      Navigator.push(
          context,
          PageTransition(
              child: const ContactInfo(),
              type: PageTransitionType.rightToLeft));
    }
  }
}
