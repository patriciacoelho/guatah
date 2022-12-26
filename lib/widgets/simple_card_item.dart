import 'package:flutter/material.dart';
import 'package:guatah/screens/operator/operator.dart';

class SimpleCardItem extends StatelessWidget {
  final String id;
  final String title;
  final String? imageUrl;

  const SimpleCardItem({ super.key, required this.title, this.imageUrl, required this.id });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OperatorPage(id: id)),
        );
      },
      child: SizedBox(
        width: 90.0,
        child: Column(
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFF5F5F5)),
                borderRadius: BorderRadius.circular(16),
              ),
              child: imageUrl != null ? ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  imageUrl!,
                  width: 90,
                  height: 90,
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
                  fontWeight: FontWeight.w600,
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
