import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:guatah/constants/colors.dart';
import 'package:guatah/models/operator.dart';
import 'package:guatah/services/remote_service.dart';

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
      body: Stack(),
    );
  }
}
