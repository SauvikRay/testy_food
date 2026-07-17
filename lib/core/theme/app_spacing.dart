import 'package:flutter/material.dart';

class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  
  static const double unit = 8.0;
  static const double containerMarginMobile = 16.0;
  static const double containerMarginDesktop = 48.0;
  static const double gutter = 16.0;

  // Edge Insets shortcuts
  static const EdgeInsets edgeXS = EdgeInsets.all(xs);
  static const EdgeInsets edgeSM = EdgeInsets.all(sm);
  static const EdgeInsets edgeMD = EdgeInsets.all(md);
  static const EdgeInsets edgeLG = EdgeInsets.all(lg);
  static const EdgeInsets edgeXL = EdgeInsets.all(xl);

  // Border Radius definitions
  static const double radiusSM = 4.0;
  static const double radiusDefault = 8.0;
  static const double radiusMD = 12.0;
  static const double radiusLG = 16.0;
  static const double radiusXL = 24.0;
  
  static final BorderRadius borderRadiusSM = BorderRadius.circular(radiusSM);
  static final BorderRadius borderRadiusDefault = BorderRadius.circular(radiusDefault);
  static final BorderRadius borderRadiusMD = BorderRadius.circular(radiusMD);
  static final BorderRadius borderRadiusLG = BorderRadius.circular(radiusLG);
  static final BorderRadius borderRadiusXL = BorderRadius.circular(radiusXL);
  static final BorderRadius borderRadiusCircular = BorderRadius.circular(9999.0);
}

extension HeightExtension on num {
  SizedBox get height => SizedBox(height: toDouble());
}

extension WidthExtension on num {
  SizedBox get width => SizedBox(width: toDouble());
}
