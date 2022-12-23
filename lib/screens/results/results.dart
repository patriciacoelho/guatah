import 'package:flutter/material.dart';
import 'package:guatah/constants/colors.dart';
import 'package:guatah/widgets/custom_app_bar.dart';
import 'package:guatah/widgets/custom_input.dart';

class ResultsPage extends StatefulWidget {
  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
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
            const CustomInput(
              searchType: true,
              hintText: 'Buscar lugares',
            ),
            Container(
              padding: EdgeInsets.all(8),
              child: const Text(
                'Filtros aplicados',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}