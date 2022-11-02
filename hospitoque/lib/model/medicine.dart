import 'dart:convert';

class Medicine {
  String id;
  String name;
  String manufacturer;
  List<String> composition;
  List<String> variant;
  String creationDate;
  
  Medicine({
    required this.id,
    required this.name,
    required this.manufacturer,
    required this.composition,
    required this.variant,
    required this.creationDate,
  });

  factory Medicine.fromMap(Map<String, dynamic> map) {
    return Medicine(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      manufacturer: map['manufacturer'] ?? '',
      composition: List<String>.from(map['composition']),
      variant: List<String>.from(map['variant']),
      creationDate: map['creationDate'] ?? '',
    );
  }

  factory Medicine.fromJson(String source) => Medicine.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Medicine(id: $id, name: $name, manufacturer: $manufacturer, composition: $composition, variant: $variant, creationDate: $creationDate)';
  }
}
