import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:guatah/constants/colors.dart';
import 'package:guatah/models/itinerary.dart';
import 'package:guatah/services/remote_service.dart';
import 'package:guatah/widgets/custom_app_bar.dart';
import 'package:ionicons/ionicons.dart';

class DetailsPage extends StatefulWidget {
  final String id;

  const DetailsPage({super.key, required this.id});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Itinerary? itinerary;
  bool loadingData = true;

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
      setState(() {
        loadingData = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
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
              // height: double.maxFinite,
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
                          child: Column(
                            children: [
                              Text(
                                itinerary!.description ?? '',
                                style: const TextStyle(
                                  color: textColor,
                                  fontSize: 12,
                                ),
                              ),
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
                      ]
                    ),
                  ),
                ],
              ) : null,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            Text(itinerary != null ? 'R\$ ${itinerary!.price}' : ''),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 48.0),
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                elevation: 0,
              ),
              child: const Text('Reservar'),
            ),
          ]),
      ),
    );
  }
}