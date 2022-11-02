part of 'search_medicine_bloc.dart';

@immutable
class SearchMedicineEvent {}

class SearchMedicineEventKeyword implements SearchMedicineEvent {
  final String keyword;

  SearchMedicineEventKeyword({
    required this.keyword,
  });
}

class SearchMedicineEventReset implements SearchMedicineEvent {}
