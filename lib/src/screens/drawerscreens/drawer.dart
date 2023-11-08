import 'package:flutter/material.dart';
import 'package:job_finder/src/components/button.dart';
import 'package:job_finder/src/components/constext.dart';
import 'package:job_finder/src/helpers/color.dart';
import 'package:job_finder/src/helpers/decoration.dart';
import 'package:job_finder/src/helpers/spacer.dart';
import 'package:job_finder/src/screens/drawerscreens/chat.dart';
import 'package:job_finder/src/screens/drawerscreens/profile.dart';
import 'package:job_finder/src/screens/userauth/login.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget drawer(context) {
  return Drawer(
    child: Container(
      decoration: bgdecor,
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          vertical(50),
          ListTile(
            leading: buttonback(context),
          ),
          ListTile(
            leading: Image.asset('assets/images/icons/profile.png'),
            title: boldtext(color.textcolor, 16, 'Profile'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  PageTransition(
                      child: Profile(), type: PageTransitionType.fade));
            },
          ),
          const Divider(
            color: Colors.grey,
            thickness: 3,
          ),
          ListTile(
            leading: Image.asset('assets/images/icons/settings.png'),
            title: boldtext(color.textcolor, 16, 'Settings'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Divider(
            color: Colors.grey,
            thickness: 3,
          ),
          ListTile(
            leading: Image.asset('assets/images/icons/chat.png'),
            title: boldtext(color.textcolor, 16, 'Chat'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  PageTransition(
                      child: const Chat(), type: PageTransitionType.fade));
            },
          ),
          const Divider(
            color: Colors.grey,
            thickness: 3,
          ),
          ListTile(
            leading: Icon(
              Icons.notifications_none_outlined,
              color: color.textcolor,
            ),
            title: boldtext(color.textcolor, 16, 'Notifications'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Divider(
            color: Colors.grey,
            thickness: 3,
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: color.textcolor,
            ),
            title: boldtext(color.textcolor, 16, 'Logout'),
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.setBool('login', false);
              prefs.remove('email');
              Navigator.push(
                  context,
                  PageTransition(
                      child: const SignIn(), type: PageTransitionType.fade));
            },
          ),
          const Divider(
            color: Colors.grey,
            thickness: 3,
          ),
        ],
      ),
    ),
  );
}
