// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:b2w_challange/models/banner_model.dart';
import 'package:dio/dio.dart';

class BannerRepository {
  Dio dio;
  BannerRepository({
    required this.dio,
  });

  Future<List<BannerModel>> fetchBanners() async {
    final response = await dio.get('https://alodjinha.herokuapp.com/banner');
    if (response.statusCode == 200) {
      final List result = response.data['data'];
      return result.map((e) {
        return BannerModel.fromMap(e);
      }).toList();
    }
    return [];
  }
}
