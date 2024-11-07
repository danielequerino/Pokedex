import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pokedex/dados/api-internet/newtork_mapper.dart';
import 'package:pokedex/dominio/excecoes/NetworkException.dart';
import 'package:pokedex/dominio/pokemon.dart';
import '../../dominio/Pokemon.dart';
import 'entidade/http_paged_result.dart';

/*
class ClienteApi {
  late final Dio _dio;

  ClienteApi({required String baseUrl}) {
    _dio = Dio()..options.baseUrl = baseUrl;
  }

  Future<List<Pokemon>> getPokemons({required int page, required int limit}) async {
    try {
      final response = await _dio.get("/pokemons");
      if (response.statusCode != null && response.statusCode! >= 400) {
        throw Exception(
          "Erro: status code ${response.statusCode} e mensagem: ${response.statusMessage}",
        );
      } else if (response.statusCode != null && response.data != null) {
        // Acessa o primeiro array externo, depois o array interno de Pokémons
        if (response.data is List && response.data.isNotEmpty) {
          final List<dynamic> allData = response.data[0];

          // Calcular o índice inicial e final para a paginação
          int inicioIndex = page * limit;
          int finalIndex = inicioIndex + limit;

          // Verificar se o índice final excede o tamanho da lista
          finalIndex = finalIndex > allData.length ? allData.length : finalIndex;

          // Extrair a sublista para a página atual
          final List<dynamic> pageData = allData.sublist(inicioIndex, finalIndex);

          // Exibir os itens da página atual no console
          print("Pokémons da página $page:");
          for (var item in pageData) {
            print(item);  // Exibe cada Pokémon no console
          }

          // Converter JSON para a lista de Pokémons
          return pageData.map((json) => Pokemon.fromJson(json)).toList();
        } else {
          throw Exception("Estrutura JSON inesperada: array de dados não encontrado");
        }
      } else {
        throw Exception('Erro inesperado');
      }
    } catch (e) {
      print("Erro ao carregar Pokémons: $e");
      rethrow;
    }
  }
}
*/


/*

class ApiClient {
  late final Dio _dio;

  ApiClient({required String baseUrl}) {
    _dio = Dio()..options.baseUrl = baseUrl;
  }


  Future<HttpPagedResult> getPokemons({required int page, required int limit}) async {
    try {
      final response = await _dio.get("/pokemons", queryParameters: {
        '_page': page,
        '_per_page': limit,
      });

      print(response.data);

      if (response.statusCode != null && response.statusCode! >= 400) {
        throw Exception(
          "Erro: status code ${response.statusCode} e mensagem: ${response.statusMessage}",
        );
      } else if (response.statusCode != null && response.data != null) {
        // Acessa os dados de paginação e lista de Pokémons
        if (response.data is Map<String, dynamic>) {
          final Map<String, dynamic> data = response.data;

          // Convertendo a estrutura da resposta para HttpPagedResult
          final HttpPagedResult pagedResult = HttpPagedResult.fromJson(data);

          // Paginação - ajustar dados
          int startIndex = page * limit;
          int endIndex = startIndex + limit;

          // Verificar se o índice final excede o tamanho da lista
          endIndex = endIndex > pagedResult.items ? pagedResult.items : endIndex;

          // Extrair a sublista de dados para a página atual
          final List<dynamic> pageData = pagedResult.data.sublist(startIndex, endIndex);

          // Converter os Pokémons para o tipo esperado (PokemonEntity)
          final List<PokemonEntity> pokemons = pageData
              .map((json) => PokemonEntity.fromJson(json as Map<String, dynamic>))
              .toList();

          // Atualizar o objeto pagedResult com os dados filtrados
          return HttpPagedResult(
            first: pagedResult.first,
            prev: pagedResult.prev,
            next: pagedResult.next,
            last: pagedResult.last,
            pages: pagedResult.pages,
            items: pagedResult.items,
            data: pokemons,
          );
        } else {
          throw Exception("Estrutura JSON inesperada: estrutura de dados não encontrada");
        }
      } else {
        throw Exception('Erro inesperado');
      }
    } catch (e) {
      print("Erro ao carregar Pokémons: $e");
      rethrow;
    }
  }
}
*/


class ApiClient {
  late final Dio _dio;

  ApiClient({required String baseUrl}) {
    _dio = Dio()
      ..options.baseUrl = baseUrl
    // Interceptor para logar requisições e respostas
      ..interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
        ),
      );
  }
 /*
  Future<List<PokemonEntity>> getPokemons({int? page, int? limit}) async {
    try {
      final response = await _dio.get(
        "/pokemons",
        queryParameters: {
          '_page': page,
          '_per_page': limit,
        },
      );

      print("Primeiro Response: ${response.data}");

      // Checando o status da resposta
      if (response.statusCode != null && response.statusCode! >= 400) {
        throw NetworkException(
          statusCode: response.statusCode!,
          message: response.statusMessage,
        );
      } else if (response.statusCode != null) {
        final List<dynamic> allData = response.data[0];
        print("NOVO FORMATO DE JSON ${allData}");


        // Conversão da resposta para HttpPagedResult
        final HttpPagedResult receivedData = HttpPagedResult.fromJson(allData as Map<String, dynamic>);
        print("Receive na tela ${receivedData}");

        // Retornando a lista de Pokémon (dados da resposta)
        return receivedData.data
            .map((json) => PokemonEntity.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Erro inesperado');
      }
    } catch (e) {
      print("Erro ao carregar Pokémons: $e");
      rethrow;
    }
  }*/
  Future<List<PokemonEntity>> getPokemons({int? page, int? limit}) async {
    try {
      final response = await _dio.get(
        "/pokemons",
        queryParameters: {
          '_page': page,
          '_per_page': limit,
        },
      );

      print("Primeiro Response: ${response.data}");

      // Verifique se data existe e é uma lista
      if (response.data['data'] != null && response.data['data'] is List) {
        final List<dynamic> allData = response.data['data'];
        return allData
            .map((json) => PokemonEntity.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Formato de resposta inesperado ou chave "data" ausente');
      }
    } catch (e) {
      print("Erro ao carregar Pokémons: $e");
      rethrow;
    }
  }

}


