part of 'search_medicine_bloc.dart';

@immutable
class SearchMedicineEvent {}

class SearchMedicineEventKeyword extends SearchMedicineEvent {
  final String keyword;

  SearchMedicineEventKeyword({
    required this.keyword,
  });
}
