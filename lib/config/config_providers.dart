import 'package:pokedex/dados/banco-dados/dao/pokemon_dao.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:pokedex/dados/api-internet/cliente_api.dart';
import 'package:pokedex/dados/api-internet/newtork_mapper.dart';
import 'package:pokedex/dados/repositorio/pokemon_repositorio_implementacao.dart';
import 'package:pokedex/dados/banco-dados/dao/base_dao.dart';
import 'package:pokedex/dados/banco-dados/database_mapper.dart';


class ConfigureProviders {
  final List<SingleChildWidget> providers;

  ConfigureProviders({required this.providers});

  static Future<ConfigureProviders> createDependencyTree() async {

    // Criar instâncias para as dependências de Pokémon
    final api_client = ApiClient(baseUrl: "http://192.168.1.103:3000");;
    final networkMapper = NetworkMapper();
    final databaseMapper = DatabaseMapper();
    final pokemonDao = PokemonDao();

    final pokemonRepository = PokemonRepositoryImpl(
      apiClient: api_client,
      networkMapper: networkMapper,
      databaseMapper: databaseMapper,
      pokemonDao: pokemonDao,
    );

    return ConfigureProviders(providers: [
      Provider<ApiClient>.value(value: api_client),
      Provider<NetworkMapper>.value(value: networkMapper),
      Provider<DatabaseMapper>.value(value: databaseMapper),
      Provider<PokemonDao>.value(value: pokemonDao),
      Provider<PokemonRepositoryImpl>.value(value: pokemonRepository),
    ]);
  }
}