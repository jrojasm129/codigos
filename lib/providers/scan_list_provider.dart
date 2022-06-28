import 'package:flutter/material.dart';

import '../models/producto_model.dart';
import 'db_provider.dart';

class ScanListProvider extends ChangeNotifier {

  List<ProductoModel> productos = [];

  Future<ProductoModel> nuevoProducto( String code, String name ) async {

    final producto = ProductoModel(code: code, name: name);
    final id = await DBProvider.db.nuevoProducto(producto);
    // Asignar el ID de la base de datos al modelo
    producto.id = id;

    productos.add(producto);
    notifyListeners();

    return producto;
  }
  Future<List<ProductoModel>> getProductoPorNombre( String name ) async {

    final productos = await DBProvider.db.getProductosPorNombre(name);

    return productos;
  }

  Future<ProductoModel?> getProductoPorCodigo( String codigo ) async {

    final producto = await DBProvider.db.getProductoPorCodigo(codigo);

    return producto;
  }

  cargarProductos() async {
    final productos = await DBProvider.db.getTodosLosProductos();
    this.productos = [...productos];
    notifyListeners();
  }

  borrarTodos() async {
    await DBProvider.db.resetearProductos();
    productos = [];
    notifyListeners();
  }

  borrarProductoPorId( int id ) async {
    await DBProvider.db.eliminarProducto(id);
  }



}

