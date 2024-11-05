// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Pokemon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PokemonImpl _$$PokemonImplFromJson(Map<String, dynamic> json) =>
    _$PokemonImpl(
      id: (json['id'] as num).toInt(),
      englishName: json['englishName'] as String,
      type: (json['type'] as List<dynamic>).map((e) => e as String).toList(),
      baseStats: BaseStats.fromJson(json['baseStats'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PokemonImplToJson(_$PokemonImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'englishName': instance.englishName,
      'type': instance.type,
      'baseStats': instance.baseStats,
    };
