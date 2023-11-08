// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:job_finder/src/components/button.dart';
import 'package:job_finder/src/components/constext.dart';
import 'package:job_finder/src/helpers/color.dart';
import 'package:job_finder/src/helpers/spacer.dart';

jobalert(dynamic data, VoidCallback viewpost, VoidCallback apply, context) {
  showDialog(
    context: context,
    builder: (context) {
      final Size size = MediaQuery.of(context).size;
      return AlertDialog(
        backgroundColor: const Color(0xff151414),
        title: Center(child: boldtext(color.textcolor, 22, data.title)),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        content: SizedBox(
          height: size.height / 4.2,
          width: size.width,
          child: Column(
            children: [
              boldtext(color.btnbg, 14, data.subtitle),
              vertical(10),
              regulartext(color.textcolor, 14,
                  'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. ',
                  center: true),
              vertical(10),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buttonmain(apply, color.btnbg, 0.3,
                      boldtext(color.btntext, 14, 'Apply Now'), context),
                  buttontransparent(viewpost, 0.3,
                      boldtext(color.textcolor, 14, 'View Post'), context)
                ],
              )
            ],
          ),
        ),
      );
    },
  );

  // showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         backgroundColor: const Color(0xff151414),
  //         title: boldtext(color.textcolor, 18, 'Title'),
  // content: Column(
  //   children: [
  //     boldtext(color.btnbg, 14, 'sub title'),
  //     vertical(10),
  //     regulartext(color.btnbg, 14, 'sub title'),
  //     vertical(10),
  //     Row(
  //       children: [
  //         buttonmain(apply, color.btnbg, 0.3,
  //             boldtext(color.btntext, 14, 'Apply Now'), context),
  //         buttontransparent(viewpost, 0.3,
  //             boldtext(color.textcolor, 14, 'View Post'), context)
  //       ],
  //     )
  //   ],
  // ),
  //       );
  //     });
}
