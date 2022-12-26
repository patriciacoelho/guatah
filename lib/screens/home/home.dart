
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:guatah/constants/colors.dart';
import 'package:guatah/models/operator.dart';
import 'package:guatah/services/remote_service.dart';
import 'package:guatah/widgets/custom_app_bar.dart';
import 'package:guatah/widgets/custom_input.dart';
import 'package:guatah/widgets/custom_navigation_bar.dart';
import 'package:guatah/widgets/simple_card_item.dart';
import 'package:ionicons/ionicons.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var pageIndex = 0;
  List<Operator>? operators;
  bool loadingOperatorsData = true;

  @override
  void initState() {
    super.initState();
    getOperatorsData();
  }

  getOperatorsData() async {
    operators = await RemoteService().getOperators();
    if (operators != null) {
      log("debug message", error: operators);
      setState(() {
        loadingOperatorsData = false;
      });
    }
  }

  Widget getOperatorList()
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAppBar(
              rightIcon: Ionicons.person_circle,
              noBackNavigation: true,
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: const Text(
                'Vamos conhecer novos lugares!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const CustomInput(
              searchType: true,
              hintText: 'Buscar lugares',
            ),
            Container(
              padding: const EdgeInsets.only(top: 24, bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    'Empresas',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Ver mais',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
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
                    children: [getOperatorList()],
                  ),
                )
                : const Text('Nenhuma empresa encontrada'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(current: pageIndex),
    );
  }
}
