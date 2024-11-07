import 'package:json_annotation/json_annotation.dart';

part 'http_paged_result.g.dart';

@JsonSerializable()
class HttpPagedResult {
  int first;
  dynamic prev;
  int next;
  int last;
  int pages;
  int items;
  List<PokemonEntity> data;

  HttpPagedResult({
    required this.first,
    required this.prev,
    required this.next,
    required this.last,
    required this.pages,
    required this.items,
    required this.data,
  });

  factory HttpPagedResult.fromJson(Map<String, dynamic> json) => _$HttpPagedResultFromJson(json);
}


/*
@JsonSerializable()
class PokemonEntity {
  int id;
  String englishName;
  List<String> type;
  Map<String, int> baseStats;

  PokemonEntity({
    required this.id,
    required this.englishName,
    required this.type,
    required this.baseStats,
  });

  factory PokemonEntity.fromJson(Map<String, dynamic> json) => _$PokemonEntityFromJson(json);

  @override
  String toString() {
    return 'PokemonEntity{id: $id, englishName: $englishName}';
  }
}
*/

@JsonSerializable()
class PokemonEntity {
  String id;
  Map<String, String> name; // Nome em vários idiomas, incluindo "english"
  List<String> type;
  Map<String, int> baseStats;

  PokemonEntity({
    required this.id,
    required this.name,
    required this.type,
    required this.baseStats,
  });

  factory PokemonEntity.fromJson(Map<String, dynamic> json) {
    return PokemonEntity(
      id: json['id'],
      name: Map<String, String>.from(json['name']),
      type: List<String>.from(json['type']),
      baseStats: Map<String, int>.from(
        (json['base'] as Map<String, dynamic>).map(
              (key, value) => MapEntry(key, int.parse(value.toString())), // Conversão para int
        ),
      ),
    );
  }
}
