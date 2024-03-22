
import 'package:chatapp/favList/favList.dart';
import 'package:chatapp/profile/ProfileImage/findpplz.dart';
import 'package:chatapp/theme/themeProvider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../MyHomePage.dart';
import '../profile/profilemenu.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  Color? colorBar = Colors.brown.shade700;
  static const iconlist = <IconData>[
    Icons.home,
    Icons.add_location_sharp,
    Icons.zoom_in_outlined,
    Icons.add_location_sharp,
  ];

  final List _pages = [
    Finpplz(),
    const MyHomePage(),
    FavList(),
    const ProfileMenu(),
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (BuildContext context, themeprovider,_) {
  return Scaffold(
    bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.grey.shade800,
        color: themeprovider.themedata.bottomAppBarColor,
        animationCurve: Curves.easeOutCubic,
        animationDuration: Duration(milliseconds: 500.toInt()),
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const <Widget>[
          Icon(
            Icons.home,
            size: 25,
          ),
          Icon(
            Icons.chat,
            size: 25,
          ),
          Icon(
            Icons.favorite_border,
            size: 25,
          ),
          Icon(
            Icons.settings,
            size: 25,
          )
        ]),
    body: _pages[_selectedIndex],
  );
      },
    );
  }
}
