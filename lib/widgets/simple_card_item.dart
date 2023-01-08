import 'package:flutter/material.dart';
import 'package:guatah/constants/colors.dart';
import 'package:guatah/screens/operator/operator.dart';

class SimpleCardItem extends StatelessWidget {
  final String id;
  final String title;
  final String? imageUrl;
  final bool large;

  const SimpleCardItem({ super.key, required this.title, this.imageUrl, this.large = false, required this.id });

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
        width: large ? 150.0 : 90.0,
        child: Column(
          children: [
            Container(
              width: large ? 150.0 : 90.0,
              height: large ? 150.0 : 90.0,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFF5F5F5)),
                borderRadius: BorderRadius.circular(16),
              ),
              child: imageUrl != null ? ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  imageUrl!,
                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                    return Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6bkZX4V5o8QaYeLVo2nYurPqwOS4hDeVytU5BCz7NOPUC9hLp0vZDYIofJzDBpT2XHhc&usqp=CAU',
                      fit: BoxFit.fill,
                    );
                  },
                  fit: BoxFit.fill,
                ),
              ) : null,
            ),
            Container(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.0,
                  color: large ? primaryColor : const Color(0xFF565555),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
