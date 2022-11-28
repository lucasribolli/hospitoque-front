import 'package:flutter/material.dart';
import 'package:hospitoque/model/medicine.dart';
import 'package:hospitoque/ui/routes.dart';
import 'package:hospitoque/ui/ui_extensions.dart';

class MedicineTable extends StatelessWidget {
  final int _columnFlex = 5;
  final List<Medicine> medicines;

  const MedicineTable({
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
                  'Un. Disp.',
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
                      onTap: () => _onMedicineTap(context, m),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            flex: _columnFlex,
                            child: _TableItem(
                              value: m.id!,
                            ),
                          ),
                          Expanded(
                            flex: _columnFlex,
                            child: _TableItem(
                              value: m.name,
                            ),
                          ),
                          Expanded(
                            flex: _columnFlex,
                            child: _TableItem(
                              value: m.available.toString(),
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

  void _onMedicineTap(BuildContext c, Medicine m) =>
      Navigator.pushNamed(c, HospitoqueRouter.MEDICINE_DETAILS_ROUTE,
          arguments: m);
}

class _TableItem extends StatelessWidget {
  const _TableItem({Key? key, required this.value}) : super(key: key);
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.layoutHeight(6),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).highlightColor),
      ),
      child: Center(
        child: Text(
          value,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
