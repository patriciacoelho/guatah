import 'package:flutter/material.dart';
import 'package:guatah/constants/colors.dart';
import 'package:guatah/widgets/custom_app_bar.dart';
import 'package:guatah/widgets/custom_navigation_bar.dart';
import 'package:ionicons/ionicons.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var pageIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // CustomAppBar(Ionicons.bookmark_outline),
            CustomAppBar(rightIcon: Ionicons.person_circle, noBackNavigation: true),
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Página de Configurações',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(current: pageIndex),
    );
  }
}