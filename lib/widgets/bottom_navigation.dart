import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:flutter/material.dart';
import 'package:hogo_app/screen/forumScreen.dart';
import 'package:hogo_app/screen/profile.dart';
import 'package:hogo_app/screen/slide_screen.dart';
import 'package:hogo_app/utils/theme/app_colors.dart';

import '../screen/home_page_screen.dart';

class BottomNavigator extends StatefulWidget {
  static const roudName = "BottomNavigatorScreen";
  const BottomNavigator({Key? key}) : super(key: key);

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int _page = 0;

  List pages = [
    SliderScreen(),
    forumScreen(),
    const profile(),
  ];

  void navegate(int index) {
    setState(() {
      _page = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: AppColors.scadryColor,
        items: const <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.chat, size: 30),
          Icon(Icons.person, size: 30),
        ],
        onTap: (index) {
          navegate(index);
        },
      ),
      body: pages[_page],
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
