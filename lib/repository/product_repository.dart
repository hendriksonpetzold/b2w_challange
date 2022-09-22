import 'package:b2w_challange/models/product_model.dart';
import 'package:dio/dio.dart';

class ProductRepository {
  Dio dio;

  ProductRepository({required this.dio});

  Future<List<ProductModel>> fetchProducts() async {
    final response = await dio.get('https://alodjinha.herokuapp.com/produto');
    if (response.statusCode == 200) {
      final List result = response.data['data'];
      return result.map((e) {
        return ProductModel.fromMap(e);
      }).toList();
    } else {
      return [];
    }
  }

  Future<List<ProductModel>> fetchBestSellersProducts() async {
    final response =
        await dio.get('https://alodjinha.herokuapp.com/produto/maisvendidos');
    if (response.statusCode == 200) {
      final List result = response.data['data'];
      return result.map((e) {
        return ProductModel.fromMap(e);
      }).toList();
    } else {
      return [];
    }
  }

  Future<ProductModel> fetchProductById({required int id}) async {
    final response =
        await dio.get('https://alodjinha.herokuapp.com/produto/$id');
    if (response.statusCode == 200) {
      final result = response.data;
      return ProductModel.fromMap(result);
    } else {
      throw Exception();
    }
  }
}
