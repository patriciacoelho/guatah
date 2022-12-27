
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:guatah/constants/colors.dart';
import 'package:guatah/models/itinerary.dart';
import 'package:guatah/models/operator.dart';
import 'package:guatah/services/remote_service.dart';
import 'package:guatah/widgets/custom_app_bar.dart';
import 'package:guatah/widgets/custom_input.dart';
import 'package:guatah/widgets/custom_navigation_bar.dart';
import 'package:guatah/widgets/highlight_card_item.dart';
import 'package:guatah/widgets/simple_card_item.dart';
import 'package:ionicons/ionicons.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var pageIndex = 0;
  List<Operator>? operators;
  List<Itinerary>? itineraries;
  bool loadingOperatorsData = true;
  bool loadingItinerariesData = true;

  @override
  void initState() {
    super.initState();
    getOperatorsData();
    getItinerariesData();
  }

  getOperatorsData() async {
    operators = await RemoteService().getOperators();
    if (operators != null) {
      log("debug message", error: operators);
      setState(() {
        loadingOperatorsData = false;
      });
    }
  }

  getItinerariesData() async {
    itineraries = await RemoteService().getItineraries();
    if (itineraries != null) {
      log("debug message", error: itineraries);
      setState(() {
        loadingItinerariesData = false;
      });
    }
  }

  getTripItineraries() {
    if (itineraries == null) {
      return [];
    }
    return itineraries?.where((itinerary) =>  itinerary.classification == 'bate-volta').toList();
  }

  // TODO - getTravelItineraries
  // TODO - getTourItineraries

  Widget getTripItinerariesListWidget()
  {
    List<Widget> list = <Widget>[];
    List<Itinerary>? trips = getTripItineraries();

    for (var i = 0; i < trips!.length; i++) {
      list.add(
        Container(
          padding: const EdgeInsets.only(right: 8.0),
          child: HighlightCardItem(
            id: trips[i].id,
            title: trips[i].trip_name,
            subtitle: trips[i].operator_name,
            date: trips[i].date,
            imageUrl: trips[i].image_url,
          ),
        ),
      );
    }

    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: list,
    );
  }

  Widget getOperatorList()
  {
    List<Widget> list = <Widget>[];

    for (var i = 0; i < operators!.length; i++) {
      list.add(
        Container(
          padding: const EdgeInsets.only(right: 8.0),
          child: SimpleCardItem(
            id: operators![i].id,
            title: operators![i].name,
            imageUrl: operators![i].image_url,
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
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomAppBar(
                    rightIcon: Ionicons.person_circle,
                    noBackNavigation: true,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
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
                  Container(
                    padding: const EdgeInsets.only(top: 24, bottom: 16),
                    child: const Text(
                      'Bate-volta',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Container(
                    child: !loadingItinerariesData ?
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 210.0,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [getTripItinerariesListWidget()],
                        ),
                      )
                      : const Text('Nenhuma empresa encontrada'),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 24, bottom: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          'Empresas',
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
                    child: !loadingOperatorsData ?
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 140.0,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [getOperatorList()],
                        ),
                      )
                      : const Text('Nenhuma empresa encontrada'),
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
