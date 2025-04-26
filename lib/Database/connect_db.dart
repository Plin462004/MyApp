// database/connect_db.dart
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart';

class TransactionDB {
  // ເກັບຊື່ຖານຂໍ້ມູນ (Store database name)
  final String db_name;
  
  // Database instance
  static Database? _database;
  
  // Constructor
  TransactionDB({required this.db_name});
  
  // Get database instance (singleton pattern)
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await openDatabase();
    return _database!;
  }

  // Open database connection
  Future<Database> openDatabase() async {
    try {
      // Get application documents directory
      Directory appDirectory = await getApplicationDocumentsDirectory();
      String dbPath = join(appDirectory.path, db_name);
      
      // Open/create database
      return await openDatabase(
        dbPath,
        version: 1,
        onCreate: _createDatabase,
        onUpgrade: _upgradeDatabase,
      );
    } catch (e) {
      debugPrint('Database error: $e');
      throw Exception('Failed to open database: $e');
    }
  }
  
  // Create database tables
  Future<void> _createDatabase(Database db, int version) async {
    // Create transactions table
    await db.execute('''
      CREATE TABLE transactions(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        amount REAL,
        date TEXT,
        category TEXT,
        note TEXT,
        type TEXT
      )
    ''');
    
    // You can add more tables here as needed
    
    debugPrint('Database and tables created successfully');
  }
  
  // Handle database upgrades
  Future<void> _upgradeDatabase(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      // Add upgrade logic here when needed
      debugPrint('Database upgraded from version $oldVersion to $newVersion');
    }
  }
  
  // Close database connection
  Future<void> closeDatabase() async {
    final db = await database;
    db.close();
    _database = null;
    debugPrint('Database connection closed');
  }
  
  // Example method to insert a transaction
  Future<int> insertTransaction(Map<String, dynamic> transaction) async {
    final db = await database;
    return await db.insert('transactions', transaction);
  }
  
  // Example method to get all transactions
  Future<List<Map<String, dynamic>>> getAllTransactions() async {
    final db = await database;
    return await db.query('transactions');
  }
  
  // Example method to update a transaction
  Future<int> updateTransaction(int id, Map<String, dynamic> transaction) async {
    final db = await database;
    return await db.update(
      'transactions',
      transaction,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  
  // Example method to delete a transaction
  Future<int> deleteTransaction(int id) async {
    final db = await database;
    return await db.delete(
      'transactions',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}