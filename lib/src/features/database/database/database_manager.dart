import 'package:coffee_shop/src/features/database/database/coffee_database.dart';

class DatabaseManager {
  static final DatabaseManager _singleton = DatabaseManager._internal();
  late AppDatabase _database;

  factory DatabaseManager() {
    return _singleton;
  }

  DatabaseManager._internal() {
    _database = AppDatabase();
  }

  AppDatabase get database => _database;
}