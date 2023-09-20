import 'dart:convert';

import 'package:equatable/equatable.dart';

class IngredientModel with EquatableMixin {
  final String title;
  final String useBy;
  bool selected;
  IngredientModel({
    required this.title,
    required this.useBy,
    this.selected = false,
  });

  IngredientModel copyWith({String? title, String? useBy, bool? selected}) {
    return IngredientModel(
      title: title ?? this.title,
      useBy: useBy ?? this.useBy,
      selected: selected ?? this.selected,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'use-by': useBy,
    };
  }

  factory IngredientModel.fromMap(Map<String, dynamic> map) {
    return IngredientModel(
      title: map['title'] ?? '',
      useBy: map['use-by'] ?? '',
    );
  }

  // bool get isSelected => selected;
  // set isSelected(bool val) => selected = val;

  String toJson() => json.encode(toMap());

  factory IngredientModel.fromJson(String source) =>
      IngredientModel.fromMap(json.decode(source));

  @override
  String toString() => 'Ingredientsmodel(title: $title, useBy: $useBy)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is IngredientModel &&
        other.title == title &&
        other.useBy == useBy;
  }

  @override
  int get hashCode => title.hashCode ^ useBy.hashCode;

  @override
  List<Object?> get props => [
        title,
        useBy,
        selected,
      ];
}
