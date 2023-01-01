import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class CustomAppBar extends StatelessWidget {
  final Widget? rightWidget;
  final bool? noBackNavigation;
  final Function? rightCallback;
  final String? pageTitle;
  final Color? color; 

  const CustomAppBar({super.key,  this.rightWidget, this.noBackNavigation = false, this.rightCallback, this.pageTitle, this.color = Colors.black });

  Widget get _buildBackNavigator {
    return Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
        ),
        child: Icon(
          Ionicons.chevron_back,
          color: color,
        ),
      );
  }

  Widget get _buildGreeting {
    return Container(
      padding: const EdgeInsets.all(8),
      child: const Text(
        'Olá, Fulano',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        noBackNavigation! ?
          _buildGreeting
          : GestureDetector(
            onTap: () => Navigator.pop(context),
            child: _buildBackNavigator,
          ),
        Visibility(
          visible: pageTitle != null,
          child: Text(
            pageTitle != null ? pageTitle! : '',
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
        ),
        GestureDetector(
          onTap: rightCallback != null ? () => rightCallback : null,
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
            ),
            child: rightWidget,
          ),
        )
      ]
    );
  }
}