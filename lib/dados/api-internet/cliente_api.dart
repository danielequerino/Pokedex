import 'dart:convert';

import 'package:dio/dio.dart';

import 'entidade/http_paged_result.dart';

class ApiClient {
  late final Dio _dio;

  ApiClient({required String baseUrl}) {
    _dio = Dio()
      ..options.baseUrl = baseUrl;
  }

  Future<List<PokemonEntity>> getPokemons({required int page,  required int limit}) async {
    final response = await _dio.get(
        "/pokemons",
        queryParameters: {
          'page': page,
          'limit': limit,
        }
    );

    print(response.statusCode);
    print(response.statusMessage);

    //for (int i = 0; i < 100 && i < response.data.length; i++) {
    //  print(response.data[i]);
   // }

    if (response.statusCode != null && response.statusCode! >= 400) {
      return Future.error('Error: ${response.statusCode} - ${response.statusMessage}');
    } else if (response.statusCode != null) {
      print("entrou");
      // Recebe a resposta e converte para HttpPagedResult com lista de Pokémon
      final HttpPagedResult receivedData = HttpPagedResult.fromJson(response.data as Map<String, dynamic>);

      print(receivedData.data);
      return receivedData.data; // Retorna a lista de Pokémon
    } else {
      throw Exception('Unknown error');
    }
  }
}
