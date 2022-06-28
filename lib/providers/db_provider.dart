// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;
import 'dart:io';
import 'package:codigos/models/producto_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


class DBProvider {

  static Database? _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();

  Future<Database> get database async {
    if ( _database != null ) return _database!;

    _database = await initDB();

    return _database!;

  }

  Future<Database> initDB() async{

    // Path de donde almacenaremos la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final String path = p.join( documentsDirectory.path, 'Productos.db' );
    print( path );

    // Crear base de datos
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) { },
      onCreate: ( Database db, int version ) async {

        await db.execute('''
          CREATE TABLE Productos(
            id INTEGER PRIMARY KEY,
            code TEXT,
            name TEXT
          )
        ''');
      }
    );

  }

  Future<int> nuevoProducto( ProductoModel producto ) async {

    final db = await database;
    final res = await db.insert('Productos', producto.toJson() );

    return res;
  }

  Future<ProductoModel?> getProductoPorCodigo( String codigo ) async {

    final db  = await database;
    final res = await db.query('Productos', where: 'code = ?', whereArgs: [codigo]);

    return res.isNotEmpty
          ? ProductoModel.fromJson( res.first )
          : null;
  }

  Future<List<ProductoModel>> getTodosLosProductos() async {

    final db  = await database;
    final res = await db.query('Productos');

    return res.isNotEmpty
          ? res.map( (s) => ProductoModel.fromJson(s) ).toList()
          : [];
  }

  Future<List<ProductoModel>> getProductosPorNombre( String nombre ) async {

    final db  = await database;
    final res = await db.rawQuery('''
      SELECT * FROM Productos WHERE name LIKE '%$nombre%'    
    ''');

    return res.isNotEmpty
          ? res.map( (s) => ProductoModel.fromJson(s) ).toList()
          : [];
  }

  Future<int> actualizarProducto( ProductoModel producto ) async {
    final db  = await database;
    final res = await db.update('Productos', producto.toJson(), where: 'id = ?', whereArgs: [ producto.id ] );
    return res;
  }

  Future<int> eliminarProducto( int id ) async {
    final db  = await database;
    final res = await db.delete( 'Productos', where: 'id = ?', whereArgs: [id] );
    return res;
  }

  Future<int> resetearProductos() async {
    final db  = await database;
    final res = await db.rawDelete('''
      DELETE FROM Productos    
    ''');
    return res;
  }


}

