import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pokedex/dados/api-internet/ClienteApi.dart';
import 'package:pokedex/dominio/Pokemon.dart';
import 'package:pokedex/widgets/pokemon_card.dart';
import 'package:provider/provider.dart';

// COM PagedListView

class PokedexPage extends StatefulWidget {
  @override
  _PokedexPageState createState() => _PokedexPageState();
}

class _PokedexPageState extends State<PokedexPage> {
  late final PagingController<int, Pokemon> _pagingController;

  @override
  void initState() {
    super.initState();
    _pagingController = PagingController(firstPageKey: 0);
    _pagingController.addPageRequestListener((pageKey) async {
      try {
        // Carregar Pokémons através da API, por exemplo, usando ClienteApi
        final apiClient = Provider.of<ClienteApi>(context, listen: false);
        final pokemons = await apiClient.getPokemons(page: pageKey, limit: 10);
        final isLastPage = pokemons.length < 10;
        if (isLastPage) {
          _pagingController.appendLastPage(pokemons);
        } else {
          final nextPageKey = pageKey + 1;
          _pagingController.appendPage(pokemons, nextPageKey);
        }
      } catch (error) {
        _pagingController.error = error;
      }
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokédex'),
      ),
      body: PagedListView<int, Pokemon>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Pokemon>(
          itemBuilder: (context, pokemon, index) {
            return PokemonCard(pokemon: pokemon);
          },
        ),
      ),
    );
  }
}

// COM PagedGridView

/*
class PokedexPage extends StatefulWidget {
  @override
  _PokedexPageState createState() => _PokedexPageState();
}

class _PokedexPageState extends State<PokedexPage> {
  late final PagingController<int, Pokemon> _pagingController;

  @override
  void initState() {
    super.initState();
    _pagingController = PagingController(firstPageKey: 0);
    _pagingController.addPageRequestListener((pageKey) async {
      try {
        // Carregar Pokémons através da API, por exemplo, usando ClienteApi
        final apiClient = Provider.of<ClienteApi>(context, listen: false);
        final pokemons = await apiClient.getPokemons(page: pageKey, limit: 10);
        final isLastPage = pokemons.length < 10;
        if (isLastPage) {
          _pagingController.appendLastPage(pokemons);
        } else {
          final nextPageKey = pageKey + 1;
          _pagingController.appendPage(pokemons, nextPageKey);
        }
      } catch (error) {
        _pagingController.error = error;
      }
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokédex'),
      ),
      body: PagedGridView<int, Pokemon>(
        pagingController: _pagingController,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 0.85,
        ),
        builderDelegate: PagedChildBuilderDelegate<Pokemon>(
          itemBuilder: (context, pokemon, index) {
            return PokemonCard(pokemon: pokemon);
          },
        ),
      ),
    );
  }
}

*/