import 'package:flutter/material.dart';
import 'package:hospitoque/ui/base_screen.dart';

class AuthOrHomeScreen extends StatelessWidget {
  const AuthOrHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: LinearProgressIndicator(),
      ),
    );
  }
}
