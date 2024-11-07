import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:pokedex/dados/api-internet/entidade/http_paged_result.dart';
import 'package:pokedex/dados/api-internet/cliente_api.dart'; // Certifique-se de importar ClienteApi
import 'pokedex_page.dart'; // Certifique-se de importar sua página de Pokédex

/*
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;
  late final PagingController<int, PokemonEntity> _pagingController;

  @override
  void initState() {
    super.initState();
    _pagingController = PagingController(firstPageKey: 0); // Começando na página 0

    // Adicionando o listener de páginação
    _pagingController.addPageRequestListener((pageKey) async {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        try {
          setState(() {
            _isLoading = true;
          });

          final apiClient = Provider.of<ClienteApi>(context, listen: false);
          final pokemons = await apiClient.getPokemons(page: pageKey, limit: 2); // Requisição com o ClienteApi

          if (pokemons.isEmpty) {
            _pagingController.appendLastPage(pokemons); // Adiciona a última página
          } else {
            _pagingController.appendPage(pokemons, pageKey + 1); // Adiciona a próxima página
          }
        } catch (e) {
          _pagingController.error = e; // Se ocorrer erro
        } finally {
          setState(() {
            _isLoading = false;
          });
        }
      });
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
        title: Text('Pokedex'),
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator() // Exibe o carregando enquanto os dados estão sendo buscados
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PokedexPage(pagingController: _pagingController),
                  ),
                );
              },
              child: Text("Pokédex"),
            ),
          ],
        ),
      ),
    );
  }
}
*/

// SEM LOGICA DE ACAO DE CARREGAMENTO


/*
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _loadPokemons() async {
    final apiClient = Provider.of<ClienteApi>(context, listen: false);
    final pokemons = await apiClient.getPokemons(page: 0, limit: 100);


    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PokedexPage(pokemons: pokemons),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokedex'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              width: 300,
              height: 300,
            ),
            SizedBox(height: 50),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: _loadPokemons,
                child: Text("Pokédex"),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  print("clicou em Encontro Diario");
                },
                child: Text("Encontro Diario"),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  print("clicou em Meus Pokémons");
                },
                child: Text("Meus Pokémons"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;
  late final PagingController<int, PokemonEntity> _pagingController;

  @override
  void initState() {
    super.initState();
    _pagingController = PagingController(firstPageKey: 0);

    // Listener para carregar a próxima página quando necessário
    _pagingController.addPageRequestListener((pageKey) async {
      try {
        setState(() {
          _isLoading = true;
        });

        final apiClient = Provider.of<ApiClient>(context, listen: false);

        // Chamando a API para carregar Pokémons com paginação
        final pokemons = await apiClient.getPokemons(page: pageKey, limit: 10);

        // Verifica se é a última página
        if (pokemons.isEmpty) {
          _pagingController.appendLastPage(pokemons); // Marca como última página
        } else {
          _pagingController.appendPage(pokemons, pageKey + 1); // Carrega a próxima página
        }
      } catch (e) {
        _pagingController.error = e;
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future<void> _navigateToPokedexPage() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PokedexPage(pagingController: _pagingController),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokedex'),
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator() // Exibe indicador de carregamento
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png', // Certifique-se de ter a logo no diretório de assets
              width: 300,
              height: 300,
            ),
            SizedBox(height: 50),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: _navigateToPokedexPage,
                child: Text("Pokédex"),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  print("Encontro Diário foi clicado");
                },
                child: Text("Encontro Diário"),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  print("Meus Pokémons foi clicado");
                },
                child: Text("Meus Pokémons"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}