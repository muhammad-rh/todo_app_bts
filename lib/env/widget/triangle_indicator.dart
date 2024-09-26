import 'package:flutter/material.dart';

class TriangleTabIndicator extends Decoration {
  final BoxPainter _painter;

  TriangleTabIndicator({required Color color, required double width})
      : _painter = _TrianglePainter(color, width);

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _painter;
  }
}

class _TrianglePainter extends BoxPainter {
  final Paint _paint;
  final double width;

  _TrianglePainter(Color color, this.width)
      : _paint = Paint()
          ..color = color
          ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final left = offset.dx + (configuration.size!.width / 2) - (width / 2);
    final top = offset.dy + configuration.size!.height - 10;
    final middle = offset.dx + (configuration.size!.width / 2);
    final triangle = Path()
      ..moveTo(left, top + 10)
      ..lineTo(left + width, top + 10)
      ..lineTo(middle, top)
      ..close();
    canvas.drawPath(triangle, _paint);
  }
}
