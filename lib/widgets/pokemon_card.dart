import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/dominio/Pokemon.dart';
import 'package:pokedex/telas/detalhes_pokemon.dart'; // Certifique-se de importar a tela de detalhes

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;

  PokemonCard({required this.pokemon});

  final Map<String, Color> typeColors = {
    'Fire': Colors.red,
    'Water': Colors.blue,
    'Grass': Colors.green,
    'Electric': Colors.yellow,
    'Psychic': Colors.pink,
    'Ice': Colors.cyan,
    'Normal': Colors.grey,
    'Fighting': Colors.brown,
    'Poison': Colors.purple,
    'Ground': Colors.orange,
    'Flying': Colors.lightBlue,
    'Bug': Colors.lightGreen,
    'Rock': Colors.amber,
    'Ghost': Colors.deepPurple,
    'Dragon': Colors.indigo,
  };

  @override
  Widget build(BuildContext context) {
    final String formattedId = pokemon.id.toString().padLeft(3, '0');
    final String imageUrl = 'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/$formattedId.png';
    Color cardColor = typeColors[pokemon.type.first] ?? Colors.white;

    return GestureDetector(
      onTap: () {
        // Navega para a tela de detalhes do Pokémon ao clicar no card
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PokemonDetalhes(pokemon: pokemon), // Certifique-se de passar o Pokémon
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 5,
        color: cardColor,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CachedNetworkImage(
                imageUrl: imageUrl,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error, color: Colors.red),
              ),
              SizedBox(height: 8),
              Text(
                pokemon.englishName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              Wrap(
                spacing: 8,
                alignment: WrapAlignment.center,
                children: pokemon.type.map((type) {
                  return Chip(
                    label: Text(type),
                    backgroundColor: typeColors[type]?.withOpacity(0.6) ?? Colors.black.withOpacity(0.6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 3,
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}