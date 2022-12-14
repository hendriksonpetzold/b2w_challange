import 'dart:convert';

import 'package:b2w_challange/models/category_model.dart';
import 'package:b2w_challange/repository/category_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class DioMock extends Mock implements Dio {}

void main() {
  DioMock dio = DioMock();
  CategoryRepository repository = CategoryRepository(dio: dio);
  String url = 'https://alodjinha.herokuapp.com/categoria';

  test('deve retornar uma List de CategoryModel', () async {
    when(() => dio.get(url)).thenAnswer(
      (_) async => Response(
          requestOptions: RequestOptions(path: url),
          data: jsonDecode(jsonData),
          statusCode: 200),
    );
    final result = await repository.fetchCategory();

    expect(result, isA<List<CategoryModel>>());
  });

  test('deve retornar uma descrição', () async {
    when(() => dio.get(url)).thenAnswer(
      (_) async => Response(
          requestOptions: RequestOptions(path: url),
          data: jsonDecode(jsonData),
          statusCode: 200),
    );
    final result = await repository.fetchCategory();

    expect(result[0].description, 'Games');
  });

  test('deve retornar uma lista vazia', () async {
    when(() => dio.get(url)).thenAnswer(
      (_) async => Response(
          requestOptions: RequestOptions(path: url),
          data: jsonDecode(jsonData),
          statusCode: 401),
    );
    final result = await repository.fetchCategory();

    expect(result, isEmpty);
  });
}

String jsonData = '''
{
  "data": [
    {
      "id": 1,
      "descricao": "Games",
      "urlImagem": "http://39ahd9aq5l9101brf3b8dq58.wpengine.netdna-cdn.com/wp-content/uploads/2013/06/3D-Gaming.png"
    },
    {
      "id": 2,
      "descricao": "Livros",
      "urlImagem": "http://4.bp.blogspot.com/-6Bta1H9d22g/UJAIJbqcHhI/AAAAAAAAKi4/hvgjWrlFc64/s1600/resenha-missiologia.png"
    },
    {
      "id": 3,
      "descricao": "Celulares",
      "urlImagem": "http://pt.seaicons.com/wp-content/uploads/2015/11/Mobile-Smartphone-icon.png"
    },
    {
      "id": 4,
      "descricao": "Informática",
      "urlImagem": "http://portal.ifrn.edu.br/campus/ceara-mirim/noticias/ifrn-oferece-curso-de-informatica-basica-para-pais-dos-estudantes/image_preview"
    },
    {
      "id": 5,
      "descricao": "Eletrodoméstico",
      "urlImagem": "http://classificados.folharegiao.com.br/files/classificados_categoria/photo/8/sm_4d5ed3beb0f31b61cb9a01e46ecd0cf9.png"
    },
    {
      "id": 6,
      "descricao": "TVs",
      "urlImagem": "http://i.utdstc.com/icons/256/terrarium-tv-android.png"
    },
    {
      "id": 7,
      "descricao": "Filmes e Séries",
      "urlImagem": "https://pbs.twimg.com/profile_images/801033586438733824/91Y_N91t_reasonably_small.jpg"
    },
    {
      "id": 8,
      "descricao": "Móveis e Decorações",
      "urlImagem": "https://image.flaticon.com/icons/png/128/148/148188.png"
    },
    {
      "id": 9,
      "descricao": "Moda, Beleza e Perfumaria",
      "urlImagem": "http://icon-icons.com/icons2/196/PNG/128/fashion_23852.png"
    },
    {
      "id": 10,
      "descricao": "Papelaria",
      "urlImagem": "http://esen.pt/in/images/stories/skills_256.png"
    }
  ]
}

''';
