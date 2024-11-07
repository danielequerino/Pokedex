// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_database_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonDatabaseEntity _$PokemonDatabaseEntityFromJson(
        Map<String, dynamic> json) =>
    PokemonDatabaseEntity(
      id: (json['id'] as num?)?.toInt(),
      englishName: json['englishName'] as String,
      types: json['types'] as String,
      baseStats: json['baseStats'] as String,
    );

Map<String, dynamic> _$PokemonDatabaseEntityToJson(
        PokemonDatabaseEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'englishName': instance.englishName,
      'types': instance.types,
      'baseStats': instance.baseStats,
    };
