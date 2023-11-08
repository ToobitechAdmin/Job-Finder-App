import 'package:flutter/cupertino.dart';
import 'package:job_finder/src/components/constext.dart';
import 'package:job_finder/src/helpers/color.dart';
import 'package:job_finder/src/helpers/spacer.dart';
import 'package:percent_indicator/percent_indicator.dart';

Widget progressviewer(double value1, String title, String subtitle) {
  return TweenAnimationBuilder<double>(
    tween: Tween<double>(begin: 0.0, end: value1 * 20 / 100),
    duration: const Duration(milliseconds: 3500),
    builder: (context, value, _) => Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 3.4,
          child: CircularPercentIndicator(
            radius: 35.0,
            lineWidth: 10.0,
            percent: value,
            center: boldtext(color.btnbg, 14, '$value1'),
            progressColor: color.btnbg,
          ),
        ),
        Column(
          children: [
            vertical(10),
            boldtext(const Color(0xff929BB0), 12, title),
            vertical(5),
            regulartext(const Color(0xff929BB0), 12, subtitle)
          ],
        ),
      ],
    ),
  );
}
