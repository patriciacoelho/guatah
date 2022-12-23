
import 'package:flutter/material.dart';
import 'package:guatah/constants/colors.dart';
import 'package:guatah/widgets/custom_app_bar.dart';
import 'package:guatah/widgets/custom_input.dart';
import 'package:guatah/widgets/custom_navigation_bar.dart';
import 'package:ionicons/ionicons.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var pageIndex = 0;

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
            Container(
              padding: EdgeInsets.all(8),
              child: const Text(
                'Vamos conhecer novos lugares!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const CustomInput(
              searchType: true,
              hintText: 'Buscar lugares',
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(current: pageIndex),
    );
  }
}
