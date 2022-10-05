import 'package:flutter/cupertino.dart';

extension Responsive on BuildContext {
  double layoutHeight(double valueToTake) => height * (valueToTake / 100);
  double layoutWidth(double valueToTake) => width * (valueToTake / 100);
}

extension ScreenSize on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
}