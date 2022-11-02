import 'package:flutter/material.dart';
import 'package:hospitoque/repositories/constants.dart';
import 'package:hospitoque/ui/base_screen.dart';

class RegisterMedicineScreen extends StatelessWidget {
  const RegisterMedicineScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: Constants.REGISTER_MEDICINE,
      child: Text('aa'),
    );
  }
}