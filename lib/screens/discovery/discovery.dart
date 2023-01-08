import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:guatah/constants/colors.dart';
import 'package:guatah/models/itinerary.dart';
import 'package:guatah/services/remote_service.dart';
import 'package:guatah/widgets/calendar_list.dart';
import 'package:guatah/widgets/custom_navigation_bar.dart';
import 'package:guatah/widgets/list_item.dart';

class DiscoveryPage extends StatefulWidget {
  @override
  _DiscoveryPageState createState() => _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage> {
  var pageIndex = 1;

  List<Itinerary>? calendarItems;
  List<Itinerary>? dreamTrips;
  bool loadingCalendarItems = true;
  bool loadingDreamTrips = true;

  @override
  void initState() {
    super.initState();
    getCalendarItems();
    getDreamTrips();
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

  getDreamTrips() async {
    dreamTrips = await RemoteService().getItineraries({ 'take': '2', 'desc_order_by': 'price' });
    if (dreamTrips != null) {
      log("debug message (dream trip)", error: dreamTrips);
      setState(() {
        loadingDreamTrips = false;
      });
    }
  }

  Widget getDreamTripsWidget()
  {
    List<Widget> list = <Widget>[];

    for (var i = 0; i < dreamTrips!.length; i++) {
      list.add(
        Container(
          padding: const EdgeInsets.only(right: 8.0),
          child: ListItem(
            id: dreamTrips![i].id,
            title: dreamTrips![i].trip_name,
            secondaryInfo: dreamTrips![i].operator_name,
            extraInfo: '${dreamTrips![i].date} • ${dreamTrips![i].classification}',
            imageUrl: dreamTrips![i].image_url,
          ),
        ),
      );
    }

    return Column(children: list);
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
            ),
            Container(
              child: !loadingDreamTrips ?
                getDreamTripsWidget()
                : const Text('Nenhum encontrado'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(current: pageIndex),
    );
  }
}