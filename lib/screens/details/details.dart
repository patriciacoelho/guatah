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
import 'package:guatah/widgets/trip_tag_dialog.dart';
import 'package:guatah/widgets/wrapper_section.dart';
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
  bool loadingData = false;
  bool loadingOperatorsData = false;
  bool loadingItinerariesSuggestionsData = false;

  bool descriptionCollapsed = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      loadingData = true;
    });
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
    setState(() {
      loadingOperatorsData = true;
    });
    List<Operator>? allOperators = await RemoteService().getOperators({ 'pickup_id': itinerary!.pickup_city_ids[0] });
    if (allOperators != null) {
      operators = allOperators.where((operator) => operator.id != itinerary!.operator_id).toList();
      log("debug message (operators)", error: operators);
      setState(() {
        loadingOperatorsData = false;
      });
    }
  }

  getSuggestionsData() async {
    setState(() {
      loadingItinerariesSuggestionsData = true;
    });
    List<Itinerary>? itinerariesByCategory = await RemoteService().getItineraries({ 'categories': itinerary!.trip_categories, 'take': '3' });
    if (itinerariesByCategory != null) {
      itinerariesSuggestions = itinerariesByCategory.where((item) => item.id != itinerary!.id).toList();
      if (itinerariesByCategory.length > 2) {
        itinerariesSuggestions = itinerariesSuggestions?.sublist(0, 2);
      }
      log("debug message (suggestions)", error: itinerariesSuggestions);
      setState(() {
        loadingItinerariesSuggestionsData = false;
      });
    }
  }

  Widget getOperatorsList()
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

  Widget getSuggestionListWidget()
  {
    List<Widget> list = <Widget>[];

    if (itinerariesSuggestions != null) {
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
          height: loadingData ? MediaQuery.of(context).size.height : (descriptionCollapsed ? 1000 : 1080),
          child: !loadingData ? Stack(
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
                  child: CustomAppBar(
                    rightWidget: !loadingData ? TripTagDialog(itinerary_id: itinerary!.id, trip_id: itinerary!.trip_id) : Container(),
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
                      Column(
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
                          WrapperSection(
                            title: 'Outros roteiros sugeridos',
                            loading: loadingItinerariesSuggestionsData && (itinerariesSuggestions == null || itinerariesSuggestions!.isEmpty),
                            isEmpty: itinerariesSuggestions == null || itinerariesSuggestions!.isEmpty,
                            fallback: const Text('Nenhuma sugestão de viagem'),
                            append: InkWell(
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
                            child: getSuggestionListWidget(),
                          ),
                          WrapperSection(
                            title: 'Outras empresas na região',
                            loading: loadingOperatorsData && (operators == null || operators!.isEmpty),
                            isEmpty: operators == null || operators!.isEmpty,
                            fallback: const Text('Nenhuma empresa encontrada'),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 140.0,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [getOperatorsList()],
                              ),
                            ),
                          ),
                        ]
                      ),
                    ],
                  ) : null,
                ),
              ),
            ],
          )
          : Stack(
              children: [
                Positioned(
                  top: MediaQuery.of(context).size.height/2 - 35*2,
                  left: MediaQuery.of(context).size.width/2 - 35/2,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 32.0),
                    width: 35.0,
                    height: 35.0,
                    child: const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color> (primaryColor),
                    ),
                  ),
                ),
              ],
            ),
        ),
      ),
      bottomNavigationBar: !loadingData ? BottomAppBar(
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
      ) : null,
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
