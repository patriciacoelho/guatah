import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:guatah/constants/colors.dart';
import 'package:guatah/widgets/custom_app_bar.dart';
import 'package:guatah/widgets/custom_input.dart';
import 'package:guatah/models/itinerary.dart';
import 'package:guatah/services/remote_service.dart';
import 'package:guatah/widgets/list_item.dart';
import 'package:guatah/widgets/wrapper_section.dart';
import 'package:ionicons/ionicons.dart';

class ResultsPage extends StatefulWidget {
  final Map<String, dynamic>? params;
  final Map<String, dynamic>? filters;

  const ResultsPage({ super.key, this.params, this.filters });

  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  final searchController = TextEditingController();

  List<Itinerary>? itineraries;
  bool loadingData = true;

  Map<String, dynamic>? _params;
  List<Map<String, dynamic>?>? _filters;

  @override
  void initState() {
    super.initState();
    setState(() {
      _params = widget.params;
    });
    getData();
    fillFilters();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  getData() async {
    itineraries = await RemoteService().getItineraries(_params);
    if (itineraries != null) {
      log("debug message", error: itineraries);
      setState(() {
        loadingData = false;
      });
    }
  }

  fillFilters() {
    log("filters: ", error: widget.filters.toString());
    List<Map<String, dynamic>?>? items = [
      widget.filters!['pickup_city'] != null ? {
        'key': 'pickup_id',
        'text': 'Saída: ${widget.filters!['pickup_city']}',
      } : null,
      widget.filters!['operator'] != null ? {
        'key': 'operator_id',
        'text': 'Empresa: ${widget.filters!['operator']}',
      } : null,
      widget.filters!['interval'] != null ? {
        'key': 'end_date',
        'text': widget.filters!['interval'],
      } : null,
      widget.filters!['classification'] != null ? {
        'key': 'classification',
        'text': widget.filters!['classification'],
      } : null,
    ];
    setState(() {
      searchController.text = widget.filters!['search'] ?? '';
      _filters = items;
    });
    log("filters: ", error: _filters.toString());
  }

  bool hasFilters() {
    if (_filters == null) {
      return false;
    }

    for (var item in _filters!) {
      if (item != null) {
        return true;
      }
    }
    return false;
  }

  Widget getFiltersWidgets()
  {
    List<Widget> list = <Widget>[];

    for (var index = 0; index < _filters!.length; index++) {
      var item = _filters![index];
      if (item != null) {
        list.add(
          Container(
            padding: const EdgeInsets.only(top: 4.0, right: 4.0, bottom: 4.0, left: 12.0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
              color: primaryColor,
            ),
            child: Wrap(
              children: [
                Text(
                  item['text'] ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    log('tapped ${item['key']}');
                    setState(() {
                      _params![item['key']] = null;
                      _filters![index] = null;
                    });
                    getData();
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 4.0),
                    child: const Icon(
                      Ionicons.close_circle,
                      color: Colors.white,
                      size: 16.0,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }
    }

    return Wrap(
      spacing: 4.0,
      runSpacing: 4.0,
      children: list,
    );
  }

  Widget getListItemWidgets()
  {
    List<Widget> list = <Widget>[];

  if (itineraries != null) {
    for (var i = 0; i < itineraries!.length; i++) {
      list.add(
        ListItem(
          id: itineraries![i].id,
          title: itineraries![i].trip_name,
          secondaryInfo: itineraries![i].operator_name,
          extraInfo: '${itineraries![i].date} • ${itineraries![i].classification}',
          imageUrl: itineraries![i].image_url,
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
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomAppBar(pageTitle: 'Resultados'),
                  Container(
                    padding: const EdgeInsets.only(top: 24),
                    child: CustomInput(
                      searchType: true,
                      controller: searchController,
                      hintText: 'Buscar lugares',
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: hasFilters() ? 
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 4.0),
                            child: const Text(
                              'Filtros aplicados',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          getFiltersWidgets(),
                        ],
                      ) : null,
                  ),
                  WrapperSection(
                    loading: loadingData && (itineraries == null || itineraries!.isEmpty),
                    isEmpty: itineraries == null || itineraries!.isEmpty,
                    fallback: const Text('Nenhuma roteiro encontrado'),
                    child: getListItemWidgets(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}