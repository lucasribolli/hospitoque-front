import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospitoque/bloc/search_medicine/search_medicine_bloc.dart';
import 'package:hospitoque/repositories/constants.dart';
import 'package:hospitoque/ui/ui_extensions.dart';

class SearchMedicineScreen extends StatefulWidget {
  const SearchMedicineScreen({Key? key}) : super(key: key);

  @override
  State<SearchMedicineScreen> createState() => _SearchMedicineScreenState();
}

class _SearchMedicineScreenState extends State<SearchMedicineScreen> {
  String _keyword = '';

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SearchMedicineBloc>(context, listen: false).add(SearchMedicineEventReset());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(Constants.APP_NAME),
      ),
      body: BlocBuilder<SearchMedicineBloc, SearchMedicineState>(
        buildWhen: (previous, current) => previous.medicines != current.medicines,
        builder: (context, state) {
          debugPrint('SearchMedicineScreen state -> $state');
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: context.layoutWidth(5)),
            child: Column(
              children: [
                Expanded(
                  flex: 5,
                  child: state.medicines.isNotEmpty 
                  ? ListView.builder(
                    itemCount: state.medicines.length,
                    itemBuilder: (context, index) {
                      var medicine = state.medicines[index];
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(medicine.id),
                          Text(medicine.name),
                          Text(medicine.manufacturer),
                        ],
                      );
                    },
                  )
                  : Container(
                    child: Text('Pesquisa'),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 8,
                        child: TextField(
                          onChanged: (value) => _keyword = value,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: IconButton(
                          onPressed: () => BlocProvider.of<SearchMedicineBloc>(context, listen: false).add(SearchMedicineEventKeyword(keyword: _keyword)),
                          icon: const Icon(Icons.search),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
