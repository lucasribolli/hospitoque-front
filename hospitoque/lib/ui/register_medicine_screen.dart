import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospitoque/bloc/register_medicine/register_medicine_bloc.dart';
import 'package:hospitoque/repositories/constants.dart';
import 'package:hospitoque/ui/base_screen.dart';
import 'package:hospitoque/ui/hospitoque_button.dart';
import 'package:hospitoque/ui/hospitoque_text_field.dart';
import 'package:hospitoque/ui/medicine_details.dart';
import 'package:hospitoque/ui/ui_extensions.dart';

class RegisterMedicineScreen extends StatelessWidget {
  const RegisterMedicineScreen({Key? key}) : super(key: key);

  final double _verticalItemsSpacer = 3;
  final int _itemFlex = 7;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<RegisterMedicineBloc>(context)
        .add(ResetRegisterMedicineEvent());
    return BaseScreen(
      title: Constants.REGISTER_MEDICINE,
      showExitButtonOnMobile: false,
      child: BlocBuilder<RegisterMedicineBloc, RegisterMedicineState>(
        builder: (context, state) {
          return Container(
            margin: EdgeInsets.symmetric(
              horizontal: context.layoutWidth(context.isLargeWidth ? 25 : 7),
              vertical: context.layoutHeight(2),
            ),
            child: Column(
              children: [
                if (state.status == RegisterMedicineCurrentStatus.initial)
                  Flexible(
                    flex: _itemFlex,
                    child: ListView(
                      children: [
                        _SimpleField(
                          name: 'Nome do Medicamento*',
                          hintText: 'Tylenol...',
                          onChangeText: (value) =>
                              BlocProvider.of<RegisterMedicineBloc>(context)
                                  .add(ChangeNameRegisterMedicineEvent(value)),
                        ),
                        SizedBox(
                            height: context.layoutHeight(_verticalItemsSpacer)),
                        _SimpleField(
                          name: 'Fabricante*',
                          hintText: 'Johnson & Johnson...',
                          onChangeText: (value) =>
                              BlocProvider.of<RegisterMedicineBloc>(context)
                                  .add(ChangeManufacturerRegisterMedicineEvent(
                                      value)),
                        ),
                        SizedBox(
                            height: context.layoutHeight(_verticalItemsSpacer)),
                        _SimpleField(
                          name: 'Unidades disponíveis*',
                          hintText: '8',
                          onChangeText: (value) =>
                              BlocProvider.of<RegisterMedicineBloc>(context)
                                  .add(ChangeAvailableRegisterMedicineEvent(
                                      value)),
                        ),
                        SizedBox(
                            height: context.layoutHeight(_verticalItemsSpacer)),
                        _ListFields(
                          name: 'Composição:*',
                          hint: 'Placetamol...',
                          fields: state.composition,
                          onButtonClick: (field) {
                            var event = field.enabled
                                ? AddCompositionRegisterMedicineEvent()
                                : DeleteCompositionRegisterMedicineEvent(field);
                            BlocProvider.of<RegisterMedicineBloc>(context,
                                    listen: false)
                                .add(event);
                          },
                          onChangeText: (value) =>
                              BlocProvider.of<RegisterMedicineBloc>(context)
                                  .add(
                            ChangeLastCompositionRegisterMedicineEvent(value),
                          ),
                        ),
                        SizedBox(
                            height: context.layoutHeight(_verticalItemsSpacer)),
                        _ListFields(
                          name: 'Variante(s):*',
                          hint: '500mg',
                          fields: state.variant,
                          onButtonClick: (field) {
                            var event = field.enabled
                                ? AddVariantRegisterMedicineEvent()
                                : DeleteVariantRegisterMedicineEvent(field);
                            BlocProvider.of<RegisterMedicineBloc>(context,
                                    listen: false)
                                .add(event);
                          },
                          onChangeText: (value) =>
                              BlocProvider.of<RegisterMedicineBloc>(context)
                                  .add(
                            ChangeLastVariantRegisterMedicineEvent(value),
                          ),
                        ),
                        SizedBox(
                          height: context.layoutHeight(_verticalItemsSpacer),
                        ),
                      ],
                    ),
                  ),
                if (state.status == RegisterMedicineCurrentStatus.confirmation)
                  Flexible(
                    flex: _itemFlex,
                    child: MedicineDetails(
                      medicine: state.medicine!,
                    ),
                  ),
                if (state.status == RegisterMedicineCurrentStatus.successful)
                  Flexible(
                    flex: _itemFlex,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          flex: 1,
                          child: MedicineDetails(
                            medicine: state.medicine!,
                          ),
                        ),
                        Flexible(
                          flex: 4,
                          child: Icon(
                            Icons.check_circle_sharp,
                            color: Theme.of(context).primaryColor,
                            size: context.layoutHeight(context.isLargeWidth ? 35 : 20),
                          ),
                        )
                      ],
                    ),
                  ),
                Flexible(
                  flex: 1,
                  child: HospitoqueButton(
                    onPressed: () =>
                        BlocProvider.of<RegisterMedicineBloc>(context).add(
                      _getButtonNextEvent(
                        context,
                        state.status,
                      ),
                    ),
                    text: _getButtonText(state.status),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _getButtonText(RegisterMedicineCurrentStatus status) {
    switch (status) {
      case RegisterMedicineCurrentStatus.initial:
        return 'Enviar Informações';
      case RegisterMedicineCurrentStatus.confirmation:
        return 'Confirmar Cadastro';
      case RegisterMedicineCurrentStatus.successful:
        return 'Encerrar Cadastro';
    }
  }

  NextClickRegisterMedicineEvent _getButtonNextEvent(
    BuildContext context,
    RegisterMedicineCurrentStatus status,
  ) {
    if (status == RegisterMedicineCurrentStatus.successful) {
      return NextClickRegisterMedicineEvent(context: context);
    }
    return NextClickRegisterMedicineEvent();
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
        SizedBox(
          height: context.layoutHeight(1.5),
        ),
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
  final String hint;
  final List<RegisterMedicineField> fields;
  final void Function(String text) onChangeText;
  final void Function(RegisterMedicineField field) onButtonClick;

  const _ListFields({
    Key? key,
    required this.fields,
    required this.name,
    required this.onChangeText,
    required this.onButtonClick,
    required this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name),
        SizedBox(
          height: context.layoutHeight(1.5),
        ),
        ...fields.map((field) {
          return _ListFieldItem(
            key: Key(field.id!),
            hintText: hint,
            icon: field.enabled ? Icons.add : Icons.delete,
            isEnabled: field.enabled,
            onButtonPressed: () => onButtonClick(field),
            onChangeText: onChangeText,
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
          flex: 10,
          child: HospitoqueTextField(
            autofocus: false,
            hintText: hintText,
            onChanged: onChangeText,
            enabled: isEnabled,
          ),
        ),
        Spacer(flex: 1),
        Flexible(
          flex: 2,
          child: IconButton(
            icon: Icon(icon),
            onPressed: onButtonPressed,
          ),
        )
      ],
    );
  }
}
