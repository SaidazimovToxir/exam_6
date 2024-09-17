import 'dart:convert';

import 'package:exam_6/data/models/incoming_category.dart';

class IncomeModel {
  final String id;
  final String description;
  final double amount;
  final DateTime date;
  final String incomingCategory;
  IncomeModel({
    required this.id,
    required this.description,
    required this.amount,
    required this.date,
    required this.incomingCategory,
  });

  IncomeModel copyWith({
    String? id,
    String? description,
    double? amount,
    DateTime? date,
    String? incomingCategory,
  }) {
    return IncomeModel(
      id: id ?? this.id,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      incomingCategory: incomingCategory ?? this.incomingCategory,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'description': description,
      'amount': amount,
      'date': date.millisecondsSinceEpoch,
      'incomingCategory': incomingCategory,
    };
  }

  factory IncomeModel.fromMap(Map<String, dynamic> map) {
    return IncomeModel(
      id: map['id'] as String,
      description: map['description'] as String,
      amount: map['amount'] as double,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      incomingCategory: map['incomingCategory'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory IncomeModel.fromJson(String source) =>
      IncomeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'IncomeModel(id: $id, description: $description, amount: $amount, date: $date, incomingCategory: $incomingCategory)';
  }

  @override
  bool operator ==(covariant IncomeModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.description == description &&
        other.amount == amount &&
        other.date == date &&
        other.incomingCategory == incomingCategory;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        description.hashCode ^
        amount.hashCode ^
        date.hashCode ^
        incomingCategory.hashCode;
  }
}


