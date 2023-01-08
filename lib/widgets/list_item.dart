import 'package:flutter/material.dart';
import 'package:guatah/constants/colors.dart';
import 'package:guatah/screens/details/details.dart';
import 'package:ionicons/ionicons.dart';

class ListItem extends StatelessWidget {
  final String id;
  final String title;
  final String? imageUrl;
  final String? secondaryInfo;
  final String? extraInfo;
  const ListItem({ super.key, required this.title, this.imageUrl, this.secondaryInfo = '', this.extraInfo = '', required this.id });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetailsPage(id: id)),
          );
        },
        child: Row(
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
              width: MediaQuery.of(context).size.width - 146,
              height: 90.0,
              padding: const EdgeInsets.only(left: 12, bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    secondaryInfo!,
                    style: const TextStyle(
                      color: mediumGreyColor,
                      fontSize: 12,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Ionicons.calendar_outline,
                        color: mediumGreyColor,
                        size: 14.0,
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 5, left: 4),
                        child: Text(
                          extraInfo!,
                          style: const TextStyle(
                            color: mediumGreyColor,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
