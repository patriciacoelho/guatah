import 'package:flutter/material.dart';
import 'package:guatah/constants/colors.dart';
import 'package:guatah/widgets/custom_app_bar.dart';
import 'package:guatah/widgets/custom_navigation_bar.dart';
import 'package:ionicons/ionicons.dart';

class TaggedsPage extends StatefulWidget {
  @override
  _TaggedsPageState createState() => _TaggedsPageState();
}

class _TaggedsPageState extends State<TaggedsPage> {
  var pageIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(rightIcon: Ionicons.person_circle, noBackNavigation: true),
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Os lugares que já conheceu e as viagens que quer ir!',
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