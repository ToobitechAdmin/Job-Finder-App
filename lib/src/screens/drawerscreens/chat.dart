// ignore_for_file: avoid_print

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:job_finder/src/components/appbar.dart';
import 'package:job_finder/src/components/constext.dart';
import 'package:job_finder/src/helpers/color.dart';
import 'package:job_finder/src/screens/drawerscreens/drawer.dart';
import 'package:job_finder/src/helpers/decoration.dart';
import 'package:job_finder/src/helpers/spacer.dart';
import 'package:job_finder/src/screens/drawerscreens/drawer_utils/chatbox.dart';
import 'package:job_finder/src/utils/classes/chat_C_M.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    try {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      });
    } catch (e) {
      print(e.toString());
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      key: _scaffoldKey,
      appBar: Appbar(
        globalKey: _scaffoldKey,
        text: 'Steve',
      ),
      drawer: drawer(context),
      body: Stack(
        children: [
          Container(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 80, bottom: 40),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: bgdecor,
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // vertical(40),
                    ListView.builder(
                      itemCount: chatlist.length,
                      dragStartBehavior: DragStartBehavior.start,
                      padding: const EdgeInsets.all(0),
                      shrinkWrap: true,
                      controller: ScrollController(),
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          children: [
                            (chatlist[index].id != 'receiver')
                                ? statusview(chatlist[index].status.toString(),
                                    chatlist[index].time.toString(), context)
                                : const SizedBox.shrink(),
                            Align(
                              alignment: (chatlist[index].id == 'receiver')
                                  ? Alignment.centerLeft
                                  : Alignment.centerRight,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.77,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                child: Stack(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          left:
                                              (chatlist[index].id == 'receiver')
                                                  ? 35
                                                  : 0,
                                          bottom: 15,
                                          right:
                                              (chatlist[index].id == 'receiver')
                                                  ? 0
                                                  : 35),
                                      padding: const EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                          color: const Color(0xff313131),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      // width: 100,
                                      // height: 40,
                                      child: regulartext(color.textcolor, 12,
                                          chatlist[index].message.toString()),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: (chatlist[index].id == 'receiver')
                                          ? null
                                          : 0,
                                      child: CircleAvatar(
                                        radius:
                                            MediaQuery.of(context).size.width *
                                                0.06,
                                        backgroundImage: AssetImage(
                                            chatlist[index].imgurl.toString()),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            (chatlist[index].id == 'receiver')
                                ? statusview(chatlist[index].status.toString(),
                                    chatlist[index].time.toString(), context)
                                : const SizedBox.shrink(),
                          ],
                        );
                      },
                    ),
                    vertical(90)
                  ],
                ),
              )),
          Align(alignment: Alignment.bottomCenter, child: ChatBox())
        ],
      ),
    );
  }
}
