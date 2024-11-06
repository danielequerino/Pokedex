
import 'package:pokedex/dados/api-internet/entidade/http_paged_result.dart';
import 'package:pokedex/dominio/pokemon.dart';
class NetworkMapper {

  // Método para mapear uma única entidade de Pokémon da API para o modelo de domínio
  Pokemon toPokemon(PokemonEntity entity) {
    try {
      return Pokemon(
        id: entity.id,
        englishName: entity.englishName,
        type: List<String>.from(entity.type),  // Supondo que 'type' seja uma lista
        baseStats: entity.baseStats,  // Aqui, estamos passando o Map<String, int> diretamente
      );
    } catch (e) {
      throw "Erro ao mapear de pokemon para pokemonEntity";
    }
  }

  // Método para mapear uma lista de entidades de Pokémon da API para o modelo de domínio
  List<Pokemon> toPokemons(List<PokemonEntity> entities) {
    final List<Pokemon> pokemons = [];
    for (var entity in entities) {
      pokemons.add(toPokemon(entity));
    }
    return pokemons;
  }
}