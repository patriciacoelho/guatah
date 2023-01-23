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
import 'package:guatah/widgets/wrapper_section.dart';

class DiscoveryPage extends StatefulWidget {
  const DiscoveryPage({super.key});

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
  bool loadingCalendarItems = false;
  bool loadingDreamTrips = false;
  bool loadingCheapTrips = false;
  bool loadingEcotourismTrips = false;
  bool loadingSpecialTripsData = false;
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
    setState(() {
      loadingCalendarItems = true;
    });
    calendarItems = await RemoteService().getItineraries({ 'take': '4' });
    if (calendarItems != null) {
      log("debug message (calendar)", error: calendarItems);
      setState(() {
        loadingCalendarItems = false;
      });
    }
  }

  getDreamTrips() async {
    setState(() {
      loadingDreamTrips = true;
    });
    dreamTrips = await RemoteService().getItineraries({ 'take': '2', 'desc_order_by': 'price' });
    if (dreamTrips != null) {
      log("debug message (dream trip)", error: dreamTrips);
      setState(() {
        loadingDreamTrips = false;
      });
    }
  }

  getCheapTrips() async {
    setState(() {
      loadingCheapTrips = true;
    });
    cheapTrips = await RemoteService().getItineraries({ 'take': '2', 'asc_order_by': 'price' });
    if (cheapTrips != null) {
      log("debug message (cheap trip)", error: cheapTrips);
      setState(() {
        loadingCheapTrips = false;
      });
    }
  }

  getEcotourismTrips() async {
    setState(() {
      loadingEcotourismTrips = true;
    });
    ecotourismTrips = await RemoteService().getItineraries({ 'take': '2', 'categories': ['6347eb2f7f395d1606e2ccd2'] });
    if (ecotourismTrips != null) {
      log("debug message (ecotourism trip)", error: ecotourismTrips);
      setState(() {
        loadingEcotourismTrips = false;
      });
    }
  }

  getSpecialTripsData() async {
    setState(() {
      loadingSpecialTripsData = true;
    });
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

    if (dreamTrips != null) {
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
    }

    return Column(children: list);
  }

  Widget getCheapTripsWidget()
  {
    List<Widget> list = <Widget>[];

    if (cheapTrips != null) {
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
    }

    return Column(children: list);
  }

  Widget getEcotourismTripsWidget()
  {
    List<Widget> list = <Widget>[];

    if (ecotourismTrips != null) {
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
    }

    return Column(children: list);
  }

  Widget getSpecialTripsWidget()
  {
    List<Widget> list = <Widget>[];

    if (specialTrips != null) {
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
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: list,
    );
  }

  Widget getExperienceTripsWidget()
  {
    List<Widget> list = <Widget>[];

    if (experienceTrips != null) {
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
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: list,
    );
  }

  Widget getPartyTripsWidget()
  {
    List<Widget> list = <Widget>[];

    if (partyTrips != null) {
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
                  WrapperSection(
                    title: 'Esses cabem no bolso...',
                    loading: loadingCheapTrips && (cheapTrips == null || cheapTrips!.isEmpty),
                    isEmpty: cheapTrips == null || cheapTrips!.isEmpty,
                    fallback: const Text('Nenhum roteiro encontrado'),
                    child: getCheapTripsWidget(),
                  ),
                  Align(
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
                  ),
                  SizedBox(
                    height: 225,
                    width: double.maxFinite,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        WrapperSection(
                          loading: loadingSpecialTripsData && (specialTrips == null || specialTrips!.isEmpty),
                          isEmpty: specialTrips == null || specialTrips!.isEmpty,
                          fallback: const Text('Nenhuma viagem especial encontrada'),
                          child: SizedBox(
                            height: 225,
                            width: double.maxFinite,
                            child: Row(children: [getSpecialTripsWidget()]),
                          ),
                        ),
                        WrapperSection(
                          loading: loadingExperienceTripsData && (experienceTrips == null || experienceTrips!.isEmpty),
                          isEmpty: experienceTrips == null || experienceTrips!.isEmpty,
                          fallback: const Text('Nenhuma viagem de experiência encontrada'),
                          child: SizedBox(
                            height: 225,
                            width: double.maxFinite,
                            child: Row(children: [getExperienceTripsWidget()]),
                          ),
                        ),
                        WrapperSection(
                          loading: loadingPartyTripsData && (partyTrips == null || partyTrips!.isEmpty),
                          isEmpty: partyTrips == null || partyTrips!.isEmpty,
                          fallback: const Text('Nenhuma viagem de festa encontrada'),
                          child: SizedBox(
                            height: 205,
                            width: double.maxFinite,
                            child: Row(children: [getPartyTripsWidget()]),
                          ),
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
                  WrapperSection(
                    loading: loadingCalendarItems && (calendarItems == null || calendarItems!.isEmpty),
                    isEmpty: calendarItems == null || calendarItems!.isEmpty,
                    fallback: const Text('Nenhuma agenda encontrada'),
                    child: CalendarList(items: calendarItems ?? []),
                  ),
                  WrapperSection(
                    title: 'Viagens dos sonhos',
                    loading: loadingDreamTrips && (dreamTrips == null || dreamTrips!.isEmpty),
                    isEmpty: dreamTrips == null || dreamTrips!.isEmpty,
                    fallback: const Text('Nenhum roteiro encontrado'),
                    child: getDreamTripsWidget(),
                  ),
                  WrapperSection(
                    title: 'Ecoturismo',
                    loading: loadingEcotourismTrips && (ecotourismTrips == null || ecotourismTrips!.isEmpty),
                    isEmpty: ecotourismTrips == null || ecotourismTrips!.isEmpty,
                    fallback: const Text('Nenhum roteiro encontrado'),
                    child: getEcotourismTripsWidget(),
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