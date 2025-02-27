  import 'package:sqflite/sqflite.dart';
  import 'package:path/path.dart';


  class DatabaseHelper {
    static final DatabaseHelper _instance = DatabaseHelper._internal();
    static Database? _database;

    // Factory constructor
    factory DatabaseHelper() {
      return _instance;
    }

    // Private constructor
    DatabaseHelper._internal();
    
    // Getter untuk database
    Future<Database> get database async {
  if (_database != null) return _database!;
  {
  _database = await _initDatabase();
  return _database!;
  }
  }


    // Inisialisasi database
    Future<Database> _initDatabase() async {
  // mendapatkan path untuk database
  String path = join(await getDatabasesPath(),
  'my_prakdatabase.db');
  // membuka database
  return await openDatabase(
  path,
  version: 1,
  onCreate: _onCreate,
  );
  }

  // Membuat tabel
  Future<void> _onCreate(Database db, int version) async {
  await db.execute('''
  CREATE TABLE my_table(
  id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  title TEXT,
  description TEXT,
  createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP)
  ''');

  }

  // Menambahkan data
  Future<int> insert(Map<String, dynamic> row) async {
  Database db = await database;
  return await db.insert('my_table', row);
  }

  // Mengambil semua data
  Future<List<Map<String, dynamic>>> queryAllRows() async {
  Database db = await database;
  return await db.query('my_table');
  }

  // Buat metode memperbarui data
  Future<int> update(Map<String, dynamic> row) async {
  Database db = await database;
  int id = row['id'];
  return await db.update('my_table', row, where: 'id = ?',
  whereArgs: [id]);
  }

  // Buat metode menghapus data
  Future<int> delete(int id) async {
  Database db = await database;
  return await db.delete('my_table', where: 'id = ?',
  whereArgs: [id]);
  }

  
  }