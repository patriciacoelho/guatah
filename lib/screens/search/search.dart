import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:guatah/constants/colors.dart';
import 'package:guatah/screens/results/results.dart';
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
  final searchController = TextEditingController();

  final List<Option> _durationOptions = [
    Option(text: '1 dia', value: 'bate-volta'),
    Option(text: '2 dias', value: 'final de semana'),
    Option(text: '+3 dias', value: 'viagem'),
  ];

  final List<Option> _intervalOptions = [
    Option(text: 'Esse mês', value: 'current-month'),
    Option(text: 'Essa semana', value: 'current-week'),
  ];

  Option? _durationSelected;
  Option? _intervalSelected;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        padding: const EdgeInsets.all(24.0),
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
              child: CustomInput(
                controller: searchController,
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
            CustomRadioGroup(
              labelText: 'Duração',
              items: _durationOptions,
              onChanged: (value) {
                setState(() {
                  _durationSelected = value;
                });
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 32.0),
            child: ElevatedButton(
              onPressed: () {
                final today = DateTime.now();
                var lastday;
                switch(_intervalSelected?.value) {
                case 'current-month':
                  lastday = DateTime(today.year, today.month + 1, 0);
                  break;
                case 'current-week':
                  lastday = today.add(Duration(days: 8 - today.weekday % 7));
                  break;
                default:
                  lastday = null;
                }

                final params = {
                  'search': searchController.text,
                  'start_date': "${today.year.toString()}-${today.month.toString().padLeft(2,'0')}-${today.day.toString().padLeft(2,'0')}",
                  'end_date': lastday != null ? "${lastday.year.toString()}-${lastday.month.toString().padLeft(2,'0')}-${lastday.day.toString().padLeft(2,'0')}" : null,
                  'classification': _durationSelected?.value,
                };
                log('search', error: params['search']);
                log('start_date', error: params['start_date']);
                log('end_date', error: params['end_date']);
                log('classification', error: params['classification']);

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ResultsPage(params: params)),
                );
              },
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