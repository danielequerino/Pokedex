
import 'package:pokedex/dados/api-internet/entidade/http_paged_result.dart';
import 'package:pokedex/dominio/excecoes/MapperException.dart';
import 'package:pokedex/dominio/pokemon.dart';




class NetworkMapper {

  // Método para mapear uma única entidade de Pokémon da API para o modelo de domínio
  Pokemon toPokemon(PokemonEntity entity) {
    try {
      return Pokemon(
        id: int.parse(entity.id),
        name: entity.name["english"] ?? "Não encontrado",
        type: entity.type ?? [],  // Supondo que 'type' seja uma lista
        baseStats: entity.baseStats,  // Aqui, estamos passando o Map<String, int> diretamente
      );
    } catch (e) {
      throw MapperException<PokemonEntity, Pokemon>(e.toString());
    }
  }

  List<Pokemon> toPokemons(List<PokemonEntity> entities) {
    return entities.map(toPokemon).toList();
  }
  /*
  // Método para mapear uma lista de entidades de Pokémon da API para o modelo de domínio
  List<Pokemon> toPokemons(List<PokemonEntity> entities) {
    final List<Pokemon> pokemons = [];
    for (var entity in entities) {
      pokemons.add(toPokemon(entity));
    }
    return pokemons;
  }*/
}

/*
class NetworkMapper {
  // Converte uma entidade da rede em um objeto Pokemon
  Pokemon toPokemon(PokemonEntity entity) {
    try {
      final baseStats = BaseStats(
          hp: entity.base.hp,
          attack: entity.base.attack,
          defense: entity.base.defense,
          spAttack: entity.base.spAttack,
          spDefense: entity.base.spDefense,
          speed: entity.base.speed);

      return Pokemon(
        id: int.parse(entity.id),
        name: entity.name.english,
        type: entity.type ?? [],
        base: baseStats,
      );
    } catch (e) {
      throw MapperException<PokemonEntity, Pokemon>(e.toString());
    }
  }

  // Converte uma lista de entidades da API em uma lista de Pokemon
  List<Pokemon> toPokemons(List<PokemonEntity> entities) {
    return entities.map(toPokemon).toList();
  }
}
 */