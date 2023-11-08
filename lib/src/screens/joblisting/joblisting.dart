import 'package:flutter/material.dart';
import 'package:job_finder/src/components/alertDialog.dart';
import 'package:job_finder/src/components/appbar.dart';
import 'package:job_finder/src/components/constext.dart';
import 'package:job_finder/src/screens/drawerscreens/drawer.dart';
import 'package:job_finder/src/helpers/color.dart';
import 'package:job_finder/src/helpers/decoration.dart';
import 'package:job_finder/src/helpers/spacer.dart';
import 'package:job_finder/src/utils/classes/joblisting_C_M.dart';

class JobListing extends StatelessWidget {
  JobListing({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      key: _scaffoldKey,
      appBar: Appbar(
        globalKey: _scaffoldKey,
        text: 'Job Listing',
      ),
      drawer: drawer(context),
      body: Container(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 80, bottom: 40),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: bgdecor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(0),
                controller: ScrollController(),
                itemCount: joblist.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      jobalert(joblist[index], () {}, (() {}), context);
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 180,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 35,
                                backgroundImage: AssetImage(
                                    joblist[index].imgurl.toString()),
                              ),
                              horizental(10),
                              SizedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    boldtext(color.textcolor, 24,
                                        joblist[index].title.toString()),
                                    vertical(5),
                                    regulartext(color.textcolor, 12,
                                        joblist[index].subtitle.toString()),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.36,
                                child: ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: regulartext(color.textcolor, 12,
                                      'Job Type :${joblist[index].jobtype}'),
                                  subtitle: regulartext(color.textcolor, 12,
                                      'Shift :${joblist[index].shift}'),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.53,
                                child: ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: regulartext(color.textcolor, 12,
                                      'Location :${joblist[index].location}'),
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            color: Colors.grey,
                            thickness: 3,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
