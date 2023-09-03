import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  late SqlDb _sqlDb;
  List<Map<String, Object?>> _favorites = [];

  @override
  void initState() {
    super.initState();
    _sqlDb = SqlDb();
    _fetchFavorites();
  }

  Future<void> _fetchFavorites() async {
    final favorites = await _sqlDb.readData('SELECT * FROM favorites');
    //print("$favorites");
    setState(() {
      _favorites = favorites;
    });
  }

  Future<void> _removeProduct(int id) async {
    final int rowsAffected =
    await _sqlDb.deleteData('DELETE FROM favorites WHERE id = $id');
    if (rowsAffected > 0) {
      await _fetchFavorites();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: ListView.builder(
        itemCount: _favorites.length,
        itemBuilder: (context, index) {
          final favorite = _favorites[index];
          return ListTile(
            leading: Image.network(favorite['thumbnail'] as String),
            title: Text(favorite['title'] as String),
            subtitle: Text(favorite['description'] as String),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _removeProduct(favorite['id'] as int),
            ),
          );
        },
      ),
    );
  }
}
class SqlDb {
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await initializeDb();
      return _database!;
    }
  }

  Future<Database> initializeDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'favorites.db');
    return openDatabase(path, onCreate: _onCreate, version: 1);
  }

  Future<void> _onCreate(Database database, int version) async {
    await database.execute('''
      CREATE TABLE "favorites" (
        "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        "thumbnail" TEXT,
        "description" TEXT,
        "title" TEXT,
        "price" INTEGER,
        "brand" TEXT,
        "category" TEXT
      )
    ''');
    print("Database Created Successfully");
  }

  Future<List<Map<String, Object?>>> readData(String sql) async {
    Database? mydb = await database;
    List<Map<String, Object?>> response = await mydb!.rawQuery(sql);
    return response;
  }

  Future<int> insertData(String sql) async {
    Database? mydb = await database;
    int response = await mydb!.rawInsert(sql);
    print("Product Added Successfully");
    return response;
  }

  Future<int> updateData(String sql) async {
    Database? mydb = await database;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  Future<int> deleteData(String sql) async {
    Database? mydb = await database;
    int response = await mydb!.rawDelete(sql);
    return response;
  }
}