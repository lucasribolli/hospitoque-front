import 'package:flutter/material.dart';
import 'package:hospitoque/ui/auth_screen.dart';

void main() {
  runApp(const HospitoqueApp());
}

class HospitoqueApp extends StatelessWidget {
  const HospitoqueApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hospitoque',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AuthScreen(),
    );
  }
}