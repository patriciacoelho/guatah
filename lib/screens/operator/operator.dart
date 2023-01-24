import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:guatah/constants/colors.dart';
import 'package:guatah/models/itinerary.dart';
import 'package:guatah/models/operator.dart';
import 'package:guatah/screens/results/results.dart';
import 'package:guatah/services/remote_service.dart';
import 'package:guatah/widgets/custom_app_bar.dart';
import 'package:guatah/widgets/list_item.dart';
import 'package:guatah/widgets/rounded_item.dart';
import 'package:guatah/widgets/wrapper_section.dart';
import 'package:url_launcher/url_launcher.dart';

class OperatorPage extends StatefulWidget {
  final String id;

  const OperatorPage({super.key, required this.id});

  @override
  _OperatorPageState createState() => _OperatorPageState();
}

class _OperatorPageState extends State<OperatorPage> {
  Operator? operator;
  List<Itinerary>? itineraries;
  bool loadingOperatorData = false;
  bool loadingItinerariesData = false;
  bool descriptionCollapsed = true;

  @override
  void initState() {
    super.initState();
    getOperatorData();
  }

  getOperatorData() async {
    setState(() {
      loadingOperatorData = true;
    });
    operator = await RemoteService().getOperator(id: widget.id);
    if (operator != null) {
      log("debug message (operator)", error: operator!.name);
      getItinerariesData();
      setState(() {
        loadingOperatorData = false;
      });
    }
  }

  getItinerariesData() async {
    setState(() {
      loadingItinerariesData = true;
    });
    itineraries = await RemoteService().getItineraries({ 'operator_id': operator!.id, 'take': '3' });
    if (itineraries != null) {
      setState(() {
        loadingItinerariesData = false;
      });
    }
  }

  Widget getComingListWidget()
  {
    List<Widget> list = <Widget>[];

    if (itineraries != null) {
      for (var i = 0; i < itineraries!.length; i++) {
        list.add(
          Container(
            padding: const EdgeInsets.only(right: 8.0),
            child: ListItem(
              id: itineraries![i].id,
              title: itineraries![i].trip_name,
              secondaryInfo: itineraries![i].operator_name,
              extraInfo: '${itineraries![i].date} • ${itineraries![i].classification}',
              imageUrl: itineraries![i].image_url,
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
          height: loadingOperatorData ? MediaQuery.of(context).size.height : (descriptionCollapsed ? 930 : 1000),
          child: !loadingOperatorData ? Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                child: Container(
                  width: double.maxFinite,
                  height: 180,
                  decoration: operator !=  null ? BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(operator!.image_url),
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
                  child: operator !=  null ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            operator!.name,
                            style: const TextStyle(
                              color: primaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            operator!.type.toUpperCase(),
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
                                        operator!.description ?? '',
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
                          WrapperSection(
                            title: 'Próximos destinos',
                            loading: loadingItinerariesData && (itineraries == null || itineraries!.isEmpty),
                            isEmpty: itineraries == null || itineraries!.isEmpty,
                            fallback: const Text('Nenhum roteiro recomendado'),
                            append: InkWell(
                              onTap: () {
                                final filters = {
                                  'operator': operator != null ? operator!.name : null,
                                };
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ResultsPage(params: { 'operator_id': operator!.id }, filters: filters)
                                    ),
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
                            child: getComingListWidget(),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 24, bottom: 16),
                            child: (operator!.instagram != null && operator!.instagram != '')
                              || (operator!.whatsapp != null && operator!.whatsapp != '')
                              || (operator!.site != null && operator!.site != '')
                              ? Text(
                                '${operator!.name} nas redes',
                                style:  const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ) : null,
                          ),
                          Container(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(right: 24.0),
                                  child: operator!.instagram != null && operator!.instagram != '' ? GestureDetector(
                                    onTap: () => _launchURL(operator!.instagram ?? ''),
                                    child: const RoundedItem(
                                      title: 'Instagram',
                                      imageUrl: 'http://store-images.s-microsoft.com/image/apps.31997.13510798887167234.6cd52261-a276-49cf-9b6b-9ef8491fb799.30e70ce4-33c5-43d6-9af1-491fe4679377',
                                    ),
                                  ) : null,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(right: 24.0),
                                  child: operator!.whatsapp != null && operator!.whatsapp != '' ? GestureDetector(
                                    onTap: () => _launchURL(operator!.whatsapp ?? ''),
                                    child: const RoundedItem(
                                      title: 'Whatsapp',
                                      imageUrl: 'http://store-images.s-microsoft.com/image/apps.8985.13655054093851568.1c669dab-3716-40f6-9b59-de7483397c3a.8b1af40f-2a98-4a00-98cd-94e485a04427',
                                    ),
                                  ) : null,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(right: 24.0),
                                  child: operator!.site != null && operator!.site != '' ? GestureDetector(
                                    onTap: () => _launchURL(operator!.site ?? ''),
                                    child: const RoundedItem(
                                      title: 'Site',
                                      imageUrl: 'https://www.freepnglogos.com/uploads/logo-website-png/logo-website-website-icon-with-png-and-vector-format-for-unlimited-22.png',
                                    ),
                                  ) : null,
                                ),
                              ],
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
    );
  }
}

_launchURL(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $url';
  }
}
