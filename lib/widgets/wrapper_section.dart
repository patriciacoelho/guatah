
import 'package:flutter/material.dart';
import 'package:guatah/constants/colors.dart';

class WrapperSection extends StatelessWidget {
  final String? title;
  final bool loading;
  final bool isEmpty;
  final Widget? fallback;
  final Widget? append;
  final Widget child;

  const WrapperSection({
    super.key,
    this.title,
    this.loading = false,
    this.isEmpty = false,
    this.fallback,
    this.append,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        title != null ?
          Container(
            padding: const EdgeInsets.only(top: 24.0, bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                append ?? Container(),
              ],
            ),
          ): Container(),
        Container(
          child: loading ?
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 32.0),
                  width: 35.0,
                  height: 35.0,
                  child: const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color> (primaryColor),
                  ),
                ),
              ],
            )
            : (!isEmpty ? child : fallback)
        ),
      ],
    );
  }
}
