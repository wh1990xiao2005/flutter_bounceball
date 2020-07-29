import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Ball extends CustomPainter {
  Paint _paint;

  double _x, _y, _size;

  Ball(double x, double y, double size, Color color) {
    _paint = new Paint();
    _paint.isAntiAlias = true;
    _paint.color = color;
    this._x = x;
    this._y = y;
    this._size = size;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawOval(
        Rect.fromCenter(center: Offset(_x, _y), width: _size, height: _size),
        _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
