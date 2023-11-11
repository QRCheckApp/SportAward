import 'dart:io';

import 'package:flutter/material.dart';

import '../../style.dart';
import 'bottom_nav/my_curved_nav_bar.dart';

class MyBottomNav extends StatelessWidget {
  final Function changePage;
  final double iconSize = 40;

  const MyBottomNav({super.key, required this.changePage});

  @override
  Widget build(BuildContext context) {
    return MyCurvedNavigationBar(
      height: Platform.isIOS ? 75 : 70,
      index: 1,
      backgroundColor: Colors.transparent,
      color: SCol.secondary,
      buttonBackgroundColor: SCol.primary,
      items: <Widget>[
        Icon(Icons.groups_rounded, size: iconSize),
        Icon(Icons.home_rounded, size: iconSize),
        Icon(Icons.emoji_events_rounded, size: iconSize),
      ],
      onTap: (index) => changePage(index),
    );
  }
}
