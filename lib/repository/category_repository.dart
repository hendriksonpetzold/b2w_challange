// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:b2w_challange/models/category_model.dart';
import 'package:dio/dio.dart';

class CategoryRepository {
  Dio dio;
  CategoryRepository({
    required this.dio,
  });

  Future<List<CategoryModel>> fetchCategory() async {
    final response = await dio.get('https://alodjinha.herokuapp.com/categoria');
    if (response.statusCode == 200) {
      final List result = response.data['data'];
      return result.map((e) {
        return CategoryModel.fromMap(e);
      }).toList();
    }
    return [];
  }
}
