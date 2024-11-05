import 'package:flutter/material.dart';
import 'package:pokedex/dados/api-internet/ClienteApi.dart';
import 'package:pokedex/telas/pokedex_page.dart';
import 'package:provider/provider.dart';


// COM LOGICA DE CARREGAMEMTO

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;

  Future<void> _loadPokemons() async {
    setState(() {
      _isLoading = true;
    });

    final apiClient = Provider.of<ClienteApi>(context, listen: false);
    final pokemons = await apiClient.getPokemons(page: 0, limit: 100);


    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PokedexPage(pokemons: pokemons),
      ),
    );

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokedex'),
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              width: 300,
              height: 300,
            ),
            SizedBox(height: 50,),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: _loadPokemons,
                child: Text("Pokédex"),
              ),
            ),
            SizedBox(height: 20,),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  print("clicou em Encontro Diario");
                },
                child: Text("Encontro Diario"),
              ),
            ),
            SizedBox(height: 20,),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  print("clicou em Meus Pokémons");
                },
                child: Text("Meus Pokémons"),
              ),
            )
          ],
        ),
      ),
    );
  }
}


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