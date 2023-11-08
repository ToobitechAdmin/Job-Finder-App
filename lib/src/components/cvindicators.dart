// ignore_for_file: must_be_immutable

import 'package:flutter/widgets.dart';
import 'package:job_finder/src/helpers/color.dart';

class CircularIndicator extends StatelessWidget {
  int value;
  CircularIndicator({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: MediaQuery.of(context).size.width * 0.6,
      height: 50,
      child: ListView.builder(
        itemCount: 5,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.all(5),
            width: 20,
            height: 20,
            decoration: BoxDecoration(
                color: (index <= value) ? color.btnbg : const Color(0xff272727),
                shape: BoxShape.circle,
                border: Border.all(width: 2, color: const Color(0xff707070))),
          );
        },
      ),
    );
  }
}
