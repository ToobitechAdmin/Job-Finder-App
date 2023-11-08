import 'package:flutter/material.dart';
import 'package:job_finder/src/components/button.dart';
import 'package:job_finder/src/components/constext.dart';
import 'package:job_finder/src/components/cvindicators.dart';
import 'package:job_finder/src/helpers/color.dart';
import 'package:job_finder/src/helpers/decoration.dart';
import 'package:job_finder/src/helpers/spacer.dart';
import 'package:job_finder/src/screens/createcv/qualifications.dart';
import 'package:job_finder/src/services/databse/classmodel_database/contactcm.dart';
import 'package:job_finder/src/services/databse/classmodel_database/personalinfocm.dart';
import 'package:job_finder/src/services/databse/sqflite_services.dart';
import 'package:job_finder/src/utils/packagescard/cvtoast.dart';
import 'package:page_transition/page_transition.dart';

class ContactInfo extends StatefulWidget {
  const ContactInfo({super.key});

  @override
  State<ContactInfo> createState() => _ContactInfoState();
}

class _ContactInfoState extends State<ContactInfo> {
  final TextEditingController address = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController state = TextEditingController();
  final TextEditingController postalcode = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: bgdecor,
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.92),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                vertical(30),
                buttonback(context),
                vertical(35),
                boldtext(color.textcolor, 30, 'Create Your CV'),
                vertical(40),
                mediumtext(color.textcolor, 22, 'Contact Information'),
                vertical(15),
                textarea(
                  'Address',
                  address,
                ),
                vertical(15),
                textarea('City', city),
                vertical(15),
                textarea(
                  'State',
                  state,
                ),
                vertical(15),
                textarea(
                  'Postal Code',
                  postalcode,
                ),
                const Spacer(),
                vertical(40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    horizental(0),
                    buttonmain(() {
                      checkdata();
                    },
                        color.btnbg,
                        0.4,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            boldtext(color.btntext, 18, 'Next'),
                            horizental(15),
                            Image.asset('assets/images/icons/forwardarrow.png')
                          ],
                        ),
                        context)
                  ],
                ),
                vertical(15),
                Center(child: boldtext(color.textcolor, 18, 'Step 2')),
                Center(child: CircularIndicator(value: 1)),
                vertical(25)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget textarea(
    String hint,
    TextEditingController controler,
  ) {
    return SizedBox(
      height: 60,
      child: TextFormField(
        style: textfieldtextstyle,
        controller: controler,
        decoration: InputDecoration(
            hintText: hint,
            hintStyle: textfieldtextstyle,
            contentPadding: const EdgeInsets.only(left: 25),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
            fillColor: color.textfieldbg),
      ),
    );
  }

  checkdata() {
    if (address.text.isEmpty ||
        city.text.isEmpty ||
        postalcode.text.isEmpty ||
        state.text.isEmpty) {
      fluttertoast('Please Fill All Fields', context, red: true);
    } else {
      insertcontact(ContactCM(
          address: address.text,
          city: city.text,
          state: state.text,
          postalcode: postalcode.text,
          email: useremail));

      Navigator.push(
          context,
          PageTransition(
              child: const Qualifications(),
              type: PageTransitionType.rightToLeft));
    }
  }
}
