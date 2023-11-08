import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:job_finder/src/components/appbar.dart';
import 'package:job_finder/src/components/button.dart';
import 'package:job_finder/src/components/constext.dart';
import 'package:job_finder/src/screens/drawerscreens/drawer.dart';
import 'package:job_finder/src/components/progressviewer.dart';
import 'package:job_finder/src/helpers/color.dart';
import 'package:job_finder/src/helpers/decoration.dart';
import 'package:job_finder/src/helpers/spacer.dart';
import 'package:job_finder/src/screens/joblisting/joblisting.dart';
import 'package:job_finder/src/services/databse/classmodel_database/personalinfocm.dart';
import 'package:job_finder/src/services/databse/sqflite_services.dart';
import 'package:job_finder/src/utils/packagescard/cvtoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int page = 0;
  double value1 = 4.5;
  double value2 = 4.0;
  double value3 = 4.2;
  double value4 = 3.8;
  double value5 = 4.8;
  double value6 = 4.6;
  PageController controller = PageController();

  DateTime prebackpress = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final timegap = DateTime.now().difference(prebackpress);
        final cantExit = timegap >= const Duration(seconds: 2);
        prebackpress = DateTime.now();
        if (cantExit) {
          fluttertoast('Press Back button again to Exit', context, red: true);
          return false;
        } else {
          return await SystemChannels.platform
              .invokeMethod('SystemNavigator.pop');
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        key: _scaffoldKey,
        appBar: Appbar(
          globalKey: _scaffoldKey,
          text: '',
          main: true,
        ),
        drawer: drawer(context),
        body: Container(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 60, bottom: 55),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: bgdecor,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // vertical(50),
                // Row(
                //   children: [
                //     Icon(
                //       Icons.location_on,
                //       color: color.textcolor,
                //     ),
                //     horizental(10),
                //     boldtext(color.textcolor, 14, 'Florida , USA')
                //   ],
                // ),
                profile(),
                const Divider(
                  color: Colors.grey,
                  thickness: 3,
                ),
                vertical(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    progressviewer(value1, 'Jobs Applied', '100 Review'),
                    progressviewer(value2, 'Application Accepted', '50 Review'),
                    progressviewer(2.0, 'Application Rejected', '40 Review'),
                  ],
                ),
                vertical(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    progressviewer(value4, 'Ux Designer', '100 Review'),
                    progressviewer(value5, 'Research', '50 Review'),
                    progressviewer(value6, 'Ui Designer', '40 Review'),
                  ],
                ),
                vertical(20),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  child: PageView.builder(
                      controller: controller,
                      itemCount: images.length,
                      onPageChanged: (value) {
                        setState(() {
                          page = value;
                        });
                      },
                      itemBuilder: (context, pageindex) {
                        return Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                      image: AssetImage(images[pageindex]),
                                      fit: BoxFit.cover)),
                            ),
                          ],
                        );
                      }),
                ),
                dots(context, page),
                vertical(15),
                buttonmain(() {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: JobListing(), type: PageTransitionType.fade));
                }, color.btnbg, 1, boldtext(color.btntext, 18, 'Find Jobs'),
                    context)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class profile extends StatefulWidget {
  bool? main;
  profile({super.key, this.main});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  String? imgpath;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DataBaseState>(context, listen: true);
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: (widget.main == true) ? 120 : 100,
      child: Row(
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: CircleAvatar(
              radius: 35,
              backgroundColor: Colors.black,
              backgroundImage: (localimgpath == null)
                  ? const AssetImage('assets/images/icons/profileperson.png')
                  : FileImage(File(localimgpath.toString())) as ImageProvider,
            ),
          ),
          horizental(10),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                boldtext(color.textcolor, 18,
                    provider.personalinfolist[0].fullname.toString()),
                regulartext(color.textcolor, 12,
                    provider.qualificationslist[0].uniname.toString()),
                regulartext(color.textcolor, 12,
                    provider.contactlist[0].address.toString()),
                widget.main == true
                    ? regulartext(color.textcolor, 12,
                        provider.personalinfolist[0].number.toString())
                    : const SizedBox.shrink(),
                widget.main == true
                    ? regulartext(color.textcolor, 12,
                        provider.personalinfolist[0].email.toString())
                    : const SizedBox.shrink(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

List images = [
  'assets/images/img1.jpg',
  'assets/images/img2.jpg',
  'assets/images/img3.jpg',
];

Widget dots(context, int value) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    height: 50,
    child: Center(
      child: ListView.builder(
        itemCount: 3,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.all(5),
            width: 15,
            height: 15,
            decoration: BoxDecoration(
                color: (index == value) ? color.btnbg : const Color(0xff272727),
                shape: BoxShape.circle,
                border: Border.all(width: 2, color: const Color(0xff707070))),
          );
        },
      ),
    ),
  );
}
