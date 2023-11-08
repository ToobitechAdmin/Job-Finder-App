import 'package:flutter/material.dart';
import 'package:job_finder/src/components/appbar.dart';
import 'package:job_finder/src/components/constext.dart';
import 'package:job_finder/src/helpers/color.dart';
import 'package:job_finder/src/helpers/decoration.dart';
import 'package:job_finder/src/helpers/spacer.dart';
import 'package:job_finder/src/screens/drawerscreens/drawer.dart';
import 'package:job_finder/src/screens/homepage/home.dart';
import 'package:job_finder/src/services/databse/sqflite_services.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
        text: 'Profile',
      ),
      drawer: drawer(context),
      body: Container(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 80, bottom: 55),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: bgdecor,
          child: SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                profile(main: true),
                const Divider(
                  color: Colors.grey,
                  thickness: 3,
                ),
                vertical(10),
                boldtext(color.textcolor, 22, 'Qualifications'),
                dataView(provider.qualificationslist),
                vertical(15),
                boldtext(color.textcolor, 22, 'Experiance'),
                (provider.experiancelist.isEmpty)
                    ? boldtext(color.textcolor, 14, 'FRESH')
                    : dataView(provider.experiancelist, exp: true),
                vertical(15),
                boldtext(color.textcolor, 22, 'Skills'),
                dataView(provider.skillslist, skills: true),
              ],
            ),
          )),
    );
  }
}

// Widget containerdata(Color color, String text, BoxDecoration decor) {
//   return Container(
//       padding: EdgeInsets.symmetric(vertical: 13, horizontal: 20),
//       decoration: decor,
//       child: boldtext(Color(0xff526480), 18, 'Skills'));
// }

Widget dataView(dynamic data,
    {bool? skills, bool? exp, bool? edit, VoidCallback? ontap}) {
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
                            onTap: ontap,
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
                                onTap: ontap,
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
