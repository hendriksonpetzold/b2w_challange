import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class CategoryModel {
  int id;
  String description;
  String urlImage;
  CategoryModel({
    required this.id,
    required this.description,
    required this.urlImage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'description': description,
      'urlImage': urlImage,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] as int,
      description: map['descricao'] as String,
      urlImage: map['urlImagem'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
