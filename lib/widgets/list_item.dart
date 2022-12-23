import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final String title;
  final String? imageUrl;
  final String? secondaryInfo;
  final String? extraInfo;
  const ListItem({ super.key, required this.title, this.imageUrl, this.secondaryInfo, this.extraInfo });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          imageUrl != null ?
            Image.network(
              imageUrl!,
              width: 90,
              height: 90,
            ) : Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF777777)),
                  borderRadius: BorderRadius.circular(16),
                ),
            ),
          Container(
            padding: const EdgeInsets.only(left: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title),
                Text(extraInfo!),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
