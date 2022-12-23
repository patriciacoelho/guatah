import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:guatah/constants/colors.dart';
import 'package:guatah/models/itinerary.dart';
import 'package:guatah/services/remote_service.dart';
import 'package:guatah/widgets/custom_app_bar.dart';
import 'package:guatah/widgets/custom_input.dart';
import 'package:guatah/widgets/custom_radio_group.dart';
import 'package:guatah/widgets/custom_select_input.dart';
import 'package:ionicons/ionicons.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Itinerary>? itineraries;
  bool loadingData = true;

  final List<Option> _durationOptions = [
    Option(text: '1 dia', value: 'bate-volta'),
    Option(text: '2 dias', value: 'fim-de-semana'),
    Option(text: '+3 dias', value: 'ferias'),
  ];

  final List<Option> _intervalOptions = [
    Option(text: 'Esse mês', value: 'esse-mes'),
    Option(text: 'Essa semana', value: 'essa-semana'),
  ];

  Option? _durationSelected;
  Option? _intervalSelected;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAppBar(pageTitle: 'Busca'),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: const CustomSelectInput(
                labelText: 'Cidade',
                hintText: 'Selecionar cidade',
                prefixIcon: Ionicons.location,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 16),
              child: const CustomInput(
                hintText: 'Buscar destino',
                labelText: 'Destino',
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 16),
              child: const CustomSelectInput(
                hintText: 'Selecionar empresa',
                labelText: 'Empresa',
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 16),
              child: CustomRadioGroup(
                labelText: 'Período',
                items: _intervalOptions,
                onChanged: (value) {
                  setState(() {
                    _intervalSelected = value;
                  });
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 16),
              child: CustomRadioGroup(
                labelText: 'Duração',
                items: _durationOptions,
                onChanged: (value) {
                  setState(() {
                    _durationSelected = value;
                  });
                },
              ),
            ),
            Text(_durationSelected?.value ?? (_durationSelected?.text ?? '')),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 32.0),
            child: ElevatedButton(
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
              child: const Text('Filtrar'),
            ),
          ),
        ]),
    );
  }
}