import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:job_finder/src/components/appbar.dart';
import 'package:job_finder/src/components/button.dart';
import 'package:job_finder/src/components/constext.dart';
import 'package:job_finder/src/helpers/alertdialog.dart';
import 'package:job_finder/src/helpers/color.dart';
import 'package:job_finder/src/helpers/decoration.dart';
import 'package:job_finder/src/helpers/spacer.dart';
import 'package:job_finder/src/screens/drawerscreens/drawer.dart';
import 'package:job_finder/src/services/databse/classmodel_database/personalinfocm.dart';
import 'package:job_finder/src/services/databse/sqflite_services.dart';
import 'package:job_finder/src/utils/packagescard/cvtoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditCv extends StatefulWidget {
  const EditCv({super.key});

  @override
  State<EditCv> createState() => _EditCvState();
}

class _EditCvState extends State<EditCv> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  String? imgpath;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DataBaseState>(context, listen: true);
    return Scaffold(
      extendBodyBehindAppBar: true,
      key: _key,
      appBar: Appbar(
        globalKey: _key,
        text: 'Edit',
      ),
      drawer: drawer(context),
      body: Container(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 80, bottom: 55),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: bgdecor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.black,
                      backgroundImage: (localimgpath == null)
                          ? const AssetImage(
                              'assets/images/icons/profileperson.png')
                          : FileImage(File(localimgpath.toString()))
                              as ImageProvider,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () {
                          uploadphoto();
                        },
                        child: const CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.black,
                          child: Icon(
                            Icons.mode_edit_outline_rounded,
                            size: 17,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              vertical(15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  boldtext(color.textcolor, 14, 'Personal Information'),
                  InkWell(
                      onTap: () {
                        addMore([
                          provider.personalinfolist[0].fullname,
                          provider.personalinfolist[0].gender,
                          provider.personalinfolist[0].number,
                          provider.personalinfolist[0].email,
                        ], personalhint, '0', 'Personal Information');
                      },
                      child: Image.asset(
                        'assets/images/icons/edit.png',
                        height: 25,
                      ))
                ],
              ),
              vertical(15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  boldtext(color.textcolor, 14, 'Contact Information'),
                  InkWell(
                      onTap: () {
                        // addMore();
                        addMore([
                          provider.contactlist[0].address,
                          provider.contactlist[0].city,
                          provider.contactlist[0].state,
                          provider.contactlist[0].postalcode,
                        ], contacthint, '0', 'Contact Information');
                      },
                      child: Image.asset(
                        'assets/images/icons/edit.png',
                        height: 25,
                      ))
                ],
              ),
              vertical(10),
              boldtext(color.textcolor, 22, 'Qualifications'),
              dataView(provider.qualificationslist, edit: true),
              vertical(15),
              boldtext(color.textcolor, 22, 'Experiance'),
              (provider.experiancelist.isEmpty)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        boldtext(color.textcolor, 14, 'FRESH'),
                        InkWell(
                            onTap: () {
                              addMore([], experiancehint, 'fresh', 'Experiance',
                                  fresh: true);
                            },
                            child: Image.asset(
                              'assets/images/icons/edit.png',
                              height: 25,
                            ))
                      ],
                    )
                  : dataView(provider.experiancelist, exp: true, edit: true),
              vertical(15),
              boldtext(color.textcolor, 22, 'Skills'),
              dataView(provider.skillslist, skills: true, edit: true),
            ],
          ),
        ),
      ),
    );
  }

  //-----------------------------------------------------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------Add More------------------------------------------------
//-----------------------------------------------------------------------------------------------------------------------------------------

  addMore(dynamic data, List hint, String id, String title,
      {bool? skill, bool? fresh}) {
    final TextEditingController field1 = TextEditingController();
    final TextEditingController field2 = TextEditingController();
    final TextEditingController field3 = TextEditingController();
    final TextEditingController field4 = TextEditingController();
    bool addmore = fresh ?? false;

    if (fresh == true) {
    } else {
      field1.text = data[0];
      field2.text = data[1];
      field3.text = data[2];
      field4.text = data[3];
    }

    return showModalBottomSheet(
        backgroundColor: Colors.black.withOpacity(0.65),
        barrierColor: Colors.black.withOpacity(0.95),
        isScrollControlled: true,
        isDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, setState) {
              // print(addmore);
              return Container(
                padding: const EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.9,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)),
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/images/bg.png',
                        ),
                        fit: BoxFit.fill)),
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.82),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 80,
                          height: 5,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        vertical(20),
                        mediumtext(color.textcolor, 22, title),
                        vertical(15),
                        textarea(hint[0], field1, icon: true),
                        vertical(15),
                        (skill == true && addmore == false)
                            ? const SizedBox.shrink()
                            : textarea(hint[1], field2, icon: true),
                        vertical(15),
                        (skill == true && addmore == false)
                            ? const SizedBox.shrink()
                            : textarea(
                                hint[2],
                                field3,
                                icon: true, /*ontap: true */
                              ),
                        vertical(15),
                        (skill == true && addmore == false)
                            ? const SizedBox.shrink()
                            : textarea(
                                hint[3],
                                field4,
                                icon: true, /*ontap: true */
                              ),
                        vertical(25),
                        //----------------------------------------------------------------------------------------------------------------------------------------------------------
                        //---------------------------------------------------------------------------Buttons of bottom scroler------------------------------------------------------
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            (title == 'Personal Information' ||
                                    title == 'Contact Information')
                                ? const SizedBox()
                                : buttontransparent(() {
                                    setState(
                                      () {
                                        addmore = true;

                                        field1.clear();
                                        field2.clear();
                                        field3.clear();
                                        field4.clear();
                                      },
                                    );
                                    fluttertoast(
                                        'Please Fill All Fields', context,
                                        red: true);
                                  },
                                    0.4,
                                    boldtext(color.textcolor, 18, 'Add More'),
                                    context),
                            buttonmain(() {
                              (addmore == true)
                                  ? save(title)
                                  : update(title, int.parse(id));
                              field1.clear();
                              field2.clear();
                              field3.clear();
                              field4.clear();
                              // Navigator.pop(context);
                              FocusScope.of(context).unfocus();
                              showdialog(context, false);
                            },
                                color.btnbg,
                                0.4,
                                boldtext(color.btntext, 16,
                                    (addmore == true) ? 'Save' : 'Update'),
                                context)
                          ],
                        ),
                        vertical(100),
                        (addmore == true)
                            ? const SizedBox.shrink()
                            : CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.transparent,
                                child: Image.asset(
                                    'assets/images/icons/trash.png'))
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        });
  }

  //-----------------------------------------------------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------Upload photo------------------------------------------------
