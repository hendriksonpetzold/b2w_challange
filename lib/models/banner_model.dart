import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class BannerModel {
  int id;
  String urlImage;
  BannerModel({
    required this.id,
    required this.urlImage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'urlImage': urlImage,
    };
  }

  factory BannerModel.fromMap(Map<String, dynamic> map) {
    return BannerModel(
      id: map['id'] as int,
      urlImage: map['urlImagem'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BannerModel.fromJson(String source) =>
      BannerModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
