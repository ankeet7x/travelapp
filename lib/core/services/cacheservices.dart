import 'package:sqflite/sqflite.dart';
import 'package:travelapp/core/models/placemodel.dart';
import 'package:path/path.dart';

class DatabaseService {
  static String dbName = "places.db";
  DatabaseService() : super();
  static final DatabaseService instance = DatabaseService._init();
  DatabaseService._init();
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('placedata.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final path = await getDatabasesPath();
    var dbPath = join(path, fileName);
    return await openDatabase(dbPath, version: 1, onCreate: _createDb);
  }

  _createDb(Database db, int version) async {
    await db.execute(
        ''' CREATE TABLE products(placeId TEXT, place TEXT, price TEXT, placeImageUrl TEXT)
     ''');
  }

  Future<PlaceModel> insertIntoDatabase(PlaceModel place) async {
    var db = await instance.database;
    final id = await db!.insert('products', place.toMap());
    return place.copy(id: id.toString());
  }

  Future<List<PlaceModel>> getPlaces() async {
    var db = await instance.database;
    var data = await db!.query('products');
    List<PlaceModel> places = [];
    for (var d in data) {
      PlaceModel place = PlaceModel.fromMap(d);
      places.add(place);
    }
    return places;
  }

  Future<int> delete() async {
    final db = await instance.database;
    return await db!.delete('products');
  }

  Future close() async {
    final db = await instance.database;
    db!.close();
  }
}
