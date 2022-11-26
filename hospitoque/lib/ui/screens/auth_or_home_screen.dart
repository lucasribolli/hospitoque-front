import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospitoque/bloc/auth/auth_bloc.dart';
import 'package:hospitoque/ui/base_screen.dart';
import 'package:hospitoque/ui/routes.dart';

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
