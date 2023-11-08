// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:job_finder/src/components/constext.dart';
import 'package:job_finder/src/helpers/color.dart';
import 'package:job_finder/src/helpers/spacer.dart';

class ChatBox extends StatelessWidget {
  ChatBox({super.key});

  TextEditingController chat = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        // margin: EdgeInsets.only(left: 20, right: 20, bottom: 15),
        padding: const EdgeInsets.only(left: 15),
        height: 65,
        decoration: BoxDecoration(
            color: const Color(0xff313131),
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: TextFormField(
                controller: chat,
                style: TextStyle(
                    color: color.textcolor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
                maxLines: 2,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                        color: color.textcolor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                    hintText: 'Enter Text Here .....'),
              ),
            ),
            Expanded(child: Image.asset('assets/images/icons/send.png'))
          ],
        ),
      ),
    );
  }
}

Widget statusview(String status, String time, context) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.12,
    child: Column(
      children: [
        (status == 'seen')
            ? Image.asset(
                'assets/images/icons/seen.png',
                width: 15,
              )
            : (status == 'delivered')
                ? Image.asset(
                    'assets/images/icons/delivered.png',
                    width: 15,
                  )
                : Image.asset(
                    'assets/images/icons/sent.png',
                    width: 15,
                  ),
        vertical(5),
        boldtext(color.textcolor, 10, time)
      ],
    ),
  );
}
