import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospitoque/bloc/search_medicine/search_medicine_bloc.dart';
import 'package:hospitoque/model/medicine.dart';
import 'package:hospitoque/repositories/constants.dart';
import 'package:hospitoque/ui/base_screen.dart';
import 'package:hospitoque/ui/hospitoque_decorations.dart';
import 'package:hospitoque/ui/hospitoque_text_field.dart';
import 'package:hospitoque/ui/components/medicines_table.dart';
import 'package:hospitoque/ui/ui_extensions.dart';

class SearchMedicineScreen extends StatelessWidget {
  const SearchMedicineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SearchMedicineBloc>(context, listen: false)
        .add(SearchMedicineEventReset());
    return BaseScreen(
      title: Constants.SEARCH_MEDICINE,
      child: BlocBuilder<SearchMedicineBloc, SearchMedicineState>(
        buildWhen: (previous, current) =>
            previous.medicines != current.medicines,
        builder: (context, state) {
          debugPrint('SearchMedicineScreen state -> $state');
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: context.layoutWidth(5)),
            child: Column(
              children: [
                kIsWeb ? _TextField() : _Medicines(medicines: state.medicines),
                kIsWeb ? _Medicines(medicines: state.medicines) : _TextField(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _Medicines extends StatelessWidget {
  final List<Medicine> medicines;
  const _Medicines({Key? key, required this.medicines}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: kIsWeb ? 6 : 4,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: context.layoutHeight(5)),
        child: medicines.isNotEmpty
            ? MedicineTable(
                medicines: medicines,
              )
            : const _EmptyListState(),
      ),
    );
  }
}

class _EmptyListState extends StatelessWidget {
  const _EmptyListState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(flex: 1),
        Container(
          alignment: Alignment.center,
          width: context.layoutWidth(context.isLargeWidth ? 25 : 55),
          decoration: HospitoqueDecorations.roundedBorder(context),
          padding: EdgeInsets.all(context.layoutHeight(5)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Pesquise medicamentos por:\n',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('  \u2022 Nome\n'
                  '  \u2022 Fabricanete\n'
                  '  \u2022 Componente')
            ],
          ),
        ),
        Spacer(flex: 1),
      ],
    );
  }
}

class _TextField extends StatefulWidget {
  const _TextField({Key? key}) : super(key: key);

  @override
  State<_TextField> createState() => _TextFieldState();
}

class _TextFieldState extends State<_TextField> {
  FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    String _keyword = '';
    return Expanded(
      flex: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 9,
            child: HospitoqueTextField(
              focusNode: _focusNode,
              autofocus: false,
              hintText: 'Digite aqui...',
              onChanged: (value) => _keyword = value,
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              iconSize: context.layoutHeight(3.5),
              onPressed: () =>
                  BlocProvider.of<SearchMedicineBloc>(context, listen: false)
                      .add(SearchMedicineEventKeyword(keyword: _keyword)),
              icon: const Icon(Icons.search),
            ),
          ),
        ],
      ),
    );
  }
}
