import 'package:json_annotation/json_annotation.dart';

part 'pokemon_database_entity.g.dart';

@JsonSerializable()
class PokemonDatabaseEntity {

  @JsonKey(name: PokemonDatabaseContract.idColumn)
  final int? id;

  @JsonKey(name: PokemonDatabaseContract.englishNameColumn)
  final String englishName;

  @JsonKey(name: PokemonDatabaseContract.typesColumn)
  final String types; // Vamos armazenar os tipos como uma string JSON

  @JsonKey(name: PokemonDatabaseContract.baseStatsColumn)
  final String baseStats; // Vamos armazenar o baseStats como uma string JSON

  PokemonDatabaseEntity({
    required this.id,
    required this.englishName,
    required this.types,
    required this.baseStats,
  });

  factory PokemonDatabaseEntity.fromJson(Map<String, dynamic> json) =>
      _$PokemonDatabaseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonDatabaseEntityToJson(this);
}


abstract class PokemonDatabaseContract {
  static const String pokemonTable = "pokemon_table";  // Tabela do Pokémon
  static const String idColumn = "id";  // Coluna de ID
  static const String englishNameColumn = "englishName";  // Coluna para o nome em inglês
  static const String typesColumn = "types";  // Coluna para os tipos (armazenados como string JSON)
  static const String baseStatsColumn = "baseStats";  // Coluna para os baseStats (armazenados como string JSON)
}
