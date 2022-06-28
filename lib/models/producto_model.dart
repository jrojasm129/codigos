import 'dart:convert';

ProductoModel productoModelFromJson(String str) => ProductoModel.fromJson(json.decode(str));
String productoModelToJson(ProductoModel data) => json.encode(data.toJson());

class ProductoModel {
    ProductoModel({
        this.id,
        this.code,
        this.name,
    });

    int? id;
    String? code;
    String? name;

    factory ProductoModel.fromJson(Map<String, dynamic> json ) => ProductoModel(
        id: json["id"],
        code: json["code"],
        name: json["name"]
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
    };
}
