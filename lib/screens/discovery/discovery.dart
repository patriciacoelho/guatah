import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:guatah/constants/colors.dart';
import 'package:guatah/models/itinerary.dart';
import 'package:guatah/services/remote_service.dart';
import 'package:guatah/widgets/calendar_list.dart';
import 'package:guatah/widgets/custom_app_bar.dart';
import 'package:guatah/widgets/custom_navigation_bar.dart';
import 'package:ionicons/ionicons.dart';

class DiscoveryPage extends StatefulWidget {
  @override
  _DiscoveryPageState createState() => _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage> {
  var pageIndex = 1;

  List<Itinerary>? calendarItems;
  bool loadingCalendarItems = true;

  @override
  void initState() {
    super.initState();
    getCalendarItems();
  }

  getCalendarItems() async {
    calendarItems = await RemoteService().getItineraries({ 'take': '4' });
    if (calendarItems != null) {
      log("debug message (calendar)", error: calendarItems);
      setState(() {
        loadingCalendarItems = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAppBar(
              noBackNavigation: true,
              rightWidget: Icon(
                Ionicons.person_circle,
                color: primaryColor,
                size: 48.0,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Encontre viagens por intervalo de data',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              child: !loadingCalendarItems && calendarItems != null ? CalendarList(items: calendarItems ?? []) : null,
            )
          ],
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(current: pageIndex),
    );
  }
}