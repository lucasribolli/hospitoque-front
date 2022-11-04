import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospitoque/bloc/register_medicine/register_medicine_bloc.dart';
import 'package:hospitoque/repositories/constants.dart';
import 'package:hospitoque/ui/base_screen.dart';
import 'package:hospitoque/ui/hospitoque_text_field.dart';

class RegisterMedicineScreen extends StatelessWidget {
  const RegisterMedicineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: Constants.REGISTER_MEDICINE,
      child: BlocBuilder<RegisterMedicineBloc, RegisterMedicineState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _SimpleField(
                name: 'Nome do Medicamento*',
                hintText: 'Tylenol...',
                onChangeText: (value) {},
              ),
              _SimpleField(
                name: 'Fabricante*',
                hintText: 'Johnson & Johnson...',
                onChangeText: (value) {},
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SimpleField extends StatelessWidget {
  final String name;
  final String hintText;
  final void Function(String) onChangeText;
  final bool isEnabled;

  const _SimpleField({
    Key? key,
    required this.name,
    required this.hintText,
    required this.onChangeText,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name),
        HospitoqueTextField(
          autofocus: false,
          hintText: hintText,
          onChanged: onChangeText,
          enabled: isEnabled,
        ),
      ],
    );
  }
}
