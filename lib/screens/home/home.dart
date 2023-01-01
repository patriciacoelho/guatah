
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:guatah/constants/colors.dart';
import 'package:guatah/models/category.dart';
import 'package:guatah/models/itinerary.dart';
import 'package:guatah/models/operator.dart';
import 'package:guatah/screens/results/results.dart';
import 'package:guatah/services/remote_service.dart';
import 'package:guatah/widgets/custom_app_bar.dart';
import 'package:guatah/widgets/custom_input.dart';
import 'package:guatah/widgets/custom_navigation_bar.dart';
import 'package:guatah/widgets/highlight_card_item.dart';
import 'package:guatah/widgets/list_item.dart';
import 'package:guatah/widgets/rounded_item.dart';
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
  List<Category>? categories;
  bool loadingOperatorsData = true;
  bool loadingItinerariesData = true;
  bool loadingCategoriesData = true;

  @override
  void initState() {
    super.initState();
    getOperatorsData();
    getItinerariesData();
    getCategoriesData();
  }

  getOperatorsData() async {
    operators = await RemoteService().getOperators({});
    if (operators != null) {
      log("debug message", error: operators);
      setState(() {
        loadingOperatorsData = false;
      });
    }
  }

  getItinerariesData() async {
    itineraries = await RemoteService().getItineraries({});
    if (itineraries != null) {
      log("debug message", error: itineraries);
      setState(() {
        loadingItinerariesData = false;
      });
    }
  }

  getCategoriesData() async {
    categories = await RemoteService().getCategories();
    if (categories != null) {
      log("debug message", error: categories);
      setState(() {
        loadingCategoriesData = false;
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
            trip_id: trips[i].trip_id,
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

  Widget getRecommendedListWidget()
  {
    List<Widget> list = <Widget>[];
    List<Itinerary>? recommended = itineraries?.sublist(0, 3);

    for (var i = 0; i < recommended!.length; i++) {
      list.add(
        Container(
          padding: const EdgeInsets.only(right: 8.0),
          child: ListItem(
            id: recommended[i].id,
            title: recommended[i].trip_name,
            secondaryInfo: recommended[i].operator_name,
            extraInfo: '${recommended[i].date} • ${recommended[i].classification}',
            imageUrl: recommended[i].image_url,
          ),
        ),
      );
    }

    return Column(children: list);
  }

  Widget getCategoriesListWidget()
  {
    List<Widget> list = <Widget>[];

    for (var i = 0; i < categories!.length; i++) {
      list.add(
        Container(
          padding: const EdgeInsets.only(right: 8.0),
          child: GestureDetector(
            onTap: () {
              final categoryId = categories![i].id;
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ResultsPage(params: { 'categories': [categoryId] })),
                );
            },
            child: RoundedItem(
              title: categories![i].name,
              imageUrl: categories![i].image_url,
            ),
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
                    noBackNavigation: true,
                    rightWidget: Icon(
                      Ionicons.person_circle,
                      color: primaryColor,
                      size: 48.0,
                    ),
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
                    child: const Text(
                      'Categorias',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Container(
                    child: !loadingCategoriesData ?
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 80.0,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [getCategoriesListWidget()],
                        ),
                      )
                      : const Text('Nenhuma categoria encontrada'),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 24, bottom: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          'Recomendados',
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
                    child: !loadingItinerariesData ?
                      getRecommendedListWidget()
                      : const Text('Nenhum recomendado'),
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
