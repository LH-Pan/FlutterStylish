import 'package:flutter/material.dart';

extension WidgetExtenion on Widget {

  Padding addPadding({double top = 0, double left = 0, double right = 0, double bottom = 0}) {

    return Padding(padding: EdgeInsets.only(top: top, left: left, right: right, bottom: bottom), child: this);
  }

  ShaderMask addGradientWith(BlendMode blendMode, Color colorOne, Color colorTwo, AlignmentGeometry begin, AlignmentGeometry end) {

    return 
      ShaderMask(
        blendMode: blendMode,
        shaderCallback: (Rect bounds) {
          return 
            LinearGradient(
              colors: [colorOne, colorTwo],
              stops: const [0.0, 1.0],
              begin: begin,
              end: end,
              tileMode: TileMode.clamp,
            ).createShader(bounds);
        },
        child: this
     );
  }
}