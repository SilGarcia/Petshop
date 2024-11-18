import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  // Getter para o banco de dados
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('animais.db');
    return _database!;
  }

  // Inicializar o banco de dados
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  // Criar a tabela de animais no banco de dados
  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
      CREATE TABLE animais (
        id $idType,
        nome $textType,
        tipo $textType,
        raca $textType
      )
    ''');
  }

  // Inserir um novo animal
  Future<int> insert(Map<String, dynamic> animal) async {
    final db = await instance.database;
    return await db.insert('animais', animal);
  }

  // Atualizar um animal existente
  Future<int> update(Map<String, dynamic> animal) async {
    final db = await instance.database;
    final id = animal['id'];
    return await db.update(
      'animais',
      animal,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Excluir um animal
  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      'animais',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Consultar todos os animais
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    final db = await instance.database;
    return await db.query('animais');
  }

  // Consultar um animal específico
  Future<Map<String, dynamic>?> get(int id) async {
    final db = await instance.database;
    final result = await db.query(
      'animais',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }
}
