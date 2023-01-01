import 'package:flutter/material.dart';
import 'package:guatah/constants/colors.dart';
import 'package:ionicons/ionicons.dart';

class TripTagDialog extends StatelessWidget {
  final bool? small;
  const TripTagDialog({super.key, this.small = false });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Já conhece ou deseja conhecer esse roteiro?'),
          content: Container(
            height: 108,
            child: Column(
              children: [
                OutlinedButton(
                  onPressed: () => {},
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
                  onPressed: () => {},
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
