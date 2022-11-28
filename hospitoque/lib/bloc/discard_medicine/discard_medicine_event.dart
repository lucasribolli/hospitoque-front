part of 'discard_medicine_bloc.dart';

@immutable
abstract class DiscardMedicineEvent {}

class ListAllMedicinesEvent extends DiscardMedicineEvent {}

class SelectMedicineEvent extends DiscardMedicineEvent {
  final DiscartableMedicine medicine;
  
  SelectMedicineEvent(this.medicine);
}

class DeleteAllSelectedEvent extends DiscardMedicineEvent {}
