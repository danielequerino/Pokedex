import 'package:flutter/material.dart';
import 'package:pokedex/dominio/Pokemon.dart';
import 'package:pokedex/widgets/pokemon_card.dart';

class PokedexPage extends StatelessWidget {
  final List<Pokemon> pokemons;

  PokedexPage({required this.pokemons});

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
          childAspectRatio: 0.85, // Ajuste para deixar o card mais quadrado
        ),
        itemCount: pokemons.length,
        itemBuilder: (context, index) {
          return PokemonCard(pokemon: pokemons[index]);
        },
      ),
    );
  }
}
