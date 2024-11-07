
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/dados/api-internet/entidade/http_paged_result.dart';
import 'package:pokedex/dominio/pokemon.dart';

import '../telas/detalhes_pokemon.dart';


/*
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PokemonDetalhes(pokemon: pokemon),
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
*/
/*
class PokemonCard extends StatelessWidget {
  final PokemonEntity pokemon; // Alterado para PokemonEntity

  // Mudança para receber PokemonEntity
  PokemonCard({Key? key, required this.pokemon}) : super(key: key);

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
    // Ajuste para utilizar o PokemonEntity
    final String formattedId = pokemon.id.toString().padLeft(3, '0');
    final String imageUrl = 'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/$formattedId.png';
    Color cardColor = typeColors[pokemon.type.first] ?? Colors.white;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PokemonDetalhes(pokemonEntity: pokemon,),
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
*/

/*
class PokemonCard extends StatelessWidget {
  final Pokemon pokemon; // Recebe um objeto Pokémon

  const PokemonCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    // Calcula o formattedId e imageUrl dentro do método build
    final String formattedId = pokemon.id.toString().padLeft(3, '0');
    final String imageUrl = 'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/$formattedId.png';

    return Card(
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Imagem do Pokémon
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                imageUrl, // Usa a URL formatada aqui
                width: 80.0,
                height: 80.0,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16.0),
            // Informações do Pokémon
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nome do Pokémon
                  Text(
                    pokemon.name, // Nome do Pokémon
                  ),
                  const SizedBox(height: 4.0),
                  // Tipos do Pokémon (se houver)
                  Text(
                    pokemon.type.join(', '), // Tipos de Pokémon
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

 */

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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PokemonDetalhes(pokemon: pokemon), // Atualizado para passar Pokemon
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
                pokemon.name,
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