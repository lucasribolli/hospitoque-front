import 'package:flutter/material.dart';
import 'package:hospitoque/model/medicine.dart';
import 'package:hospitoque/ui/base_screen.dart';
import 'package:hospitoque/ui/medicine_details.dart';

class MedicineDetailsScreen extends StatelessWidget {
  final Medicine medicine;
  const MedicineDetailsScreen({Key? key, required this.medicine})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Detalhes ${medicine.name}',
      showExitButtonOnMobile: false,
      child: MedicineDetails(
        medicine: medicine,
      ),
    );
  }
}
