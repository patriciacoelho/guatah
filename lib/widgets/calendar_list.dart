import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:guatah/constants/colors.dart';
import 'package:guatah/constants/date.dart';
import 'package:guatah/models/itinerary.dart';
import 'package:guatah/screens/details/details.dart';

class CalendarList extends StatelessWidget {
  final List<Itinerary> items;

  const CalendarList({ super.key, required this.items });

  List<Itinerary> pocketList() {
    if (items.length > 4) {
      return items.sublist(0, 4);
    }
    return items;
  }

  List<String> daysList() {
    final list = pocketList();

    var days = <String>[];
    for (var item in list) {
      var day = item.date;
      if (!days.contains(day)) {
        days.add(day);
      }
    }

    return days;
  }

  List<String> monthsList() {
    final list = daysList();

    var months = <String>[];
    for (var item in list) {
      var month = item.substring(3, 5);
      if (!months.contains(month)) {
        months.add(month);
      }
    }

    return months;
  }

  Widget calendarItemWidget(BuildContext context, Itinerary item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetailsPage(id: item.id)),
          );
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 126.0,
        margin: const EdgeInsets.only(bottom: 4.0),
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.trip_name,
              style: const TextStyle(
                color: primaryColor,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              item.operator_name,
              style: const TextStyle(
                color: mediumGreyColor,
                fontSize: 12,
              ),
            ),
          ]),
      ),
    );
  }
  
  Widget daySectionWidget(BuildContext context, String day) {
    final d = day.substring(0, 2);
    final m = day.substring(3, 5);
    log(day);
    final y = day.substring(6); // '20' + day.substring(6, 8)
    log(y);
    final datetime = DateTime(int.parse(y), int.parse(m), int.parse(d));

    final items = pocketList();

    var list = <Widget>[];
    for (var item in items) {
      var itemDate = item.date;
      if (day == itemDate) {
        list.add(calendarItemWidget(context, item));
      }
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 46.0,
          height: 46.0,
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
          margin: const EdgeInsets.only(right: 16.0),
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(23.0),
          ),
          child: Column(
            children: [
              Text(
                fancyShortWeekdayName[datetime.weekday - 1],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                d,
                style: const TextStyle(
                  height: 1.0,
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Column(
          children: list,
        ),
      ],
    );
  }

  Widget monthSectionWidget(BuildContext context, String month) {
    final days = daysList();

    var list = <Widget>[];
    for (var day in days) {
      var dayMonth = day.substring(3, 5);
      if (dayMonth == month) {
        list.add(daySectionWidget(context, day));
        list.add(const SizedBox(height: 12.0));
      }
    }

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          width: double.maxFinite,
          margin: const EdgeInsets.only(bottom: 4.0),
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius:  BorderRadius.circular(12),
          ),
          child: Text(
            fancyMonthName[month] ?? '',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: lightShadowColor,
            borderRadius: BorderRadius.circular(12)
          ),
          child: Column(
            children: list,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var list = <Widget>[];
    for (var month in monthsList()) {
      list.add(monthSectionWidget(context, month));
      list.add(const SizedBox(height: 8.0));
    }

    return Column(
      children: list,
    );
  }
}
