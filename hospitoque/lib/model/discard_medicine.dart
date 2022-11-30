class DiscardMedicineBody {
  final List<String> ids;
  final String? reason;

  DiscardMedicineBody({
    required this.ids,
    this.reason,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'ids': ids});
    if (reason != null) {
      result.addAll({'reason': reason});
    }

    return result;
  }
}
