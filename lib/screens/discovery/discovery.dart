import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:guatah/constants/colors.dart';
import 'package:guatah/models/itinerary.dart';
import 'package:guatah/services/remote_service.dart';
import 'package:guatah/widgets/calendar_list.dart';
import 'package:guatah/widgets/custom_navigation_bar.dart';
import 'package:guatah/widgets/dash_tab_indicator.dart';
import 'package:guatah/widgets/highlight_card_item.dart';
import 'package:guatah/widgets/list_item.dart';

class DiscoveryPage extends StatefulWidget {
  @override
  _DiscoveryPageState createState() => _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage> with TickerProviderStateMixin {
  var pageIndex = 1;

  late TabController _tabController;

  List<Itinerary>? calendarItems;
  List<Itinerary>? dreamTrips;
  List<Itinerary>? cheapTrips;
  List<Itinerary>? ecotourismTrips;
  List<Itinerary>? specialTrips;
  List<Itinerary>? experienceTrips;
  List<Itinerary>? partyTrips;
  bool loadingCalendarItems = true;
  bool loadingDreamTrips = true;
  bool loadingCheapTrips = true;
  bool loadingEcotourismTrips = true;
  bool loadingSpecialTripsData = true;
  bool loadingExperienceTripsData = true;
  bool loadingPartyTripsData = true;

  @override
  void initState() {
    super.initState();
    getCheapTrips();
    getSpecialTripsData();
    getCalendarItems();
    getDreamTrips();
    getEcotourismTrips();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      if (_tabController.index == 1) {
        getExperienceTripsData();
      }
      if (_tabController.index == 2) {
        getPartyTripsData();
      }
    }
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

  getSpecialTripsData() async {
    specialTrips = await RemoteService().getItineraries({ 'take': '2', 'categories': ['63bac4bd5e1a89f1a873607b'] });
    if (specialTrips != null) {
      log("debug message (special trips)", error: specialTrips);
      setState(() {
        loadingSpecialTripsData = false;
      });
    }
  }

  getExperienceTripsData() async {
    if (experienceTrips != null) {
      return;
    }
    experienceTrips = await RemoteService().getItineraries({ 'take': '2', 'categories': ['6347eb5b7f395d1606e2ccd4'] });
    if (experienceTrips != null) {
      log("debug message (experience trips)", error: experienceTrips);
      setState(() {
        loadingExperienceTripsData = false;
      });
    }
  }

  getPartyTripsData() async {
    if (partyTrips != null) {
      return;
    }
    partyTrips = await RemoteService().getItineraries({ 'take': '2', 'categories': ['6347eb437f395d1606e2ccd3'] });
    if (partyTrips != null) {
      log("debug message (party trips)", error: partyTrips);
      setState(() {
        loadingPartyTripsData = false;
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

  Widget getSpecialTripsWidget()
  {
    List<Widget> list = <Widget>[];

    for (var i = 0; i < specialTrips!.length; i++) {
      list.add(
        Container(
          padding: const EdgeInsets.only(right: 8.0),
          child: HighlightCardItem(
            id: specialTrips![i].id,
            trip_id: specialTrips![i].trip_id,
            title: specialTrips![i].trip_name,
            subtitle: specialTrips![i].operator_name,
            date: specialTrips![i].date,
            imageUrl: specialTrips![i].image_url,
          ),
        ),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: list,
    );
  }

  Widget getExperienceTripsWidget()
  {
    List<Widget> list = <Widget>[];

    for (var i = 0; i < experienceTrips!.length; i++) {
      list.add(
        Container(
          padding: const EdgeInsets.only(right: 8.0),
          child: HighlightCardItem(
            id: experienceTrips![i].id,
            trip_id: experienceTrips![i].trip_id,
            title: experienceTrips![i].trip_name,
            subtitle: experienceTrips![i].operator_name,
            date: experienceTrips![i].date,
            imageUrl: experienceTrips![i].image_url,
          ),
        ),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: list,
    );
  }

  Widget getPartyTripsWidget()
  {
    List<Widget> list = <Widget>[];

    for (var i = 0; i < partyTrips!.length; i++) {
      list.add(
        Container(
          padding: const EdgeInsets.only(right: 8.0),
          child: HighlightCardItem(
            id: partyTrips![i].id,
            trip_id: partyTrips![i].trip_id,
            title: partyTrips![i].trip_name,
            subtitle: partyTrips![i].operator_name,
            date: partyTrips![i].date,
            imageUrl: partyTrips![i].image_url,
          ),
        ),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: list,
    );
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
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TabBar(
                        labelPadding: const EdgeInsets.only(left: 12, right: 12),
                        controller: _tabController,
                        labelStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),
                        labelColor: primaryColor,
                        unselectedLabelStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
                        unselectedLabelColor: mediumGreyColor,
                        isScrollable: true,
                        indicator: DashedTabIndicator(color: primaryColor, stroke: 3.0),
                        tabs: const [
                          Tab(text: 'Especiais'),
                          Tab(text: 'Experiências'),
                          Tab(text: '#Festas'),
                        ],
                      ),
                    )
                  ),
                  SizedBox(
                    height: 225,
                    width: double.maxFinite,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        SizedBox(
                          height: double.maxFinite,
                          width: double.maxFinite,
                          child: !loadingSpecialTripsData ?
                            Row(children: [getSpecialTripsWidget()])
                            : const Text('Nenhum item especial'),
                        ),
                        SizedBox(
                          height: double.maxFinite,
                          width: double.maxFinite,
                          child: !loadingExperienceTripsData ?
                            Row(children: [getExperienceTripsWidget()])
                            : const Text('Nenhum item de experiência'),
                        ),
                        SizedBox(
                          height: double.maxFinite,
                          width: double.maxFinite,
                          child: !loadingPartyTripsData ?
                            Row(children: [getPartyTripsWidget()])
                            : const Text('Nenhum item de festa'),
                        ),
                      ],
                    )
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