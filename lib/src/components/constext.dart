import 'package:flutter/cupertino.dart';

Widget boldtext(Color tcolor, double tsize, String text) {
  return Text(
    text,
    style:
        TextStyle(color: tcolor, fontSize: tsize, fontWeight: FontWeight.bold),
  );
}

Widget regulartext(Color tcolor, double tsize, String text, {bool? center}) {
  return Text(
    text,
    textAlign: (center == true) ? TextAlign.center : TextAlign.left,
    style:
        TextStyle(color: tcolor, fontSize: tsize, fontWeight: FontWeight.w600),
  );
}

Widget mediumtext(Color tcolor, double tsize, String text) {
  return Text(
    text,
    style:
        TextStyle(color: tcolor, fontSize: tsize, fontWeight: FontWeight.w500),
  );
}
