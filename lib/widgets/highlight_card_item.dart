import 'package:flutter/material.dart';
import 'package:guatah/constants/colors.dart';
import 'package:guatah/screens/details/details.dart';
import 'package:guatah/widgets/trip_tag_dialog.dart';
import 'package:ionicons/ionicons.dart';

class HighlightCardItem extends StatelessWidget {
  final String id;
  final String trip_id;
  final String title;
  final String? subtitle;
  final String? date;
  final String? imageUrl;

  const HighlightCardItem({ super.key, required this.title, this.imageUrl, required this.id, this.subtitle, this.date, required this.trip_id });
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailsPage(id: id)),
        );
      },
      child: SizedBox(
        width: 160.0,
        child: Column(
          children: [
            Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFF5F5F5)),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Stack(
                children: [
                  Positioned(
                    child: Container(
                      width: 160,
                      height: 160,
                      foregroundDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: const Color(0x24F25E5E),
                      ),
                      decoration: imageUrl !=  null ? BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        image: DecorationImage(
                          image: NetworkImage(imageUrl!),
                          fit: BoxFit.cover,
                        ),
                      ) : null,
                    ),
                  ),
                  Positioned(
                    top: 16,
                    right: 12,
                    child: TripTagDialog(small: true, itinerary_id: id, trip_id: trip_id),
                  ),
                  Positioned(
                    bottom: -2,
                    right: 42,
                    child: date != null ? Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 4, left: 12, right: 12, top: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Ionicons.calendar_outline,
                              color: mediumGreyColor,
                              size: 14.0,
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 4, top: 3),
                              child: Text(
                                date!.substring(0, 5),
                                style: const TextStyle(
                                  color: mediumGreyColor,
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ) : Container(),
                  ),
                ],
              ),
              
            ),
            Container(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.0,
                  color: primaryColor,
                ),
              ),
            ),
            Text(
              subtitle!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12.0,
                color: mediumGreyColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
