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
        child: Column(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFF5F5F5)),
                borderRadius: BorderRadius.circular(25),
              ),
              child: imageUrl != null ? ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.network(
                  imageUrl!,
                  width: 50,
                  height: 50,
                  fit: BoxFit.fill,
                ),
              ) : null,
            ),
            Container(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Color(0xFF565555),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
