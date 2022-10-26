import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hospitoque/bloc/search_medicine/search_medicine_bloc.dart';
import 'package:hospitoque/repositories/constants.dart';
import 'package:hospitoque/ui/ui_extensions.dart';

class SearchMedicineScreen extends StatelessWidget {
  const SearchMedicineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(Constants.APP_NAME),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.layoutWidth(5)),
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: BlocBuilder<SearchMedicineBloc, SearchMedicineState>(
                builder: (context, state) {
                  return ListView.builder(
                    itemCount: state.medicines?.length,
                    itemBuilder: (context, index) {
                      if(state.medicines == null) {
                        return const SizedBox();
                      }
                      var medicine = state.medicines![index];
                      return ListTile(
                        title: Text(medicine.name),
                      );
                    },
                  );
                },
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 7,
                    child: TextField(),
                  ),
                  Expanded(
                    flex: 2,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.search),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
