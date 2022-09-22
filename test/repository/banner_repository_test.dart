import 'dart:convert';

import 'package:b2w_challange/models/banner_model.dart';
import 'package:b2w_challange/repository/banner_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class DioMock extends Mock implements Dio {}

void main() {
  DioMock dio = DioMock();
  String url = 'https://alodjinha.herokuapp.com/banner';
  BannerRepository repository = BannerRepository(dio: dio);

  test('deve retornar uma lista de BannerModel', () async {
    when(() => dio.get(url)).thenAnswer(
      (_) async => Response(
          requestOptions: RequestOptions(path: url),
          data: jsonDecode(jsonData),
          statusCode: 200),
    );

    final result = await repository.fetchBanners();
    expect(result, isA<List<BannerModel>>());
  });

  test('deve retornar um urlImagem', () async {
    when(() => dio.get(url)).thenAnswer(
      (_) async => Response(
          requestOptions: RequestOptions(path: url),
          data: jsonDecode(jsonData),
          statusCode: 200),
    );

    final result = await repository.fetchBanners();
    expect(result[0].urlImage,
        'https://images-submarino.b2w.io/spacey/2017/02/06/MainTop_GAMES_FEV17.png');
  });

  test('deve retornar uma lista vazia', () async {
    when(() => dio.get(url)).thenAnswer(
      (_) async => Response(
          requestOptions: RequestOptions(path: url),
          data: jsonDecode(jsonData),
          statusCode: 401),
    );

    final result = await repository.fetchBanners();
    expect(result, isEmpty);
  });
}

String jsonData = '''
{
  "data": [
    {
      "id": 1,
      "urlImagem": "https://images-submarino.b2w.io/spacey/2017/02/06/MainTop_GAMES_FEV17.png",
      "linkUrl": "https://images-submarino.b2w.io/spacey/2017/02/06/MainTop_GAMES_FEV17.png"
    },
    {
      "id": 2,
      "urlImagem": "https://images-submarino.b2w.io/spacey/2017/02/06/DESTAQUE_FULL_CARTAO_CASA_FEV.png",
      "linkUrl": "https://images-submarino.b2w.io/spacey/2017/02/06/DESTAQUE_FULL_CARTAO_CASA_FEV.png"
    },
    {
      "id": 3,
      "urlImagem": "https://images-submarino.b2w.io/spacey/2017/02/03/sub-home-dest-full-655x328-touch-play.png",
      "linkUrl": "https://images-submarino.b2w.io/spacey/2017/02/03/sub-home-dest-full-655x328-touch-play.png"
    }
  ]
}


''';
