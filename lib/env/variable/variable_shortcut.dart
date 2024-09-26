import 'package:flutter/material.dart';

BorderRadius radiusOn(
        {Radius topLeft = Radius.zero,
        Radius topRight = Radius.zero,
        Radius bottomLeft = Radius.zero,
        Radius bottomRight = Radius.zero}) =>
    BorderRadius.only(
        topLeft: topLeft,
        topRight: topRight,
        bottomRight: bottomRight,
        bottomLeft: bottomLeft);
BorderRadius radiusAll(Radius radius) => BorderRadius.all(radius);
Radius circular(double radius) => Radius.circular(radius);
EdgeInsets insetAll(double value) => EdgeInsets.all(value);
EdgeInsets insetOn(
        {double left = 0,
        double top = 0,
        double right = 0,
        double bottom = 0}) =>
    EdgeInsets.only(left: left, top: top, right: right, bottom: bottom);
EdgeInsets inset(double left, double top, double right, double bottom) =>
    EdgeInsets.fromLTRB(left, top, right, bottom);
EdgeInsets insetAxis({double x = 0, double y = 0}) =>
    EdgeInsets.symmetric(horizontal: x, vertical: y);
Color mixColor(Color first, Color second, double transparency) =>
    Color.lerp(first, second, transparency)!;
LinearGradient gradient(Color first, Color second,
        {Axis axis = Axis.vertical}) =>
    LinearGradient(
        colors: [first, second],
        begin:
            axis == Axis.vertical ? Alignment.topCenter : Alignment.centerLeft,
        end: axis == Axis.vertical
            ? Alignment.bottomCenter
            : Alignment.centerRight);
