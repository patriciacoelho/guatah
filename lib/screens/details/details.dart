import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:guatah/constants/colors.dart';
import 'package:guatah/models/itinerary.dart';
import 'package:guatah/models/operator.dart';
import 'package:guatah/screens/results/results.dart';
import 'package:guatah/services/remote_service.dart';
import 'package:guatah/widgets/custom_app_bar.dart';
import 'package:guatah/widgets/list_item.dart';
import 'package:guatah/widgets/simple_card_item.dart';
import 'package:ionicons/ionicons.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsPage extends StatefulWidget {
  final String id;

  const DetailsPage({super.key, required this.id});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Itinerary? itinerary;
  List<Itinerary>? itinerariesSuggestions;
  List<Operator>? operators;
  bool loadingData = true;
  bool loadingOperatorsData = true;
  bool loadingItinerariesSuggestionsData = true;

  bool descriptionCollapsed = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    log('details id: ', error: widget.id);
    itinerary = await RemoteService().getItineraryDetails(id: widget.id);
    if (itinerary != null) {
      log("debug message (details)", error: itinerary!.trip_name);
      getOperatorsData();
      getSuggestionsData();
      setState(() {
        loadingData = false;
      });
    }
  }

  getOperatorsData() async {
    operators = await RemoteService().getOperators({ 'pickup_id': itinerary!.pickup_city_ids[0] });
    if (operators != null) {
      log("debug message (operators)", error: operators);
      setState(() {
        loadingOperatorsData = false;
      });
    }
  }

  getSuggestionsData() async {
    itinerariesSuggestions = await RemoteService().getItineraries({ 'categories': itinerary!.trip_categories, 'take': '2' });
    if (itinerariesSuggestions != null) {
      log("debug message (suggestions)", error: itinerariesSuggestions);
      setState(() {
        loadingItinerariesSuggestionsData = false;
      });
    }
  }

  Widget getOperatorsList()
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

  Widget getSuggestionListWidget()
  {
    List<Widget> list = <Widget>[];

    for (var i = 0; i < itinerariesSuggestions!.length; i++) {
      list.add(
        Container(
          padding: const EdgeInsets.only(right: 8.0),
          child: ListItem(
            id: itinerariesSuggestions![i].id,
            title: itinerariesSuggestions![i].trip_name,
            secondaryInfo: itinerariesSuggestions![i].operator_name,
            extraInfo: '${itinerariesSuggestions![i].date} • ${itinerariesSuggestions![i].classification}',
            imageUrl: itinerariesSuggestions![i].image_url,
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
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.maxFinite,
          height: descriptionCollapsed ? 1000 : 1080,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                child: Container(
                  width: double.maxFinite,
                  height: 180,
                  decoration: itinerary !=  null ? BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(itinerary!.image_url),
                      fit: BoxFit.cover,
                    ),
                  ) : null,
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).viewPadding.top,
                right: 0,
                left: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: const CustomAppBar(
                    rightIcon: Ionicons.bookmark_outline,
                    rightCallback: null,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                top: 160,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(24),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: itinerary !=  null ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              itinerary!.trip_name,
                              style: const TextStyle(
                                color: primaryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              itinerary!.classification.toUpperCase(),
                              style: const TextStyle(
                                color: mediumGreyColor,
                                fontSize: 12,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 24.0),
                              height: descriptionCollapsed ? 190.0 : 245.0,
                              child: Column(
                                children: [
                                  Flexible(
                                    child: SizedBox(
                                      height: descriptionCollapsed ? 180.0 : 245.0,
                                      child: SingleChildScrollView(
                                        physics: descriptionCollapsed ? const NeverScrollableScrollPhysics() : const BouncingScrollPhysics(),
                                        child: Text(
                                          itinerary!.description ?? '',
                                          overflow: descriptionCollapsed ? TextOverflow.ellipsis : null,
                                          maxLines: descriptionCollapsed ? 7 : null,
                                          style: const TextStyle(
                                            color: textColor,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  descriptionCollapsed ? InkWell(
                                    onTap: () {
                                      setState(() {
                                        descriptionCollapsed = false;
                                      });
                                    },
                                    child: const Text(
                                      'continuar lendo',
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: mediumGreyColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ) : Container(),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
                              decoration: BoxDecoration(
                                border: Border.all(color: primaryColor),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      const Icon(
                                        Ionicons.timer_outline,
                                        color: primaryColor,
                                        size: 30,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(top: 4.0),
                                        child: Text(
                                          itinerary!.classification,
                                          style: const TextStyle(
                                            color: primaryColor,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ]
                                  ),
                                  Column(
                                    children: [
                                      const Icon(
                                        Ionicons.bus_outline,
                                        color: primaryColor,
                                        size: 30,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(top: 4.0),
                                        child: Text(
                                          itinerary!.operator_name,
                                          style: const TextStyle(
                                            color: primaryColor,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ]
                                  ),
                                  Column(
                                    children: [
                                      const Icon(
                                        Ionicons.calendar_outline,
                                        color: primaryColor,
                                        size: 30,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(top: 4.0),
                                        child: Text(
                                          itinerary!.date,
                                          style: const TextStyle(
                                            color: primaryColor,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ]
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 24, bottom: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Próximos destinos',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => ResultsPage(params: { 'categories': itinerary!.trip_categories })),
                                        );
                                    },
                                    child: const Text(
                                      'Ver mais',
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: mediumGreyColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: !loadingItinerariesSuggestionsData ?
                                getSuggestionListWidget()
                                : const Text('Nenhuma sugestão de viagem'),
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 24, bottom: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Outras empresas',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
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
                                    children: [getOperatorsList()],
                                  ),
                                )
                                : const Text('Nenhuma empresa encontrada'),
                            ),
                          ]
                        ),
                      ),
                    ],
                  ) : null,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: const BoxDecoration(
            color: lightShadowColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                itinerary != null ? 'R\$ ${(itinerary!.price ?? 0).toStringAsFixed(2).replaceAll('.', ',')}' : '',
                style: const TextStyle(
                  color: primaryColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              ElevatedButton(
                onPressed: () => _launchURL(itinerary!.site ?? itinerary!.whatsapp ?? itinerary!.instagram),
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 32.0),
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  elevation: 0,
                ),
                child: const Text('Reservar'),
              ),
            ]),
        ),
      ),
    );
  }
}

_launchURL(String? url) async {
  if (url!.isNotEmpty) {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}
