import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:guatah/constants/colors.dart';
import 'package:guatah/models/itinerary.dart';
import 'package:guatah/services/remote_service.dart';
import 'package:guatah/widgets/custom_app_bar.dart';

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
      body: Container(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            CustomAppBar(pageTitle: 'Detalhes'),
          ],
        ),
      ),
    );
  }
}