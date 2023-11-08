import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:job_finder/src/helpers/color.dart';

fluttertoast(String msg, context, {bool? red, bool? top}) async {
  return showToast(msg,
      context: context,
      animation: StyledToastAnimation.slideFromBottom,
      textAlign: TextAlign.center,
      textStyle: const TextStyle(color: Color(0xff151414)),
      reverseAnimation: StyledToastAnimation.fade,
      position: (top == true)
          ? StyledToastPosition.center
          : StyledToastPosition.bottom,
      animDuration: const Duration(seconds: 2),
      duration: const Duration(seconds: 6),
      curve: Curves.elasticOut,
      reverseCurve: Curves.linear,
      backgroundColor: (red == true) ? Colors.red : color.btnbg);
}
