import 'package:pokedex/dados/api-internet/entidade/http_paged_result.dart';
import 'package:pokedex/dados/banco-dados/entidades-database/pokemon_database_entity.dart';
import 'package:pokedex/dominio/excecoes/MapperException.dart';

import '../../dominio/pokemon.dart';

class DatabaseMapper {

  Pokemon toPokemon(PokemonDatabaseEntity entity) {
    try {


      print("valor speed ${entity.speed}");
      final types = [
        entity.type1,
        if (entity.type2 != null) entity.type2!,
      ];

      return Pokemon(
        id: entity.id!,
        name: entity.englishName,
        type: types,
        baseStats: {
          'hp': entity.hp,
          'attack': entity.attack,
          'defense': entity.defense,
          'spAttack': entity.spAttack,
          'spDefense': entity.spDefense,
          'speed': entity.speed,
        },
      );
    } catch (e) {
      throw MapperException<PokemonEntity, Pokemon>(e.toString());
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
      print("valor hp ${pokemon.baseStats['hp']}");
      return PokemonDatabaseEntity(
        id: pokemon.id,
        englishName: pokemon.name,
        type1: pokemon.type[0],
        type2: pokemon.type.length > 1
            ? pokemon.type[1]
            : null, // Pega o segundo tipo se existir
        hp: pokemon.baseStats['hp'] ?? 10,
        attack: pokemon.baseStats['attack'] ?? 15,      // Garantir que não seja nulo
        defense: pokemon.baseStats['defense'] ?? 20,    // Garantir que não seja nulo
        spAttack: pokemon.baseStats['spAttack'] ?? 30,  // Garantir que não seja nulo
        spDefense: pokemon.baseStats['spDefense'] ?? 40,// Garantir que não seja nulo
        speed: pokemon.baseStats['speed'] ?? 50,
      );
    } catch (e) {
      throw MapperException<PokemonEntity, Pokemon>(e.toString());
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