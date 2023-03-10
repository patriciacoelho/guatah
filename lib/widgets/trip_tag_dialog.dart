import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:guatah/constants/colors.dart';
import 'package:guatah/services/remote_service.dart';
import 'package:ionicons/ionicons.dart';

class TripTagDialog extends StatelessWidget {
  final bool? small;
  final String itinerary_id;
  final String trip_id;

  const TripTagDialog({super.key, this.small = false, required this.itinerary_id, required this.trip_id });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Já conhece ou deseja conhecer esse roteiro?'),
          content: SizedBox(
            height: 108,
            child: Column(
              children: [
                OutlinedButton(
                  onPressed: () async {
                    final response = await RemoteService().createTagged({
                      'trip_id': trip_id,
                    });
                    log(response);
                    Navigator.pop(context, 'Ok');
                  },
                  style: OutlinedButton.styleFrom(
                    shape: const StadiumBorder(),
                    side: const BorderSide(color: primaryColor),
                    fixedSize: const Size(double.maxFinite, 50),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 32.0),
                  ),
                  child: const Text('Já conheço! 😎'),
                ),
                const SizedBox(height: 8.0),
                OutlinedButton(
                  onPressed: () async {
                    final response = await RemoteService().createTagged({
                      'itinerary_id': itinerary_id,
                    });
                    log(response);
                    Navigator.pop(context, 'Ok');
                  },
                  style: OutlinedButton.styleFrom(
                    shape: const StadiumBorder(),
                    side: const BorderSide(color: primaryColor),
                    fixedSize: const Size(double.maxFinite, 50),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 32.0),
                  ),
                  child: const Text('Quero conhecer! 😍'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Container(
              padding: const EdgeInsets.only(right: 16.0),
              child: TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('CANCELAR'),
              ),
            ),
          ],
        ),
      ),
      child: Icon(
        Ionicons.bookmark_outline,
        color: Colors.white,
        size: small! ? 20.0 : 24.0,
      ),
    );
  }
}
