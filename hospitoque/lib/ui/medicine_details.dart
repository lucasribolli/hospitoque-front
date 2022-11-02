import 'package:flutter/material.dart';
import 'package:hospitoque/model/medicine.dart';
import 'package:hospitoque/ui/base_screen.dart';

class MedicineDetails extends StatelessWidget {
  final Medicine medicine;
  const MedicineDetails({Key? key, required this.medicine}) : super(key: key);

  static const int _itemFlex = 3;
  static const int _itemSpacerFlex = 1;

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Detalhes ${medicine.name}',
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(flex: _itemSpacerFlex),
            Flexible(
              flex: _itemFlex,
              child: _RowDetail(
                field: 'Nome',
                value: medicine.name,
              ),
            ),
            Spacer(flex: _itemSpacerFlex),
            Flexible(
              flex: _itemFlex,
              child: _RowDetail(
                field: 'Fabricante',
                value: medicine.manufacturer,
              ),
            ),
            Spacer(flex: _itemSpacerFlex),
            Flexible(
              flex: _itemFlex,
              child: _RowDetail(
                field: 'Composição',
                value: medicine.composition.join(', '),
              ),
            ),
            Spacer(flex: _itemSpacerFlex),
            Flexible(
              flex: _itemFlex,
              child: _RowDetail(
                field: 'Disponíveis',
                value: medicine.name,
              ),
            ), //TODO fix wrong field
          ],
        ),
      ),
    );
  }
}

class _RowDetail extends StatelessWidget {
  final String field;
  final String value;

  const _RowDetail({Key? key, required this.field, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$field: ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(value),
      ],
    );
  }
}
