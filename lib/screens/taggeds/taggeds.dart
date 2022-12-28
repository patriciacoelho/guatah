import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:guatah/constants/colors.dart';
import 'package:guatah/models/tagged.dart';
import 'package:guatah/services/remote_service.dart';
import 'package:guatah/widgets/custom_navigation_bar.dart';
import 'package:guatah/widgets/dash_tab_indicator.dart';
import 'package:guatah/widgets/list_item.dart';

class TaggedsPage extends StatefulWidget {
  @override
  _TaggedsPageState createState() => _TaggedsPageState();
}

class _TaggedsPageState extends State<TaggedsPage> with TickerProviderStateMixin {
  var pageIndex = 2;
  List<Tagged>? taggedList;
  bool loadingTaggedData = true;

  @override
  void initState() {
    super.initState();
    getTaggedData();
  }

  getTaggedData() async {
    taggedList = await RemoteService().getTagged();
    if (taggedList != null) {
      log("debug message", error: taggedList);
      setState(() {
        loadingTaggedData = false;
      });
    }
  }

  Widget getTaggedWishListWidget()
  {
    List<Widget> list = <Widget>[];

    for (var i = 0; i < taggedList!.length; i++) {
      if (taggedList![i].itineraryId != null) {
        list.add(
          ListItem(
            id: taggedList![i].itineraryId ?? '',
            title: taggedList![i].trip_name,
            secondaryInfo: taggedList![i].operator_name,
            extraInfo: '${taggedList![i].date} • ${taggedList![i].classification}',
            imageUrl: taggedList![i].image_url,
          ),
        );
      }
    }

    return Column(children: list);
  }

  Widget getTaggedPinupListWidget()
  {
    List<Widget> list = <Widget>[];

    for (var i = 0; i < taggedList!.length; i++) {
      if (taggedList![i].tripId != null) {
        list.add(
          ListItem( // TODO: substituir por widget simplificado
            id: taggedList![i].itineraryId ?? 'id',
            title: taggedList![i].trip_name,
            imageUrl: taggedList![i].image_url,
          ),
        );
      }
    }

    return Column(children: list);
  }

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Os lugares que já conheceu e as viagens que quer ir!',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              child: Align(
                alignment: Alignment.centerLeft,
                child: TabBar(
                  labelPadding: const EdgeInsets.only(left: 12, right: 12),
                  controller: _tabController,
                  labelStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),
                  labelColor: primaryColor,
                  unselectedLabelStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
                  unselectedLabelColor: mediumGreyColor,
                  isScrollable: true,
                  indicator: DashedTabIndicator(color: primaryColor, stroke: 3.0),
                  tabs: const [
                    Tab(text: 'Quero conhecer'),
                    Tab(text: 'Lugares que já conheci'),
                  ],
                ),
              )
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height - 202.0,
              width: double.maxFinite,
              child: TabBarView(
                controller: _tabController,
                children: [
                  SizedBox(
                    height: double.maxFinite,
                    width: double.maxFinite,
                    child: !loadingTaggedData ?
                      ListView(children: [getTaggedWishListWidget()])
                      : const Text('Nenhum item marcado'),
                  ),
                  SizedBox(
                    height: double.maxFinite,
                    width: double.maxFinite,
                    child: !loadingTaggedData ?
                      ListView(children: [getTaggedPinupListWidget()])
                      : const Text('Nenhum item marcado'),
                  ),
                ],
              )
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(current: pageIndex),
    );
  }
}