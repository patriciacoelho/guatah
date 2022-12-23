import 'package:flutter/material.dart';
import 'package:guatah/constants/colors.dart';
import 'package:guatah/screens/discovery/discovery.dart';
import 'package:guatah/screens/home/home.dart';
import 'package:guatah/screens/settings/settings.dart';
import 'package:guatah/screens/taggeds/taggeds.dart';
import 'package:ionicons/ionicons.dart';

class CustomNavigationBar extends StatelessWidget {
  final int current;

  CustomNavigationBar( {Key? key, required this.current}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var pageIndex = current;

    return BottomNavigationBar(
      elevation: 0,
      iconSize: 24,
      showSelectedLabels: false,
      backgroundColor: Colors.white,
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.black,
      onTap: (value) {
        pageIndex = value;
        var pages = [
          HomePage(),
          DiscoveryPage(),
          TaggedsPage(),
          SettingsPage()
        ];
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => pages[pageIndex]),
        );
      },
      items: [
        BottomNavigationBarItem(
          icon: BottomNavigationIcon(
            pageIndex == 0 ? Ionicons.home : Ionicons.home_outline,
            isActive: pageIndex == 0,
          ),
          label: 'Home',
          backgroundColor: Colors.white,
        ),
        BottomNavigationBarItem(
          icon: BottomNavigationIcon(
            pageIndex == 1 ? Ionicons.compass : Ionicons.compass_outline,
            isActive: pageIndex == 1,
          ),
          label: 'Explorar',
          backgroundColor: Colors.white,
        ),
        BottomNavigationBarItem(
          icon: BottomNavigationIcon(
            pageIndex == 2 ? Ionicons.bookmark : Ionicons.bookmark_outline,
            isActive: pageIndex == 2,
          ),
          // activeIcon: BottomNavigationIcon(
          //   pageIndex == 2 ? Ionicons.bookmark : Ionicons.bookmark_outline,
          //   isActive: pageIndex == 2,
          // ),
          label: 'Marcados',
          backgroundColor: Colors.white,
        ),
        BottomNavigationBarItem(
          icon: BottomNavigationIcon(
            pageIndex == 3 ? Ionicons.settings : Ionicons.settings_outline,
            isActive: pageIndex == 3,
          ),
          label: 'Configurações',
          backgroundColor: Colors.white,
        ),
      ],
    );
  }
}

class BottomNavigationIcon extends StatelessWidget {
  final IconData icon;
  final bool isActive;

  const BottomNavigationIcon(this.icon, { Key? key, this.isActive = false }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Icon(
        icon,
        color: isActive ? primaryColor : Colors.black,
      )
    );
  }
}