//-----------------------------------------------------------------------------------------------------------------------------------------

  uploadphoto() async {
    final prefs = await SharedPreferences.getInstance();
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    try {
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
    } catch (e) {
      print(e.toString());
    }
  }

//-----------------------------------------------------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------Year Dialog-------------------------------------------------------
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
//-----------------------------------------------------------------------Gender Selector------------------------------------------------
//-----------------------------------------------------------------------------------------------------------------------------------------
  genderbottom(TextEditingController controller) {
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
                    controller.text = 'MALE';
                  });
                  Navigator.pop(context);
                }, color.btnbg, 0.6, boldtext(color.btntext, 18, 'MALE'),
                    context),
                vertical(30),
                buttonmain(() {
                  this.setState(() {
                    controller.text = 'FEMALE';
                  });
                  Navigator.pop(context);
                }, color.btnbg, 0.6, boldtext(color.btntext, 18, 'FEMALE'),
                    context),
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
        readOnly: (hint == 'Toyear' || hint == 'Fromyear' || hint == 'Gender')
            ? true
            : false,
        onTap: () {
          if ((hint == 'Toyear') || (hint == 'Fromyear')) {
            pickYear(context, controler);
          } else if (hint == 'Gender') {
            genderbottom(controler);
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
//-------------------------------------------------------------------------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------Data View Card ---------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------------------------------------------------------------

  Widget dataView(dynamic data, {bool? skills, bool? exp, bool? edit}) {
    return ListView.builder(
        padding: const EdgeInsets.all(0),
        shrinkWrap: true,
        controller: ScrollController(),
        itemCount: data.length,
        itemBuilder: (context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: (skills == true)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      boldtext(color.textcolor, 14, '${data[index].skill}'),
                      (edit == true)
                          ? InkWell(
                              onTap: () {
                                addMore(
                                    [data[index].skill, '', '', ''],
                                    skillhint,
                                    data[index].id.toString(),
                                    'Skills',
                                    skill: true);
                              },
                              child: Image.asset(
                                'assets/images/icons/edit.png',
                                height: 25,
                              ))
                          : const SizedBox.shrink()
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          boldtext(
                              color.textcolor,
                              14,
                              (exp == true)
                                  ? '${data[index].jobtitle}'
                                  : '${data[index].uniname}'),
                          (edit == true)
                              ? InkWell(
                                  onTap: () {
                                    (exp == true)
                                        ? addMore([
                                            data[index].jobtitle,
                                            data[index].companyname,
                                            data[index].fromyear,
                                            data[index].toyear,
                                          ],
                                            experiancehint,
                                            data[index].id.toString(),
                                            'Experiance')
                                        : addMore([
                                            data[index].uniname,
                                            data[index].course,
                                            data[index].fromyear,
                                            data[index].toyear,
                                          ],
                                            qualificationthint,
                                            data[index].id.toString(),
                                            'Qualifications');
                                  },
                                  child: Image.asset(
                                    'assets/images/icons/edit.png',
                                    height: 25,
                                  ))
                              : const SizedBox.shrink()
                        ],
                      ),
                      vertical(5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          regulartext(
                              color.textcolor,
                              12,
                              (exp == true)
                                  ? '${data[index].companyname}'
                                  : '${data[index].course}'),
                          regulartext(color.textcolor, 12,
                              '${data[index].fromyear}-${data[index].toyear}'),
                        ],
                      )
                    ],
                  ),
          );
        });
  }

  save(String value1) {
    switch (value1) {
      case 'Qualifications':
        {
          print('Qualifications    Save');
        }
        break;
      case 'Experiance':
        {
          print('Experiance    Save');
        }
        break;
      case 'Skills':
        {
          print('Skills    Save');
        }
        break;
      default:
        {
          print(value1);
        }
        break;
    }
  }

  update(String value1, int id) {
    switch (value1) {
      case 'Personal Information':
        {
          print('Personal Information  $id  update');
        }
        break;
      case 'Contact Information':
        {
          print('Contact Information  $id  update');
        }
        break;
      case 'Qualifications':
        {
          print('Qualifications  $id  update');
        }
        break;
      case 'Experiance':
        {
          print('Experiance  $id   update');
        }
        break;
      case 'Skills':
        {
          print('Skills  $id   update');
        }
        break;
      default:
        {
          print(value1);
        }
        break;
    }
  }
}

List personalhint = ['Full Name', 'Gender', 'Phone', 'Email'];
List contacthint = ['Address', 'City', 'State', 'Postalcode'];
List qualificationthint = ['Uniname', 'Course', 'Fromyear', 'Toyear'];
List experiancehint = ['Jobtitle', 'Company Name', 'Fromyear', 'Toyear'];
List skillhint = ['Skill', 'Skill', 'Skill', 'Skill'];
