import 'dart:convert';

class IncomingCategory {
  final String id;
  final String categoryName;
  final String categoryDescription;
  IncomingCategory({
    required this.id,
    required this.categoryName,
    required this.categoryDescription,
  });

  IncomingCategory copyWith({
    String? id,
    String? categoryName,
    String? categoryDescription,
  }) {
    return IncomingCategory(
      id: id ?? this.id,
      categoryName: categoryName ?? this.categoryName,
      categoryDescription: categoryDescription ?? this.categoryDescription,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'categoryName': categoryName,
      'categoryDescription': categoryDescription,
    };
  }

  factory IncomingCategory.fromMap(Map<String, dynamic> map) {
    return IncomingCategory(
      id: map['id'] as String,
      categoryName: map['categoryName'] as String,
      categoryDescription: map['categoryDescription'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory IncomingCategory.fromJson(String source) =>
      IncomingCategory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'IncomingCategory(id: $id, categoryName: $categoryName, categoryDescription: $categoryDescription)';

  @override
  bool operator ==(covariant IncomingCategory other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.categoryName == categoryName &&
        other.categoryDescription == categoryDescription;
  }

  @override
  int get hashCode =>
      id.hashCode ^ categoryName.hashCode ^ categoryDescription.hashCode;
}
