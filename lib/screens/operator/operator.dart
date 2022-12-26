import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:guatah/constants/colors.dart';
import 'package:guatah/models/operator.dart';
import 'package:guatah/services/remote_service.dart';
import 'package:guatah/widgets/custom_app_bar.dart';
import 'package:guatah/widgets/rounded_item.dart';
import 'package:ionicons/ionicons.dart';
import 'package:url_launcher/url_launcher.dart';

class OperatorPage extends StatefulWidget {
  final String id;

  const OperatorPage({super.key, required this.id});

  @override
  _OperatorPageState createState() => _OperatorPageState();
}

class _OperatorPageState extends State<OperatorPage> {
  Operator? operator;
  bool loadingData = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    log('operator id: ', error: widget.id);
    operator = await RemoteService().getOperator(id: widget.id);
    if (operator != null) {
      log("debug message (operator)", error: operator!.name);
      setState(() {
        loadingData = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: 180,
              decoration: operator !=  null ? BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(operator!.image_url),
                  fit: BoxFit.cover,
                ),
              ) : null,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).viewPadding.top,
            right: 0,
            left: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const CustomAppBar(
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: 160,
            child: Container(
              width: MediaQuery.of(context).size.width,
              // height: double.maxFinite,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: operator !=  null ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          operator!.name,
                          style: const TextStyle(
                            color: primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          operator!.type.toUpperCase(),
                          style: const TextStyle(
                            color: mediumGreyColor,
                            fontSize: 12,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: Column(
                            children: [
                              Text(
                                operator!.description ?? '',
                                style: const TextStyle(
                                  color: textColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 24, bottom: 16),
                          child: (operator!.instagram != null && operator!.instagram != '')
                            || (operator!.whatsapp != null && operator!.whatsapp != '')
                            || (operator!.site != null && operator!.site != '')
                            ? Text(
                              '${operator!.name} nas redes',
                              style:  const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ) : null,
                        ),
                        Container(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(right: 24.0),
                                child: operator!.instagram != null && operator!.instagram != '' ? GestureDetector(
                                  onTap: () => _launchURL(operator!.instagram ?? ''),
                                  child: const RoundedItem(
                                    title: 'Instagram',
                                    imageUrl: 'http://store-images.s-microsoft.com/image/apps.31997.13510798887167234.6cd52261-a276-49cf-9b6b-9ef8491fb799.30e70ce4-33c5-43d6-9af1-491fe4679377',
                                  ),
                                ) : null,
                              ),
                              Container(
                                padding: const EdgeInsets.only(right: 24.0),
                                child: operator!.whatsapp != null && operator!.whatsapp != '' ? GestureDetector(
                                  onTap: () => _launchURL(operator!.whatsapp ?? ''),
                                  child: const RoundedItem(
                                    title: 'Whatsapp',
                                    imageUrl: 'http://store-images.s-microsoft.com/image/apps.8985.13655054093851568.1c669dab-3716-40f6-9b59-de7483397c3a.8b1af40f-2a98-4a00-98cd-94e485a04427',
                                  ),
                                ) : null,
                              ),
                              Container(
                                padding: const EdgeInsets.only(right: 24.0),
                                child: operator!.site != null && operator!.site != '' ? GestureDetector(
                                  onTap: () => _launchURL(operator!.site ?? ''),
                                  child: const RoundedItem(
                                    title: 'Site',
                                    imageUrl: 'https://www.freepnglogos.com/uploads/logo-website-png/logo-website-website-icon-with-png-and-vector-format-for-unlimited-22.png',
                                  ),
                                ) : null,
                              ),
                            ],
                          ),
                        ),
                      ]
                    ),
                  ),
                ],
              ) : null,
            ),
          ),
        ],
      ),
    );
  }
}

_launchURL(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $url';
  }
}
