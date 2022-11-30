import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospitoque/bloc/discard_medicine/discard_medicine_bloc.dart';
import 'package:hospitoque/ui/base_screen.dart';
import 'package:hospitoque/ui/components/selectable_medicine_table.dart';
import 'package:hospitoque/ui/hospitoque_text_field.dart';
import 'package:hospitoque/ui/ui_extensions.dart';

class DiscardMedicinesScreen extends StatelessWidget {
  const DiscardMedicinesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DiscardMedicineBloc>(context, listen: false)
        .add(ListAllMedicinesEvent());
    return BaseScreen(
      child: Padding(
        padding: EdgeInsets.all(context.layoutWidth(4)),
        child: BlocBuilder<DiscardMedicineBloc, DiscardMedicineState>(
            builder: (context, state) {
          if (state.status.isSelect) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 10,
                  child: SelectableMedicineTable(
                    medicines: state.medicines,
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _delete(context),
                  ),
                )
              ],
            );
          } else if (state.status.isReason) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Você pretende descartar medicamentos fora do prazo de validade.\n'
                    'Por isso, é necessário inserir um motivo.',
                    style: Theme.of(context).textTheme.displaySmall,
                    textAlign: TextAlign.center,
                  ),
                ),
                Spacer(flex: 1),
                Expanded(
                  flex: 7,
                  child: HospitoqueTextField(
                    hintText: 'Motivo...',
                    autofocus: false,
                    type: TextInputType.multiline,
                    maxLines: 5,
                    onChanged: (reason) => BlocProvider.of<DiscardMedicineBloc>(
                            context,
                            listen: false)
                        .add(ReasonChangedEvent(reason)),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _delete(context),
                  ),
                ),
              ],
            );
          }
          return SizedBox();
        }),
      ),
    );
  }

  void _delete(BuildContext context) {
    BlocProvider.of<DiscardMedicineBloc>(context, listen: false)
        .add(DeleteAllSelectedEvent());
  }
}
