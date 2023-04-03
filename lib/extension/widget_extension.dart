import 'package:flutter/material.dart';

extension WidgetExtenion on Widget {

  Padding addPadding({double top = 0, double left = 0, double right = 0, double bottom = 0}) {

    return Padding(padding: EdgeInsets.only(top: top, left: left, right: right, bottom: bottom), child: this);
  }
}