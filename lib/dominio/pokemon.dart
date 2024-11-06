/*
class Pokemon {
  final int id;
  final String englishName;
  final List<String> type;
  final Map<String, int> baseStats; // Alterado para Map

  Pokemon({
    required this.id,
    required this.englishName,
    required this.type,
    required this.baseStats,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: int.parse(json['id']), // Converte ID para int
      englishName: json['name']['english'],
      type: List<String>.from(json['type']),
      baseStats: Map<String, int>.from(json['base'].map((key, value) => MapEntry(key, value))),
    );
  }
}*/

import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon.freezed.dart';

@freezed
class Pokemon with _$Pokemon {
  const factory Pokemon({
    required int id,
    required String englishName,
    required List<String> type,
    required Map<String, int> baseStats, // Usando Map conforme solicitado
  }) = _Pokemon;
}
