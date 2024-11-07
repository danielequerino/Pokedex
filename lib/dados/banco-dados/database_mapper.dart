import 'package:pokedex/dados/banco-dados/entidades-database/pokemon_database_entity.dart';

import '../../dominio/pokemon.dart';

class DatabaseMapper {

  Pokemon toPokemon(PokemonDatabaseEntity entity) {
    try {
      return Pokemon(
        id: entity.id!,
        name: entity.englishName,
        type: _decodeTypes(entity.types),
        baseStats: _decodeBaseStats(entity.baseStats),
      );
    } catch (e) {
      throw "Erro ao mapper de PokemonDatabaseEntity para Pokemon {e}";
    }
  }

  List<Pokemon> toPokemons(List<PokemonDatabaseEntity> entities) {
    final List<Pokemon> pokemons = [];
    for (var pokemonEntity in entities) {
      pokemons.add(toPokemon(pokemonEntity));
    }
    return pokemons;
  }

  PokemonDatabaseEntity toPokemonDatabaseEntity(Pokemon pokemon) {
    try {
      return PokemonDatabaseEntity(
        id: pokemon.id,
        englishName: pokemon.name,
        types: _encodeTypes(pokemon.type),
        baseStats: _encodeBaseStats(pokemon.baseStats),
      );
    } catch (e) {
      throw "Erro ao mapper de PokemonDatabaseEntity para Pokemon {e}";
    }
  }

  List<PokemonDatabaseEntity> toPokemonDatabaseEntities(List<Pokemon> pokemons) {
    final List<PokemonDatabaseEntity> pokemonDatabaseEntities = [];
    for (var p in pokemons) {
      pokemonDatabaseEntities.add(toPokemonDatabaseEntity(p));
    }
    return pokemonDatabaseEntities;
  }

  // Helper methods to encode and decode types and baseStats
  String _encodeTypes(List<String> types) {
    return types.join(",");  // Converte lista de tipos para uma string
  }

  List<String> _decodeTypes(String types) {
    return types.split(",");  // Converte a string de tipos de volta para uma lista
  }

  String _encodeBaseStats(Map<String, int> baseStats) {
    return baseStats.entries.map((e) => '${e.key}:${e.value}').join(",");  // Codifica como uma string "stat:value"
  }

  Map<String, int> _decodeBaseStats(String baseStats) {
    final Map<String, int> stats = {};
    final statPairs = baseStats.split(",");
    for (var statPair in statPairs) {
      final stat = statPair.split(":");
      stats[stat[0]] = int.parse(stat[1]);
    }
    return stats;  // Decodifica a string de volta para um mapa
  }
}