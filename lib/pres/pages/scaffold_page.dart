import 'dart:math';

import 'package:dosport/pres/pages/home_page.dart';
import 'package:flutter/material.dart';

import '../../data/data.dart';
import '../../style.dart';
import '../widgets/bottom_nav.dart';
import 'badges_page.dart';
import 'friends_page.dart';

class ScaffoldPage extends StatefulWidget {
  const ScaffoldPage({super.key});

  @override
  State<ScaffoldPage> createState() => _ScaffoldPageState();
}

class _ScaffoldPageState extends State<ScaffoldPage> {
  int index = 1;
  List<String> titles = ['Your Friends', 'SportAward', 'Your Badges'];

  void changePage(int newIndex) {
    setState(() {
      index = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: SCol.background,
          title: Text(titles[index]),
          actions: [
            GestureDetector(
              onLongPress: () {
                // open a dialog to config the stepSwitch

                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Step Switch"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SwitchListTile(
                              title: const Text("Step Switch"),
                              value: Data.stepSwitch,
                              onChanged: (value) {
                                Data.stepSwitch = value;
                                if (Data.stepSwitch == true) {
                                  // Round to the nearest 100
                                  Data.stepAmount =
                                      (Data.stepAmount / 100).round() * 100;
                                } else {
                                  // add random number between 1 and 100
                                  Data.stepAmount +=
                                      (1 + Random().nextInt(100 - 1));
                                }
                                this.setState(() {});
                              },
                            ),
                            Text("Step Amount: ${Data.stepAmount}"),
                            Text("Step Switch: ${Data.stepSwitch}"),
                          ],
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("Close"))
                        ],
                      );
                    });
                setState(() {});
              },
              child: IconButton(
                onPressed: () {
                  showLicensePage(
                    context: context,
                    applicationName:
                        "Junction23 \n © QrCheck & Hoang An Nguyen",
                  );
                },
                icon: const Icon(Icons.settings),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: IndexedStack(
            index: index,
            children: [
              const FriendsPage(),
              const HomePage(),
              BadgePage(),
            ],
          ),
        ),
        bottomNavigationBar: MyBottomNav(changePage: changePage));
  }
}
