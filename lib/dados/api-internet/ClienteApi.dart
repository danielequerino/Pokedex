//import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pokedex/dominio/Pokemon.dart';

class ClienteApi {
  late final Dio _dio;

  ClienteApi({required String baseUrl}) {
    _dio = Dio()
        ..options.baseUrl = baseUrl;
  }

  Future<List<Pokemon>> getPokemons({required int page,  required int limit}) async {
    final response = await _dio.get(
      "/pokemons",
      queryParameters: {
        'page': page,
        'limit': limit,
      }
    );
    print(response.data);

    if(response.statusCode != null && response.statusCode! >= 400) {
      throw Exception("Erro: status code ${response.statusCode} e messagem: ${response.statusMessage}");
    } else if(response.statusCode != null) {
      final List<dynamic> data = response.data[0];
      return data.map((json) => Pokemon.fromJson(json)).toList();
    }
    else {
      throw Exception('Erro inespesrado');
    }

  }

}


