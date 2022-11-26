import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospitoque/bloc/list_medicine/list_medicine_bloc.dart';
import 'package:hospitoque/ui/base_screen.dart';
import 'package:hospitoque/ui/medicines_table.dart';
import 'package:hospitoque/ui/ui_extensions.dart';

class ListMedicinesScreen extends StatelessWidget {
  const ListMedicinesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      child: BlocBuilder<ListMedicineBloc, ListMedicineState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(context.layoutHeight(5)),
            child: MedicineTable(
              medicines: state.medicines,
            ),
          );
        },
      ),
    );
  }
}
