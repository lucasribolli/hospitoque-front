class Medicine {
  String id;
  String name;
  String manufacturer;
  List<String> composition;
  List<String> variant;
  String creationDate;
  int available;
  
  Medicine({
    required this.id,
    required this.name,
    required this.manufacturer,
    required this.composition,
    required this.variant,
    required this.creationDate,
    required this.available,
  });

  factory Medicine.fromMap(Map<String, dynamic> map) {
    return Medicine(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      manufacturer: map['manufacturer'] ?? '',
      composition: List<String>.from(map['composition']),
      variant: List<String>.from(map['variant']),
      creationDate: map['creationDate'] ?? '',
      available: map['available']?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'manufacturer': manufacturer});
    result.addAll({'composition': composition});
    result.addAll({'variant': variant});
    result.addAll({'creationDate': creationDate});
    result.addAll({'available': available});
  
    return result;
  }

  @override
  String toString() {
    return 'Medicine(id: $id, name: $name, manufacturer: $manufacturer, composition: $composition, variant: $variant, creationDate: $creationDate, available: $available)';
  }
}
