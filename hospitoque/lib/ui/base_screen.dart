import 'package:flutter/material.dart';
import 'package:hospitoque/repositories/constants.dart';

class BaseScreen extends StatelessWidget {
  final Widget child;
  final String title;
  const BaseScreen({ Key? key, required this.child, this.title = Constants.APP_NAME, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
      ),
      body: child,
    );
  }
}