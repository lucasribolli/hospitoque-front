import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospitoque/bloc/discard_medicine/discard_medicine_bloc.dart';
import 'package:hospitoque/ui/base_screen.dart';
import 'package:hospitoque/ui/components/selectable_medicine_table.dart';
import 'package:hospitoque/ui/ui_extensions.dart';

class DiscardMedicinesScreen extends StatelessWidget {
  const DiscardMedicinesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DiscardMedicineBloc>(context, listen: false).add(ListAllMedicinesEvent());
    return BaseScreen(
      child: Padding(
        padding: EdgeInsets.all(context.layoutWidth(4)),
        child: BlocBuilder<DiscardMedicineBloc, DiscardMedicineState>(
          builder: (context, state) {
            return SelectableMedicineTable(
              medicines: state.medicines,
            );
          },
        ),
      ),
    );
  }
}
