import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:guatah/constants/colors.dart';
import 'package:guatah/widgets/custom_app_bar.dart';
import 'package:guatah/widgets/custom_input.dart';
import 'package:guatah/models/itinerary.dart';
import 'package:guatah/services/remote_service.dart';
import 'package:guatah/widgets/list_item.dart';

class ResultsPage extends StatefulWidget {
  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  List<Itinerary>? itineraries;
  bool loadingData = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    itineraries = await RemoteService().getItineraries();
    if (itineraries != null) {
      log("debug message", error: itineraries);
      setState(() {
        loadingData = false;
      });
    }
  }

  Widget getListItemWidgets()
  {
    List<Widget> list = <Widget>[];

    for (var i = 0; i < itineraries!.length; i++) {
      log(itineraries![i].image_url);
      list.add(
        ListItem(
          title: itineraries![i].trip_name,
          extraInfo: '${itineraries![i].date} • ${itineraries![i].classification}',
          imageUrl: itineraries![i].image_url,
        ),
      );
    }

    return Column(children: list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAppBar(pageTitle: 'Resultados'),
            Container(
              padding: const EdgeInsets.only(top: 24),
              child: const CustomInput(
                searchType: true,
                hintText: 'Buscar lugares',
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: const Text(
                'Filtros aplicados',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 24),
              child: !loadingData ?
                getListItemWidgets()
                : const Text('Nenhum item'),
            )
          ],
        ),
      ),
    );
  }
}