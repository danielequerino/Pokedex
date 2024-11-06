import 'package:flutter/material.dart';
import 'package:pokedex/dados/banco-dados/entidades-database/pokemon_database_entity.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

abstract class BaseDao {
  static const databaseVersion = 1;
  static const _databaseName = 'pokemon_database.db';  // Alterado para o nome do banco de dados

  Database? _database;

  @protected
  Future<Database> getDb() async {
    _database ??= await _getDatabase();
    return _database!;
  }

  Future<Database> _getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), _databaseName),
      onCreate: (db, version) async {
        final batch = db.batch();
        _createPokemonTableV1(batch);  // Alterado para a criação da tabela de Pokémon
        await batch.commit();
      },
      version: databaseVersion,
    );
  }

  void _createPokemonTableV1(Batch batch) {
    batch.execute(
      '''
      CREATE TABLE ${PokemonDatabaseContract.pokemonTable}(
      ${PokemonDatabaseContract.idColumn} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${PokemonDatabaseContract.englishNameColumn} TEXT NOT NULL,
      ${PokemonDatabaseContract.typesColumn} TEXT NOT NULL,  -- Tipos armazenados como uma string JSON
      ${PokemonDatabaseContract.baseStatsColumn} TEXT NOT NULL  -- baseStats armazenado como uma string JSON
      );
      ''',
    );
  }
}