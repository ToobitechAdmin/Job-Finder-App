import 'package:flutter/material.dart';
import 'package:job_finder/src/helpers/color.dart';

Widget buttonmain(
    VoidCallback ontap, Color bgcolor, double width, Widget child, context) {
  return InkWell(
    onTap: ontap,
    child: Container(
      width: MediaQuery.of(context).size.width * width,
      height: 45,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25), color: bgcolor),
      child: Center(child: child),
    ),
  );
}

Widget buttonback(context) {
  return InkWell(
      onTap: (() {
        Navigator.of(context).pop();
      }),
      child: Image.asset('assets/images/icons/backarrow.png'));
}

Widget buttontransparent(
    VoidCallback ontap, double width, Widget child, context) {
  return InkWell(
    onTap: ontap,
    child: Container(
      width: MediaQuery.of(context).size.width * width,
      height: 45,
      decoration: BoxDecoration(
          border: Border.all(width: 2, color: color.textcolor),
          borderRadius: BorderRadius.circular(25),
          color: Colors.transparent),
      child: Center(child: child),
    ),
  );
}
