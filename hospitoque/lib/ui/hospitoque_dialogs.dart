import 'package:flutter/material.dart';
import 'package:hospitoque/ui/ui_extensions.dart';

void showHospitoqueDialog(BuildContext context, {
  required Widget content,
}) =>
    showDialog(
      context: context,
      builder: (context) =>
          Material(
            color: Colors.transparent,
            child: Container(
              margin: EdgeInsets.symmetric(
                vertical: context.layoutHeight(50),
                horizontal: context.layoutHeight(40),),
              child: content,
            ),
          ),
    );
