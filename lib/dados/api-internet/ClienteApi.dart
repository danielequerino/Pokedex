import 'package:dio/dio.dart';
import 'package:pokedex/dominio/Pokemon.dart';

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







/* requisicao com encapsulamento de array
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

*/