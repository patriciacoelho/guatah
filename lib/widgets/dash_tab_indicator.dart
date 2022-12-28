import 'package:flutter/material.dart';

class DashedTabIndicator extends Decoration {
  final Color color;
  double stroke;

  DashedTabIndicator({ required this.color, required this.stroke });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _DashedPainter(color: color, stroke: stroke);
  }
}

class _DashedPainter extends BoxPainter {
  final Color color;
  double stroke;

  _DashedPainter({ required this.color, required this.stroke });

  @override
  void paint(
    Canvas canvas,
    Offset offset,
    ImageConfiguration configuration
  ) {
    Paint _paint = Paint();
    _paint.color = color;
    _paint.isAntiAlias  = true;
    _paint.strokeWidth = stroke;
    _paint.strokeCap = StrokeCap.round;

    const offsetX = 12.0;
    final offsetY = configuration.size!.height - stroke * 2;

    final largeDashWidth = (configuration.size!.width - offsetX) * 0.28;
    final smallDashWidth = (configuration.size!.width - offsetX) * 0.15;
    final largeSpace = (configuration.size!.width - offsetX) * 0.24;
    final smallSpace = (configuration.size!.width - offsetX) * 0.08;
    final Offset dashP1Offset = Offset(offsetX, offsetY);
    final Offset dashP2Offset = Offset(offsetX + largeDashWidth, offsetY);
    final Offset smallDashP1Offset = Offset(offsetX, offsetY);
    final Offset smallDashP2Offset = Offset(offsetX + smallDashWidth, offsetY);
    final Offset space1 = Offset(largeDashWidth + largeSpace, 0);
    final Offset space2 = Offset(smallDashWidth + smallSpace, 0);

    canvas.drawLine(
      offset + dashP1Offset,
      offset + dashP2Offset,
      _paint
    );
    canvas.drawLine(
      offset + space1 + smallDashP1Offset,
      offset + space1 + smallDashP2Offset,
      _paint
    );
    canvas.drawLine(
      offset + space1 + dashP1Offset + space2,
      offset + space1 + dashP2Offset + space2,
      _paint
    );
  }
}
