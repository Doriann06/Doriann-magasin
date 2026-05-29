import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import '../models/pannier.dart';

class PannierDatabaseService {
  // Le chemin de la base est injectable pour permettre les tests inmemory.
  final String ?databasePath;
  Database ?_db;
  PannierDatabaseService({this.databasePath});
  Future<Database> get _database async {
    _db ??= await _openDatabase();
    return _db!;
  }

  Future<Database> _openDatabase() async {
    final path = databasePath ?? '${await getDatabasesPath()}/pannier.db';
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async { 
      db.execute('''
        CREATE TABLE pannier (
          id INTEGER PRIMARY KEY,
          data TEXT NOT NULL
        )
      ''');
      },
    );
  }
  Future<List<Pannier>> getPannier() async {
    final db = await _database;
    final rows = await db.query('pannier');
    return rows.map((row) => Pannier.fromJson(jsonDecode(row['data'] as String))).toList();
  }
  Future<Pannier?> getPannierById(int id) async {
    final db = await _database;
    final rows = await db.query('pannier', where: 'id = ?', whereArgs: [id]);
    if (rows.isEmpty) return null;
    return Pannier.fromJson(jsonDecode(rows.first['data'] as String));
  }
  Future<void> savePannier(List<Pannier> items) async {
    final db = await _database;
    await db.transaction((txn) async {
      await txn.delete('pannier');
      for (final item in items) {
        await txn.insert('pannier', {
          'data':jsonEncode(item.toJson()),
        });
      }
    });
  }
  Future<void> clearPannier() async {
    final db = await _database;
    await db.delete('pannier');
  }
  Future<void> close() async => _db?.close();
}