import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospitoque/bloc/discard_medicine/discard_medicine_bloc.dart';
import 'package:hospitoque/main.dart';
import 'package:hospitoque/ui/routes.dart';
import 'package:hospitoque/ui/ui_extensions.dart';
import 'package:hospitoque/utils/date_formatter.dart';

class SelectableMedicineTable extends StatelessWidget {
  final int _columnFlex = 5;
  final int _checkboxFlex = 1;
  final List<DiscartableMedicine> medicines;

  const SelectableMedicineTable({
    Key? key,
    required this.medicines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 2,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Spacer(
                flex: _checkboxFlex,
              ),
              Expanded(
                flex: _columnFlex,
                child: Text(
                  'ID',
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                flex: _columnFlex,
                child: Text(
                  'Nome',
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                flex: _columnFlex,
                child: Text(
                  'Validade',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        Divider(),
        Flexible(
          flex: 9,
          child: ListView(
            children: [
              ...medicines
                  .map(
                    (m) => GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          HospitoqueRouter.MEDICINE_DETAILS_ROUTE,
                          arguments: m.medicine,
                        );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            flex: _checkboxFlex,
                            child: Checkbox(
                              activeColor: Theme.of(context).successColor,
                              value: m.selected,
                              onChanged: (selected) {
                                BlocProvider.of<DiscardMedicineBloc>(
                                  context,
                                  listen: false,
                                ).add(SelectMedicineEvent(m));
                              },
                            ),
                          ),
                          Expanded(
                            flex: _columnFlex,
                            child: _TableItem(
                              value: m.medicine.id!,
                              color: _getLineColor(m.timeToExpiration)?.color,
                              fontWeight:
                                  _getLineColor(m.timeToExpiration)?.fontWeight,
                            ),
                          ),
                          Expanded(
                            flex: _columnFlex,
                            child: _TableItem(
                              value: m.medicine.name,
                              color: _getLineColor(m.timeToExpiration)?.color,
                              fontWeight:
                                  _getLineColor(m.timeToExpiration)?.fontWeight,
                            ),
                          ),
                          Expanded(
                            flex: _columnFlex,
                            child: _TableItem(
                              value: DateFormatter.getDayFormatted(
                                m.medicine.expirationDate,
                              ),
                              color: _getLineColor(m.timeToExpiration)?.color,
                              fontWeight:
                                  _getLineColor(m.timeToExpiration)?.fontWeight,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ],
          ),
        )
      ],
    );
  }

  _LineStyle? _getLineColor(TimeToExpiration time) {
    if (time.isInPast) {
      return _LineStyle(Colors.red, FontWeight.bold);
    }
    if (time.isSameMonth) {
      return _LineStyle(Colors.orange, FontWeight.bold);
    }
    return null;
  }
}

class _TableItem extends StatelessWidget {
  final Color? color;
  final FontWeight? fontWeight;

  const _TableItem({
    Key? key,
    required this.value,
    this.color,
    this.fontWeight = FontWeight.normal,
  }) : super(key: key);
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.layoutHeight(6),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).highlightColor),
        color: color,
      ),
      child: Center(
        child: Text(
          value,
          style: TextStyle(
            fontWeight: fontWeight,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _LineStyle {
  final Color color;
  final FontWeight fontWeight;

  _LineStyle(this.color, this.fontWeight);
}
