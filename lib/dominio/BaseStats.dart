

class BaseStats {
  final int hp;
  final int attack;
  final int defense;
  final int spAttack;
  final int spDefense;
  final int speed;

  BaseStats({
    required this.hp,
    required this.attack,
    required this.defense,
    required this.spAttack,
    required this.spDefense,
    required this.speed,
  });

  factory BaseStats.fromJson(Map<String, dynamic> json) {
    return BaseStats(
      hp: json['HP'],
      attack: json['Attack'],
      defense: json['Defense'],
      spAttack: json['Sp. Attack'],
      spDefense: json['Sp. Defense'],
      speed: json['Speed'],
    );
  }
}



/*
import 'package:freezed_annotation/freezed_annotation.dart';

part 'BaseStats.freezed.dart';
part 'BaseStats.g.dart';

@freezed
class BaseStats with _$BaseStats {
  const factory BaseStats({
    required int hp,
    required int attack,
    required int defense,
    required int spAttack,
    required int spDefense,
    required int speed,
  }) = _BaseStats;

  factory BaseStats.fromJson(Map<String, dynamic> json) => _$BaseStatsFromJson(json);
}

*/