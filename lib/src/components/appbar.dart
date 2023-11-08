// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:job_finder/src/components/button.dart';
import 'package:job_finder/src/components/constext.dart';
import 'package:job_finder/src/helpers/color.dart';
import 'package:job_finder/src/helpers/spacer.dart';
import 'package:job_finder/src/screens/createcv/editcv.dart';

class Appbar extends StatelessWidget implements PreferredSizeWidget {
  GlobalKey<ScaffoldState> globalKey;
  String text;
  bool? main;
  Appbar({super.key, required this.globalKey, required this.text, this.main});
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(MediaQuery.of(context).size.width, 300),
      child: AppBar(
        toolbarHeight: 300,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              (main == true) ? const SizedBox.shrink() : buttonback(context),
              const Spacer(),
              boldtext(color.textcolor, 25, text),
              const Spacer(),
              (main == true)
                  ? InkWell(
                      onTap: (() {}),
                      child: Icon(
                        Icons.notifications,
                        color: color.textcolor,
                      ))
                  : const SizedBox.shrink(),
              (text == 'Profile')
                  ? InkWell(
                      onTap: (() {
                        Navigator.push(
                            context,
                            (MaterialPageRoute(
                                builder: (context) => const EditCv())));
                      }),
                      child: Image.asset('assets/images/icons/edit.png'))
                  : const SizedBox.shrink(),
              horizental(15),
              InkWell(
                  onTap: (() {
                    globalKey.currentState!.openDrawer();
                  }),
                  child: Image.asset('assets/images/icons/menu.png')),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(75);
}
