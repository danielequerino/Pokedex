/*

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:infinite_scroll_pagination/src/core/paging_controller.da
import 'package:pokedex/dados/api-internet/cliente_api.dart';rt';
import 'package:pokedex/dados/api-internet/entidade/http_paged_result.dart';
import 'package:pokedex/widgets/pokemon_card.dart';

class PokedexPage extends StatelessWidget {
  final List<Pokemon> pokemons;

  PokedexPage({required this.pokemons, required PagingController<int, PokemonEntity> pagingController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokédex'),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(8),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 0.85,
        ),
        itemCount: pokemons.length,
        itemBuilder: (context, index) {
          return PokemonCard(pokemon: pokemons[index]);
        },
      ),
    );
  }
}
*/
/*
class PokedexPage extends StatelessWidget {
  final PagingController<int, PokemonEntity> pagingController;

  const PokedexPage({Key? key, required this.pagingController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pokedex")),
      body: PagedListView<int, PokemonEntity>(
        pagingController: pagingController,
        builderDelegate: PagedChildBuilderDelegate<PokemonEntity>(
          itemBuilder: (context, item, index) {
            return ListTile(
              title: Text(item.englishName),
              subtitle: Text("ID: ${item.id}"),
            );
          },
        ),
      ),
    );
  }
}

*/
/*
import 'package:flutter/material.dart';
import 'package:pokedex/dados/api-internet/cliente_api.dart'; // Importe o ApiClient
import 'package:pokedex/dados/api-internet/entidade/http_paged_result.dart';
import 'package:provider/provider.dart'; // Importe as entidades necessárias

class PokemonPage extends StatefulWidget {
  @override
  _PokemonPageState createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
  late ApiClient _apiClient;
  List<PokemonEntity> _pokemons = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _apiClient = Provider.of<ApiClient>(context, listen: false); // Altere para o seu baseUrl
    _loadPokemons();
  }

  // Função para carregar os Pokémons
  Future<void> _loadPokemons() async {
    try {
      final pokemons = await _apiClient.getPokemons(page: 1, limit: 10);
      setState(() {
        _pokemons = pokemons ?? [];
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokémon List'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
          ? Center(child: Text('Error: $_errorMessage'))
          : ListView.builder(
        itemCount: _pokemons.length,
        itemBuilder: (context, index) {
          final pokemon = _pokemons[index];
          return ListTile(
            title: Text(pokemon.englishName),
            subtitle: Text('Types: ${pokemon.type.join(', ')}'),
          );
        },
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pokedex/dados/api-internet/entidade/http_paged_result.dart';
import 'package:pokedex/dados/repositorio/pokemon_repositorio_implementacao.dart';
import 'package:pokedex/dominio/pokemon.dart';
import 'package:pokedex/widgets/pokemon_card.dart';
import 'package:provider/provider.dart';

class PokedexPage extends StatefulWidget {
  const PokedexPage({super.key, required PagingController<int, PokemonEntity> pagingController});

  @override
  State<PokedexPage> createState() => _PokedexPageState();
}

class _PokedexPageState extends State<PokedexPage> {

  late final PokemonRepositoryImpl pokemonRepo;
  late final PagingController<int, Pokemon> _pagingController = PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    pokemonRepo = Provider.of<PokemonRepositoryImpl>(context, listen: false);
    _pagingController.addPageRequestListener(
          (pageKey) async {
        try {
          final pokemons = await pokemonRepo.getPokemons(page: pageKey, limit: 10);
          _pagingController.appendPage(pokemons, pageKey + 1);
        } catch (e) {
          _pagingController.error = e;
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pagingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokédex"),
        backgroundColor: Theme.of(context).primaryColorLight,
      ),
      body: PagedListView<int, Pokemon>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Pokemon>(
          itemBuilder: (context, pokemon, index) => PokemonCard(pokemon: pokemon), // Atualize para seu card de Pokémon
        ),
      ),
    );
  }
}