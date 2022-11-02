import 'package:flutter/material.dart';
import 'package:hospitoque/ui/ui_extensions.dart';

class HospitoqueDecorations {
  HospitoqueDecorations._();

  static roundedBorder(BuildContext context, {
    Color? color
  }) => BoxDecoration(
    borderRadius: BorderRadius.circular(context.layoutWidth(3)),
    color: color,
    border: Border.all(
      color: Theme.of(context).highlightColor,
      width: 3,
    ),
  );
}