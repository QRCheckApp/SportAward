import 'package:dosport/pres/pages/home_page.dart';
import 'package:flutter/material.dart';

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
            IconButton(
              onPressed: () {
                showLicensePage(
                  context: context,
                  applicationName: "Junction23 \n © QrCheck & Hoang An Nguyen",
                );
              },
              icon: const Icon(Icons.settings),
            ),
          ],
        ),
        body: SafeArea(
          child: IndexedStack(
            index: index,
            children: [
              FriendsPage(),
              HomePage(),
              BadgePage(),
            ],
          ),
        ),
        bottomNavigationBar: MyBottomNav(changePage: changePage));
  }
}
