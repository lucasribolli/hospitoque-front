import 'package:flutter/material.dart';
import 'package:hospitoque/main.dart';
import 'package:hospitoque/ui/ui_extensions.dart';

class HospitoqueSuccessfulIcon extends StatelessWidget {
  const HospitoqueSuccessfulIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.check_circle_sharp,
      color: Theme.of(context).successColor,
      size: context.layoutHeight(context.isLargeWidth ? 35 : 20),
    );
  }
}
