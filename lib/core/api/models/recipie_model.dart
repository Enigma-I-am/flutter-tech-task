import 'dart:convert';

import 'package:equatable/equatable.dart';

class Recipiemodel with EquatableMixin {
  final String title;
  final List<String> ingredients;
  Recipiemodel({
    required this.title,
    required this.ingredients,
  });

  Recipiemodel copyWith({
    String? title,
    List<String>? ingredients,
  }) {
    return Recipiemodel(
      title: title ?? this.title,
      ingredients: ingredients ?? this.ingredients,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'ingredients': ingredients,
    };
  }

  factory Recipiemodel.fromMap(Map<String, dynamic> map) {
    return Recipiemodel(
      title: map['title'] ?? '',
      ingredients: List<String>.from(map['ingredients']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Recipiemodel.fromJson(String source) =>
      Recipiemodel.fromMap(json.decode(source));

  @override
  String toString() => 'Recipiemodel(title: $title, ingredients: $ingredients)';

  @override
  List<Object?> get props => [
        title,
        ingredients,
      ];
}
