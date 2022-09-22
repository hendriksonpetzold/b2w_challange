// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:b2w_challange/models/category_model.dart';

class ProductModel {
  int id;
  String name;
  String urlImage;
  String description;
  double initialPrice;
  double finalPrice;
  CategoryModel category;
  ProductModel({
    required this.id,
    required this.name,
    required this.urlImage,
    required this.description,
    required this.initialPrice,
    required this.finalPrice,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'urlImage': urlImage,
      'description': description,
      'initialPrice': initialPrice,
      'finalPrice': finalPrice,
      'category': category.toMap(),
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as int,
      name: map['nome'] as String,
      urlImage: map['urlImagem'] as String,
      description: map['descricao'] as String,
      initialPrice: double.parse(map['precoDe'].toString()),
      finalPrice: map['precoPor'] as double,
      category: CategoryModel.fromMap(map['categoria'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
