import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:guatah/constants/colors.dart';
import 'package:guatah/models/tagged.dart';
import 'package:guatah/services/remote_service.dart';
import 'package:guatah/widgets/custom_navigation_bar.dart';
import 'package:guatah/widgets/list_item.dart';

class TaggedsPage extends StatefulWidget {
  @override
  _TaggedsPageState createState() => _TaggedsPageState();
}

class _TaggedsPageState extends State<TaggedsPage> {
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

  // TODO - getTaggedPinupListWidget

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        padding: const EdgeInsets.all(24),
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
              padding: const EdgeInsets.only(top: 24),
              child: !loadingTaggedData ?
                getTaggedWishListWidget()
                : const Text('Nenhum item marcado'),
            )
          ],
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(current: pageIndex),
    );
  }
}