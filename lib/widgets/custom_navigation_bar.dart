import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
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

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(42.0, 8.0, 42.0, 12.0),
      child: GNav(
        duration: const Duration(milliseconds: 900),
        gap: 8.0,
        iconSize: 20.0,
        backgroundColor: Colors.white,
        color: mediumGreyColor,
        activeColor: Colors.white,
        tabBackgroundColor: primaryColor,
        tabBorderRadius: 8.0, 
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        selectedIndex: current,
        onTabChange: (value) {
          pageIndex = value;
          var pages = [
            const HomePage(),
            const DiscoveryPage(),
            const TaggedsPage(),
            SettingsPage()
          ];
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => pages[pageIndex]),
          );
        },
        tabs: [
          GButton(
            icon: pageIndex == 0 ? Ionicons.home : Ionicons.home_outline,
            text: 'Home',
          ),
          GButton(
            icon: pageIndex == 1 ? Ionicons.compass : Ionicons.compass_outline,
            text: 'Explorar',
          ),
          GButton(
            icon: pageIndex == 2 ? Ionicons.bookmark : Ionicons.bookmark_outline,
            text: 'Marcados',
          ),
          // GButton(
          //   icon: pageIndex == 3 ? Ionicons.settings : Ionicons.settings_outline,
          //   text: 'Configurações',
          // ),
        ],
      ),
    );
  }
}

class BottomNavigationIcon extends StatelessWidget {
  final IconData icon;
  final bool isActive;

  const BottomNavigationIcon(this.icon, { Key? key, this.isActive = false }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: isActive ? primaryColor : Colors.black,
    );
  }
}
