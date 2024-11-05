import 'BaseStats.dart';

class Pokemon {
  final int id;
  final String englishName;
  final List<String> type;
  final BaseStats baseStats;

  Pokemon({
    required this.id,
    required this.englishName,
    required this.type,
    required this.baseStats,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      englishName: json['name']['english'],
      type: List<String>.from(json['type']),
      baseStats: BaseStats.fromJson(json['base']),
    );
  }
}



/*
import 'package:freezed_annotation/freezed_annotation.dart';
import 'BaseStats.dart';

part 'Pokemon.freezed.dart';
part 'Pokemon.g.dart';

@freezed
class Pokemon with _$Pokemon {
  const factory Pokemon({
    required int id,
    required String englishName, // Campo obrigatório
    required List<String> type,
    required BaseStats baseStats,
  }) = _Pokemon;

  factory Pokemon.fromJson(Map<String, dynamic> json) => _$PokemonFromJson(json);
}

*/