import 'package:flutter/material.dart';

class RoundedItem extends StatelessWidget {
  final String title;
  final String? imageUrl;
  final Function? onPressed;

  const RoundedItem({ super.key, required this.title, this.imageUrl, this.onPressed });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed != null ? () => onPressed : null,
      child: SizedBox(
        width: 60.0,
        height: 75.0,
        child: Column(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFF5F5F5)),
                borderRadius: BorderRadius.circular(25),
              ),
              child: imageUrl != null && imageUrl != '' ? ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.network(
                  imageUrl!,
                  width: 50,
                  height: 50,
                  fit: BoxFit.fill,
                ),
              ) : null,
            ),
            Flexible(
              child: Container(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Color(0xFF565555),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
