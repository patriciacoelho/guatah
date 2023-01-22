
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
import 'package:guatah/widgets/wrapper_section.dart';
import 'package:ionicons/ionicons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
  bool loadingOperatorsData = false;
  bool loadingItinerariesData = false;
  bool loadingCategoriesData = false;
  bool loadingRecommendedItinerariesData = false;
  bool loadingTripItinerariesData = false;
  bool loadingTravelItinerariesData = false;
  bool loadingTourItinerariesData = false;

  @override
  void initState() {
    super.initState();
    getTripItinerariesData();
    getCategoriesData();
    getRecommendedItinerariesData();
    getOperatorsData();
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
    setState(() {
      loadingOperatorsData = true;
    });
    operators = await RemoteService().getOperators({});
    if (operators != null) {
      log("debug message", error: operators);
      setState(() {
        loadingOperatorsData = false;
      });
    }
  }

  getCategoriesData() async {
    setState(() {
      loadingCategoriesData = true;
    });
    categories = await RemoteService().getCategories();
    if (categories != null) {
      log("debug message", error: categories);
      setState(() {
        loadingCategoriesData = false;
      });
    }
  }

  getTripItinerariesData() async {
    setState(() {
      loadingTripItinerariesData = true;
      loadingTravelItinerariesData = true;
      loadingTourItinerariesData = true;
    });
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
    setState(() {
      loadingTravelItinerariesData = true;
    });
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

    if (tripItineraries != null) {
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
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: list,
    );
  }

  Widget getTravelItinerariesWidget()
  {
    List<Widget> list = <Widget>[];

    if (travelItineraries != null) {
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
    }


    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: list,
    );
  }

  Widget getTourItinerariesWidget()
  {
    List<Widget> list = <Widget>[];

    if (tourItineraries != null) {
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
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: list,
    );
  }

  Widget getRecommendedListWidget()
  {
    List<Widget> list = <Widget>[];

    if (recommendedItineraries != null) {
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
    }

    return Column(children: list);
  }

  Widget getCategoriesListWidget()
  {
    List<Widget> list = <Widget>[];

    if (categories != null) {
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
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: list,
    );
  }

  Widget getOperatorList()
  {
    List<Widget> list = <Widget>[];

    if (operators != null) {
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
                    padding: const EdgeInsets.only(bottom: 8.0),
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
                    ),
                  ),
                  SizedBox(
                    height: 205,
                    width: double.maxFinite,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        WrapperSection(
                          loading: loadingTripItinerariesData && (tripItineraries == null || tripItineraries!.isEmpty),
                          isEmpty: tripItineraries == null || tripItineraries!.isEmpty,
                          fallback: const Text('Nenhum bate-volta encontrado'),
                          child: SizedBox(
                            height: 205,
                            width: double.maxFinite,
                            child: getTripItinerariesListWidget(),
                          ),
                        ),
                        WrapperSection(
                          loading: loadingTravelItinerariesData && (travelItineraries == null || travelItineraries!.isEmpty),
                          isEmpty: travelItineraries == null || travelItineraries!.isEmpty,
                          fallback: const Text('Nenhuma viagem de fim de semana'),
                          child: SizedBox(
                            height: 205,
                            width: double.maxFinite,
                            child: getTravelItinerariesWidget(),
                          ),
                        ),
                        WrapperSection(
                          loading: loadingTourItinerariesData && (tourItineraries == null || tourItineraries!.isEmpty),
                          isEmpty: tourItineraries == null || tourItineraries!.isEmpty,
                          fallback: const Text('Nenhum passeio local encontrado'),
                          child: SizedBox(
                            height: 205,
                            width: double.maxFinite,
                            child: getTourItinerariesWidget(),
                          ),
                        ),
                      ],
                    )
                  ),
                  WrapperSection(
                    title: 'Categorias',
                    loading: loadingCategoriesData && (categories == null || categories!.isEmpty),
                    isEmpty: categories == null || categories!.isEmpty,
                    fallback: const Text('Nenhuma categoria encontrada'),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 80.0,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [getCategoriesListWidget()],
                      ),
                    ),
                  ),
                  WrapperSection(
                    title: 'Recomendados',
                    loading: loadingRecommendedItinerariesData && (recommendedItineraries == null || recommendedItineraries!.isEmpty),
                    isEmpty: recommendedItineraries == null || recommendedItineraries!.isEmpty,
                    fallback: const Text('Nenhuma viagem nos recomendados'),
                    child: getRecommendedListWidget(),
                  ),
                  WrapperSection(
                    title: 'Empresas',
                    loading: loadingOperatorsData && (operators == null || operators!.isEmpty),
                    isEmpty: operators == null || operators!.isEmpty,
                    fallback: const Text('Nenhuma empresa encontrada'),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 140.0,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [getOperatorList()],
                      ),
                    ),
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
