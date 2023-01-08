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
  List<Itinerary>? cheapTrips;
  List<Itinerary>? ecotourismTrips;
  bool loadingCalendarItems = true;
  bool loadingDreamTrips = true;
  bool loadingCheapTrips = true;
  bool loadingEcotourismTrips = true;

  @override
  void initState() {
    super.initState();
    getCheapTrips();
    getCalendarItems();
    getDreamTrips();
    getEcotourismTrips();
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

  getCheapTrips() async {
    cheapTrips = await RemoteService().getItineraries({ 'take': '2', 'asc_order_by': 'price' });
    if (cheapTrips != null) {
      log("debug message (cheap trip)", error: cheapTrips);
      setState(() {
        loadingCheapTrips = false;
      });
    }
  }

  getEcotourismTrips() async {
    ecotourismTrips = await RemoteService().getItineraries({ 'take': '2', 'categories': ['6347eb2f7f395d1606e2ccd2'] });
    if (ecotourismTrips != null) {
      log("debug message (ecotourism trip)", error: ecotourismTrips);
      setState(() {
        loadingEcotourismTrips = false;
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

  Widget getCheapTripsWidget()
  {
    List<Widget> list = <Widget>[];

    for (var i = 0; i < cheapTrips!.length; i++) {
      list.add(
        Container(
          padding: const EdgeInsets.only(right: 8.0),
          child: ListItem(
            id: cheapTrips![i].id,
            title: cheapTrips![i].trip_name,
            secondaryInfo: cheapTrips![i].operator_name,
            extraInfo: '${cheapTrips![i].date} • ${cheapTrips![i].classification}',
            imageUrl: cheapTrips![i].image_url,
          ),
        ),
      );
    }

    return Column(children: list);
  }

  Widget getEcotourismTripsWidget()
  {
    List<Widget> list = <Widget>[];

    for (var i = 0; i < ecotourismTrips!.length; i++) {
      list.add(
        Container(
          padding: const EdgeInsets.only(right: 8.0),
          child: ListItem(
            id: ecotourismTrips![i].id,
            title: ecotourismTrips![i].trip_name,
            secondaryInfo: ecotourismTrips![i].operator_name,
            extraInfo: '${ecotourismTrips![i].date} • ${ecotourismTrips![i].classification}',
            imageUrl: ecotourismTrips![i].image_url,
          ),
        ),
      );
    }

    return Column(children: list);
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - bottomPadding,
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(24.0),
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
                    padding: const EdgeInsets.only(top: 24, bottom: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          'Esses cabem no bolso...',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'Ver mais',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: !loadingCheapTrips ?
                      getCheapTripsWidget()
                      : const Text('Nenhum encontrado'),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 24, bottom: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          '#VemAí, confira o calendário',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20.0,
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: !loadingCalendarItems && calendarItems != null ? CalendarList(items: calendarItems ?? []) : null,
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 24, bottom: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          'Viagens dos sonhos',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'Ver mais',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: !loadingDreamTrips ?
                      getDreamTripsWidget()
                      : const Text('Nenhum encontrado'),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 24, bottom: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          'Ecoturismo',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'Ver mais',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: !loadingEcotourismTrips ?
                      getEcotourismTripsWidget()
                      : const Text('Nenhum encontrado'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(current: pageIndex),
    );
  }
}