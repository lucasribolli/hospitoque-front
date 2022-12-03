import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospitoque/bloc/discard_medicine/discard_medicine_bloc.dart';
import 'package:hospitoque/ui/base_screen.dart';
import 'package:hospitoque/ui/components/hospitoque_icons.dart';
import 'package:hospitoque/ui/components/selectable_medicine_table.dart';
import 'package:hospitoque/ui/hospitoque_text_field.dart';
import 'package:hospitoque/ui/routes.dart';
import 'package:hospitoque/ui/ui_extensions.dart';

class DiscardMedicinesScreen extends StatelessWidget {
  const DiscardMedicinesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DiscardMedicineBloc>(context, listen: false)
        .add(ListAllMedicinesEvent());
    return BaseScreen(
      child: BlocBuilder<DiscardMedicineBloc, DiscardMedicineState>(
          builder: (context, state) {
        if (state.status.isSelect) {
          return Padding(
            padding: EdgeInsets.all(context.layoutWidth(6)),
            child: _SelectWidgetStatus(
              medicines: state.medicines,
              onDelete: _delete,
            ),
          );
        } else if (state.status.isReason) {
          return Padding(
            padding: EdgeInsets.all(context.layoutWidth(6)),
            child: _ReasonWidgetStatus(onDelete: _delete),
          );
        }
        return Padding(
          padding: EdgeInsets.all(context.layoutWidth(6)),
          child: _DeletedWidgetStatus(),
        );
      }),
    );
  }

  void _delete(BuildContext context) {
    BlocProvider.of<DiscardMedicineBloc>(context, listen: false)
        .add(DeleteAllSelectedEvent());
  }
}

class _SelectWidgetStatus extends StatelessWidget {
  final List<DiscartableMedicine> medicines;
  final void Function(BuildContext) onDelete;

  const _SelectWidgetStatus({
    Key? key,
    required this.medicines,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 10,
          child: SelectableMedicineTable(
            medicines: medicines,
          ),
        ),
        Expanded(
          flex: 1,
          child: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => onDelete(context),
          ),
        )
      ],
    );
  }
}

class _ReasonWidgetStatus extends StatefulWidget {
  final void Function(BuildContext) onDelete;

  const _ReasonWidgetStatus({
    Key? key,
    required this.onDelete,
  }) : super(key: key);

  @override
  State<_ReasonWidgetStatus> createState() => _ReasonWidgetStatusState();
}

class _ReasonWidgetStatusState extends State<_ReasonWidgetStatus> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Spacer(flex: 1),
        Expanded(
          flex: 2,
          child: Text(
            'Você pretende descartar medicamentos fora do prazo de validade.\n'
            'Por isso, é necessário inserir um motivo.',
            style: _getTitleStyle(context),
            textAlign: TextAlign.center,
          ),
        ),
        Spacer(flex: 1),
        Expanded(
          flex: 6,
          child: HospitoqueTextField(
            controller: _controller,
            hintText: 'Motivo...',
            autofocus: false,
            type: TextInputType.multiline,
            maxLines: kIsWeb ? 5 : 3,
            onChanged: (reason) =>
                BlocProvider.of<DiscardMedicineBloc>(context, listen: false)
                    .add(ReasonChangedEvent(reason)),
          ),
        ),
        Expanded(
          flex: 1,
          child: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => widget.onDelete(context),
          ),
        ),
      ],
    );
  }
}

class _DeletedWidgetStatus extends StatelessWidget {
  const _DeletedWidgetStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Spacer(flex: 1),
            Flexible(
              flex: 2,
              child: Text(
                'Medicamentos descartados com sucesso!',
                textAlign: TextAlign.center,
                style: _getTitleStyle(context),
              ),
            ),
            Spacer(flex: 1),
            Expanded(
              flex: 8,
              child: HospitoqueSuccessfulIcon(),
            ),
            Spacer(flex: 1),
            Flexible(
              flex: 1,
              child: ElevatedButton(
                child: Text('Encerrar Descarte'),
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                    context, HospitoqueRouter.HOME_ROUTE, (route) => false),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

_getTitleStyle(BuildContext context) => kIsWeb
    ? Theme.of(context).textTheme.displaySmall
    : Theme.of(context).textTheme.titleMedium;
