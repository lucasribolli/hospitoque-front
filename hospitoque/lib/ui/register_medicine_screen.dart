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
    BlocProvider.of<RegisterMedicineBloc>(context)
        .add(RegisterMedicineResetEvent());
    return BaseScreen(
      title: Constants.REGISTER_MEDICINE,
      child: BlocBuilder<RegisterMedicineBloc, RegisterMedicineState>(
        builder: (context, state) {
          return Column(
            children: [
              _SimpleField(
                name: 'Nome do Medicamento*',
                hintText: 'Tylenol...',
                onChangeText: (value) =>
                    BlocProvider.of<RegisterMedicineBloc>(context)
                        .add(RegisterMedicineChangeNameEvent(value)),
              ),
              _SimpleField(
                name: 'Fabricante*',
                hintText: 'Johnson & Johnson...',
                onChangeText: (value) =>
                    BlocProvider.of<RegisterMedicineBloc>(context)
                        .add(RegisterMedicineChangeManufacturerEvent(value)),
              ),
              _ListFields(
                name: 'Composição*',
                fields: state.composition,
              )
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

  const _SimpleField({
    Key? key,
    required this.name,
    required this.hintText,
    required this.onChangeText,
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
        ),
      ],
    );
  }
}

class _ListFields extends StatelessWidget {
  final String name;
  final List<RegisterMedicineField> fields;
  const _ListFields({
    Key? key,
    required this.fields,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name),
        ...fields.map((field) {
          return _ListFieldItem(
            key: Key(field.id!),
            hintText: 'Placetamol...',
            icon: field.enabled ? Icons.add : Icons.delete,
            isEnabled: field.enabled,
            onButtonPressed: () {
              var event = field.enabled
                  ? RegisterMedicineAddCompositionEvent()
                  : RegisterMedicineDeleteCompositionEvent(field);
              BlocProvider.of<RegisterMedicineBloc>(context, listen: false)
                  .add(event);
            },
            onChangeText: (value) =>
                BlocProvider.of<RegisterMedicineBloc>(context).add(
              RegisterMedicineChangeLastCompositionEvent(value),
            ),
          );
        }).toList(),
      ],
    );
  }
}

class _ListFieldItem extends StatelessWidget {
  final String hintText;
  final void Function(String) onChangeText;
  final bool isEnabled;
  final IconData icon;
  final VoidCallback onButtonPressed;

  const _ListFieldItem({
    Key? key,
    required this.hintText,
    required this.onChangeText,
    required this.isEnabled,
    required this.icon,
    required this.onButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 7,
          child: HospitoqueTextField(
            autofocus: false,
            hintText: hintText,
            onChanged: onChangeText,
            enabled: isEnabled,
          ),
        ),
        Flexible(
          flex: 1,
          child: IconButton(
            icon: Icon(icon),
            onPressed: onButtonPressed,
          ),
        )
      ],
    );
  }
}
