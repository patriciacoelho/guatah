
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
import 'package:guatah/widgets/dash_tab_indicator.dart';
import 'package:guatah/widgets/highlight_card_item.dart';
import 'package:guatah/widgets/list_item.dart';
import 'package:guatah/widgets/rounded_item.dart';
import 'package:guatah/widgets/simple_card_item.dart';
import 'package:ionicons/ionicons.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  var pageIndex = 0;
  late TabController _tabController;

  List<Operator>? operators;
  List<Category>? categories;
  List<Itinerary>? recommendedItineraries;
  List<Itinerary>? tripItineraries;
  List<Itinerary>? travelItineraries;
  List<Itinerary>? tourItineraries;
  bool loadingOperatorsData = true;
  bool loadingItinerariesData = true;
  bool loadingCategoriesData = true;
  bool loadingRecommendedItinerariesData = true;
  bool loadingTripItinerariesData = true;
  bool loadingTravelItinerariesData = true;
  bool loadingTourItinerariesData = true;

  @override
  void initState() {
    super.initState();
    getTripItinerariesData();
    getOperatorsData();
    getCategoriesData();
    getRecommendedItinerariesData();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      if (_tabController.index == 1) {
        getTravelItinerariesData();
      }
      if (_tabController.index == 2) {
        getTourItinerariesData();
      }
    }
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

  getCategoriesData() async {
    categories = await RemoteService().getCategories();
    if (categories != null) {
      log("debug message", error: categories);
      setState(() {
        loadingCategoriesData = false;
      });
    }
  }

  getTripItinerariesData() async {
    tripItineraries = await RemoteService().getItineraries({ 'take': '2', 'classification': 'bate-volta' });
    if (tripItineraries != null) {
      log("debug message (trip)", error: tripItineraries);
      setState(() {
        loadingTripItinerariesData = false;
      });
    }
  }

  getTravelItinerariesData() async {
    if (travelItineraries != null) {
      return;
    }
    travelItineraries = await RemoteService().getItineraries({ 'take': '2', 'classification': 'final de semana' });
    if (travelItineraries != null) {
      log("debug message (travel)", error: travelItineraries);
      setState(() {
        loadingTravelItinerariesData = false;
      });
    }
  }

  getTourItinerariesData() async {
    if (tourItineraries != null) {
      return;
    }
    tourItineraries = await RemoteService().getItineraries({ 'take': '2', 'classification': 'passeio' });
    if (tourItineraries != null) {
      log("debug message (tour)", error: tourItineraries);
      setState(() {
        loadingTourItinerariesData = false;
      });
    }
  }

  getRecommendedItinerariesData() async {
    recommendedItineraries = await RemoteService().getItineraries({ 'take': '3' });
    if (recommendedItineraries != null) {
      log("debug message (recommended trip)", error: recommendedItineraries);
      setState(() {
        loadingRecommendedItinerariesData = false;
      });
    }
  }

  Widget getTripItinerariesListWidget()
  {
    List<Widget> list = <Widget>[];

    for (var i = 0; i < tripItineraries!.length; i++) {
      list.add(
        Container(
          padding: const EdgeInsets.only(right: 8.0),
          child: HighlightCardItem(
            id: tripItineraries![i].id,
            trip_id: tripItineraries![i].trip_id,
            title: tripItineraries![i].trip_name,
            subtitle: tripItineraries![i].operator_name,
            date: tripItineraries![i].date,
            imageUrl: tripItineraries![i].image_url,
          ),
        ),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: list,
    );
  }

  Widget getTravelItinerariesWidget()
  {
    List<Widget> list = <Widget>[];

    for (var i = 0; i < travelItineraries!.length; i++) {
      list.add(
        Container(
          padding: const EdgeInsets.only(right: 8.0),
          child: HighlightCardItem(
            id: travelItineraries![i].id,
            trip_id: travelItineraries![i].trip_id,
            title: travelItineraries![i].trip_name,
            subtitle: travelItineraries![i].operator_name,
            date: travelItineraries![i].date,
            imageUrl: travelItineraries![i].image_url,
          ),
        ),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: list,
    );
  }

  Widget getTourItinerariesWidget()
  {
    List<Widget> list = <Widget>[];

    for (var i = 0; i < tourItineraries!.length; i++) {
      list.add(
        Container(
          padding: const EdgeInsets.only(right: 8.0),
          child: HighlightCardItem(
            id: tourItineraries![i].id,
            trip_id: tourItineraries![i].trip_id,
            title: tourItineraries![i].trip_name,
            subtitle: tourItineraries![i].operator_name,
            date: tourItineraries![i].date,
            imageUrl: tourItineraries![i].image_url,
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

    for (var i = 0; i < recommendedItineraries!.length; i++) {
      list.add(
        Container(
          padding: const EdgeInsets.only(right: 8.0),
          child: ListItem(
            id: recommendedItineraries![i].id,
            title: recommendedItineraries![i].trip_name,
            secondaryInfo: recommendedItineraries![i].operator_name,
            extraInfo: '${recommendedItineraries![i].date} • ${recommendedItineraries![i].classification}',
            imageUrl: recommendedItineraries![i].image_url,
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
                          Tab(text: 'Bate-volta'),
                          Tab(text: 'Fim de semana'),
                          Tab(text: 'Passeios'),
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
                          child: !loadingTripItinerariesData ?
                            getTripItinerariesListWidget()
                            : const Text('Nenhum bate-volta'),
                        ),
                        SizedBox(
                          height: double.maxFinite,
                          width: double.maxFinite,
                          child: !loadingTravelItinerariesData ?
                            getTravelItinerariesWidget()
                            : const Text('Nenhuma viagem de fim de semana'),
                        ),
                        SizedBox(
                          height: double.maxFinite,
                          width: double.maxFinite,
                          child: !loadingTourItinerariesData ?
                            getTourItinerariesWidget()
                            : const Text('Nenhum passeio'),
                        ),
                      ],
                    )
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
                    child: !loadingRecommendedItinerariesData ?
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
