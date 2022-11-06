class Medicine {
  String? id;
  String name;
  String manufacturer;
  List<String> composition;
  List<String> variant;
  String? creationDate;
  int available;

  Medicine({
    required this.name,
    required this.manufacturer,
    required this.composition,
    required this.variant,
    required this.available,
    this.id,
    this.creationDate,
  });

  factory Medicine.fromMap(Map<String, dynamic> map) {
    return Medicine(
      id: map['_id'] ?? '',
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

    result.addAll({'name': name});
    result.addAll({'manufacturer': manufacturer});
    result.addAll({'composition': composition});
    result.addAll({'variant': variant});
    result.addAll({'available': available});

    return result;
  }

  @override
  String toString() {
    return 'Medicine(id: $id, name: $name, manufacturer: $manufacturer, composition: $composition, variant: $variant, creationDate: $creationDate, available: $available)';
  }

  Medicine copyWith({
    String? id,
    String? name,
    String? manufacturer,
    List<String>? composition,
    List<String>? variant,
    String? creationDate,
    int? available,
  }) {
    return Medicine(
      id: id ?? this.id,
      name: name ?? this.name,
      manufacturer: manufacturer ?? this.manufacturer,
      composition: composition ?? this.composition,
      variant: variant ?? this.variant,
      creationDate: creationDate ?? this.creationDate,
      available: available ?? this.available,
    );
  }
}
