import 'dart:convert';

import 'package:b2w_challange/models/product_model.dart';
import 'package:b2w_challange/repository/product_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class DioMock extends Mock implements Dio {}

void main() {
  DioMock dio = DioMock();
  ProductRepository repository = ProductRepository(dio: dio);

  test('deve retornar uma lista de ProductModel', () async {
    when(() => dio.get('https://alodjinha.herokuapp.com/produto')).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(
          path: 'https://alodjinha.herokuapp.com/produto',
        ),
        data: jsonDecode(productJson),
        statusCode: 200,
      ),
    );
    final result = await repository.fetchProducts();

    expect(result, isA<List<ProductModel>>());
  });
  test('deve retornar uma lista de ProductModel(bestsellers)', () async {
    when(() => dio.get('https://alodjinha.herokuapp.com/produto/maisvendidos'))
        .thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(
          path: 'https://alodjinha.herokuapp.com/produto/maisvendidos',
        ),
        data: jsonDecode(productJson),
        statusCode: 200,
      ),
    );
    final result = await repository.fetchBestSellersProducts();

    expect(result, isA<List<ProductModel>>());
  });

  test('deve retornar somente um ProductModel, buscando pelo ID', () async {
    when(() => dio.get('https://alodjinha.herokuapp.com/produto/1')).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(
          path: 'https://alodjinha.herokuapp.com/produto/1',
        ),
        data: jsonDecode(productByIdJson),
        statusCode: 200,
      ),
    );
    final result = await repository.fetchProductById(id: 1);

    expect(result, isA<ProductModel>());
  });

  test('deve retornar uma lista vazia', () async {
    when(() => dio.get('https://alodjinha.herokuapp.com/produto')).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(
          path: 'https://alodjinha.herokuapp.com/produto',
        ),
        data: jsonDecode(productJson),
        statusCode: 401,
      ),
    );
    final result = await repository.fetchProducts();

    expect(result, isEmpty);
  });
}

String productByIdJson = '''
{
  "id": 1,
  "nome": "Game Horizon Zero Down",
  "urlImagem": "https://images-submarino.b2w.io/produtos/01/00/item/130836/1/130836199P1.jpg",
  "descricao": "Mussum Ipsum, cacilds vidis litro abertis. Atirei o pau no gatis, per gatis num morreus. N??o sou faixa preta cumpadi, sou preto inteiris, inteiris. Praesent malesuada urna nisi, quis volutpat erat hendrerit non. Nam vulputate dapibus. Diuretics paradis num copo ?? motivis de denguis.<br/><br/>Copo furadis ?? disculpa de bebadis, arcu quam euismod magna. Casamentiss faiz malandris se pirulit??. Vehicula non. Ut sed ex eros. Vivamus sit amet nibh non tellus tristique interdum. in elementis m?? pra quem ?? amistosis quis leo.<br/><br/>A ordem dos tratores n??o altera o p??o duris Delegadis gente finis, bibendum egestas augue arcu ut est. M?? faiz elementum girarzis, nisi eros vermeio. Si u mundo t?? muito paradis? Toma um m?? que o mundo vai girarzis!",
  "precoDe": 299,
  "precoPor": 119.99,
  "categoria": {
    "id": 1,
    "descricao": "Games",
    "urlImagem": "http://39ahd9aq5l9101brf3b8dq58.wpengine.netdna-cdn.com/wp-content/uploads/2013/06/3D-Gaming.png"
  }
}
 ''';

String productJson = ''' 
{
  "data": [
    {
      "id": 1,
      "nome": "Game Horizon Zero Down",
      "urlImagem": "https://images-submarino.b2w.io/produtos/01/00/item/130836/1/130836199P1.jpg",
      "descricao": "Mussum Ipsum, cacilds vidis litro abertis. Atirei o pau no gatis, per gatis num morreus. N??o sou faixa preta cumpadi, sou preto inteiris, inteiris. Praesent malesuada urna nisi, quis volutpat erat hendrerit non. Nam vulputate dapibus. Diuretics paradis num copo ?? motivis de denguis.<br/><br/>Copo furadis ?? disculpa de bebadis, arcu quam euismod magna. Casamentiss faiz malandris se pirulit??. Vehicula non. Ut sed ex eros. Vivamus sit amet nibh non tellus tristique interdum. in elementis m?? pra quem ?? amistosis quis leo.<br/><br/>A ordem dos tratores n??o altera o p??o duris Delegadis gente finis, bibendum egestas augue arcu ut est. M?? faiz elementum girarzis, nisi eros vermeio. Si u mundo t?? muito paradis? Toma um m?? que o mundo vai girarzis!",
      "precoDe": 299,
      "precoPor": 119.99,
      "categoria": {
        "id": 1,
        "descricao": "Games",
        "urlImagem": "http://39ahd9aq5l9101brf3b8dq58.wpengine.netdna-cdn.com/wp-content/uploads/2013/06/3D-Gaming.png"
      }
    },
    {
      "id": 2,
      "nome": "NBA2K17",
      "urlImagem": "https://images-submarino.b2w.io/produtos/01/00/item/128815/8/128815807_1GG.jpg",
      "descricao": "Primeiro eu queria cumprimentar os internautas. -Oi Internautas! Depois dizer que o meio ambiente ?? sem d??vida nenhuma uma amea??a ao desenvolvimento sustent??vel. E isso significa que ?? uma amea??a pro futuro do nosso planeta e dos nossos pa??ses. O desemprego beira 20%, ou seja, 1 em cada 4 portugueses.<br/><br/>A popula????o ela precisa da Zona Franca de Manaus, porque na Zona franca de Manaus, n??o ?? uma zona de exporta????o, ?? uma zona para o Brasil. Portanto ela tem um objetivo, ela evita o desmatamento, que ?? altamente lucravito. Derrubar arvores da natureza ?? muito lucrativo!<br/><br/>No meu xin??lo da humildade eu gostaria muito de ver o Neymar e o Ganso. Por que eu acho que.... 11 entre 10 brasileiros gostariam. Voc?? veja, eu j?? vi, parei de ver. Voltei a ver, e acho que o Neymar e o Ganso t??m essa capacidade de fazer a gente olhar.<br/><br/>",
      "precoDe": 299,
      "precoPor": 119.99,
      "categoria": {
        "id": 1,
        "descricao": "Games",
        "urlImagem": "http://39ahd9aq5l9101brf3b8dq58.wpengine.netdna-cdn.com/wp-content/uploads/2013/06/3D-Gaming.png"
      }
    },
    {
      "id": 3,
      "nome": "Metal Gear V",
      "urlImagem": "https://images-submarino.b2w.io/produtos/01/00/item/129681/4/129681417P1.jpg",
      "descricao": "Mussum Ipsum, cacilds vidis litro abertis. Atirei o pau no gatis, per gatis num morreus. N??o sou faixa preta cumpadi, sou preto inteiris, inteiris. Praesent malesuada urna nisi, quis volutpat erat hendrerit non. Nam vulputate dapibus. Diuretics paradis num copo ?? motivis de denguis.<br/><br/>Copo furadis ?? disculpa de bebadis, arcu quam euismod magna. Casamentiss faiz malandris se pirulit??. Vehicula non. Ut sed ex eros. Vivamus sit amet nibh non tellus tristique interdum. in elementis m?? pra quem ?? amistosis quis leo.<br/><br/>A ordem dos tratores n??o altera o p??o duris Delegadis gente finis, bibendum egestas augue arcu ut est. M?? faiz elementum girarzis, nisi eros vermeio. Si u mundo t?? muito paradis? Toma um m?? que o mundo vai girarzis!",
      "precoDe": 299,
      "precoPor": 119.99,
      "categoria": {
        "id": 1,
        "descricao": "Games",
        "urlImagem": "http://39ahd9aq5l9101brf3b8dq58.wpengine.netdna-cdn.com/wp-content/uploads/2013/06/3D-Gaming.png"
      }
    },
    {
      "id": 4,
      "nome": "Gear of War 4",
      "urlImagem": "https://images-submarino.b2w.io/produtos/01/00/item/128831/8/128831891_1GG.png",
      "descricao": "Primeiro eu queria cumprimentar os internautas. -Oi Internautas! Depois dizer que o meio ambiente ?? sem d??vida nenhuma uma amea??a ao desenvolvimento sustent??vel. E isso significa que ?? uma amea??a pro futuro do nosso planeta e dos nossos pa??ses. O desemprego beira 20%, ou seja, 1 em cada 4 portugueses.<br/><br/>A popula????o ela precisa da Zona Franca de Manaus, porque na Zona franca de Manaus, n??o ?? uma zona de exporta????o, ?? uma zona para o Brasil. Portanto ela tem um objetivo, ela evita o desmatamento, que ?? altamente lucravito. Derrubar arvores da natureza ?? muito lucrativo!<br/><br/>No meu xin??lo da humildade eu gostaria muito de ver o Neymar e o Ganso. Por que eu acho que.... 11 entre 10 brasileiros gostariam. Voc?? veja, eu j?? vi, parei de ver. Voltei a ver, e acho que o Neymar e o Ganso t??m essa capacidade de fazer a gente olhar.<br/><br/>",
      "precoDe": 299,
      "precoPor": 119.99,
      "categoria": {
        "id": 1,
        "descricao": "Games",
        "urlImagem": "http://39ahd9aq5l9101brf3b8dq58.wpengine.netdna-cdn.com/wp-content/uploads/2013/06/3D-Gaming.png"
      }
    },
    {
      "id": 5,
      "nome": "Nioh",
      "urlImagem": "https://images-submarino.b2w.io/produtos/01/00/item/131051/8/131051887_1GG.jpg",
      "descricao": "Mussum Ipsum, cacilds vidis litro abertis. Atirei o pau no gatis, per gatis num morreus. N??o sou faixa preta cumpadi, sou preto inteiris, inteiris. Praesent malesuada urna nisi, quis volutpat erat hendrerit non. Nam vulputate dapibus. Diuretics paradis num copo ?? motivis de denguis.<br/><br/>Copo furadis ?? disculpa de bebadis, arcu quam euismod magna. Casamentiss faiz malandris se pirulit??. Vehicula non. Ut sed ex eros. Vivamus sit amet nibh non tellus tristique interdum. in elementis m?? pra quem ?? amistosis quis leo.<br/><br/>A ordem dos tratores n??o altera o p??o duris Delegadis gente finis, bibendum egestas augue arcu ut est. M?? faiz elementum girarzis, nisi eros vermeio. Si u mundo t?? muito paradis? Toma um m?? que o mundo vai girarzis!",
      "precoDe": 299,
      "precoPor": 119.99,
      "categoria": {
        "id": 1,
        "descricao": "Games",
        "urlImagem": "http://39ahd9aq5l9101brf3b8dq58.wpengine.netdna-cdn.com/wp-content/uploads/2013/06/3D-Gaming.png"
      }
    },
    {
      "id": 6,
      "nome": "Watch Dogs 2",
      "urlImagem": "https://images-submarino.b2w.io/produtos/01/00/item/129498/5/129498508_1GG.jpg",
      "descricao": "Primeiro eu queria cumprimentar os internautas. -Oi Internautas! Depois dizer que o meio ambiente ?? sem d??vida nenhuma uma amea??a ao desenvolvimento sustent??vel. E isso significa que ?? uma amea??a pro futuro do nosso planeta e dos nossos pa??ses. O desemprego beira 20%, ou seja, 1 em cada 4 portugueses.<br/><br/>A popula????o ela precisa da Zona Franca de Manaus, porque na Zona franca de Manaus, n??o ?? uma zona de exporta????o, ?? uma zona para o Brasil. Portanto ela tem um objetivo, ela evita o desmatamento, que ?? altamente lucravito. Derrubar arvores da natureza ?? muito lucrativo!<br/><br/>No meu xin??lo da humildade eu gostaria muito de ver o Neymar e o Ganso. Por que eu acho que.... 11 entre 10 brasileiros gostariam. Voc?? veja, eu j?? vi, parei de ver. Voltei a ver, e acho que o Neymar e o Ganso t??m essa capacidade de fazer a gente olhar.<br/><br/>",
      "precoDe": 299,
      "precoPor": 119.99,
      "categoria": {
        "id": 1,
        "descricao": "Games",
        "urlImagem": "http://39ahd9aq5l9101brf3b8dq58.wpengine.netdna-cdn.com/wp-content/uploads/2013/06/3D-Gaming.png"
      }
    },
    {
      "id": 7,
      "nome": "Fifa 17",
      "urlImagem": "https://images-submarino.b2w.io/produtos/01/00/item/128926/4/128926443_1GG.png",
      "descricao": "Mussum Ipsum, cacilds vidis litro abertis. Atirei o pau no gatis, per gatis num morreus. N??o sou faixa preta cumpadi, sou preto inteiris, inteiris. Praesent malesuada urna nisi, quis volutpat erat hendrerit non. Nam vulputate dapibus. Diuretics paradis num copo ?? motivis de denguis.<br/><br/>Copo furadis ?? disculpa de bebadis, arcu quam euismod magna. Casamentiss faiz malandris se pirulit??. Vehicula non. Ut sed ex eros. Vivamus sit amet nibh non tellus tristique interdum. in elementis m?? pra quem ?? amistosis quis leo.<br/><br/>A ordem dos tratores n??o altera o p??o duris Delegadis gente finis, bibendum egestas augue arcu ut est. M?? faiz elementum girarzis, nisi eros vermeio. Si u mundo t?? muito paradis? Toma um m?? que o mundo vai girarzis!",
      "precoDe": 299,
      "precoPor": 119.99,
      "categoria": {
        "id": 1,
        "descricao": "Games",
        "urlImagem": "http://39ahd9aq5l9101brf3b8dq58.wpengine.netdna-cdn.com/wp-content/uploads/2013/06/3D-Gaming.png"
      }
    },
    {
      "id": 8,
      "nome": "Battlefield 1",
      "urlImagem": "https://images-submarino.b2w.io/produtos/01/00/item/129305/2/129305235_1GG.png",
      "descricao": "Primeiro eu queria cumprimentar os internautas. -Oi Internautas! Depois dizer que o meio ambiente ?? sem d??vida nenhuma uma amea??a ao desenvolvimento sustent??vel. E isso significa que ?? uma amea??a pro futuro do nosso planeta e dos nossos pa??ses. O desemprego beira 20%, ou seja, 1 em cada 4 portugueses.<br/><br/>A popula????o ela precisa da Zona Franca de Manaus, porque na Zona franca de Manaus, n??o ?? uma zona de exporta????o, ?? uma zona para o Brasil. Portanto ela tem um objetivo, ela evita o desmatamento, que ?? altamente lucravito. Derrubar arvores da natureza ?? muito lucrativo!<br/><br/>No meu xin??lo da humildade eu gostaria muito de ver o Neymar e o Ganso. Por que eu acho que.... 11 entre 10 brasileiros gostariam. Voc?? veja, eu j?? vi, parei de ver. Voltei a ver, e acho que o Neymar e o Ganso t??m essa capacidade de fazer a gente olhar.<br/><br/>",
      "precoDe": 299,
      "precoPor": 119.99,
      "categoria": {
        "id": 1,
        "descricao": "Games",
        "urlImagem": "http://39ahd9aq5l9101brf3b8dq58.wpengine.netdna-cdn.com/wp-content/uploads/2013/06/3D-Gaming.png"
      }
    },
    {
      "id": 9,
      "nome": "For Honor",
      "urlImagem": "https://images-submarino.b2w.io/produtos/01/00/item/131045/4/131045410_1GG.jpg",
      "descricao": "Mussum Ipsum, cacilds vidis litro abertis. Atirei o pau no gatis, per gatis num morreus. N??o sou faixa preta cumpadi, sou preto inteiris, inteiris. Praesent malesuada urna nisi, quis volutpat erat hendrerit non. Nam vulputate dapibus. Diuretics paradis num copo ?? motivis de denguis.<br/><br/>Copo furadis ?? disculpa de bebadis, arcu quam euismod magna. Casamentiss faiz malandris se pirulit??. Vehicula non. Ut sed ex eros. Vivamus sit amet nibh non tellus tristique interdum. in elementis m?? pra quem ?? amistosis quis leo.<br/><br/>A ordem dos tratores n??o altera o p??o duris Delegadis gente finis, bibendum egestas augue arcu ut est. M?? faiz elementum girarzis, nisi eros vermeio. Si u mundo t?? muito paradis? Toma um m?? que o mundo vai girarzis!",
      "precoDe": 299,
      "precoPor": 119.99,
      "categoria": {
        "id": 1,
        "descricao": "Games",
        "urlImagem": "http://39ahd9aq5l9101brf3b8dq58.wpengine.netdna-cdn.com/wp-content/uploads/2013/06/3D-Gaming.png"
      }
    },
    {
      "id": 10,
      "nome": "Rise of the Tomb Raider",
      "urlImagem": "https://images-submarino.b2w.io/produtos/01/00/item/129125/0/129125074_1GG.png",
      "descricao": "Mussum Ipsum, cacilds vidis litro abertis. Atirei o pau no gatis, per gatis num morreus. N??o sou faixa preta cumpadi, sou preto inteiris, inteiris. Praesent malesuada urna nisi, quis volutpat erat hendrerit non. Nam vulputate dapibus. Diuretics paradis num copo ?? motivis de denguis.<br/><br/>Copo furadis ?? disculpa de bebadis, arcu quam euismod magna. Casamentiss faiz malandris se pirulit??. Vehicula non. Ut sed ex eros. Vivamus sit amet nibh non tellus tristique interdum. in elementis m?? pra quem ?? amistosis quis leo.<br/><br/>A ordem dos tratores n??o altera o p??o duris Delegadis gente finis, bibendum egestas augue arcu ut est. M?? faiz elementum girarzis, nisi eros vermeio. Si u mundo t?? muito paradis? Toma um m?? que o mundo vai girarzis!",
      "precoDe": 299,
      "precoPor": 119.99,
      "categoria": {
        "id": 1,
        "descricao": "Games",
        "urlImagem": "http://39ahd9aq5l9101brf3b8dq58.wpengine.netdna-cdn.com/wp-content/uploads/2013/06/3D-Gaming.png"
      }
    },
    {
      "id": 11,
      "nome": "Forza Horizon 3",
      "urlImagem": "https://images-submarino.b2w.io/produtos/01/00/item/128831/2/128831209_1GG.jpg",
      "descricao": "Primeiro eu queria cumprimentar os internautas. -Oi Internautas! Depois dizer que o meio ambiente ?? sem d??vida nenhuma uma amea??a ao desenvolvimento sustent??vel. E isso significa que ?? uma amea??a pro futuro do nosso planeta e dos nossos pa??ses. O desemprego beira 20%, ou seja, 1 em cada 4 portugueses.<br/><br/>A popula????o ela precisa da Zona Franca de Manaus, porque na Zona franca de Manaus, n??o ?? uma zona de exporta????o, ?? uma zona para o Brasil. Portanto ela tem um objetivo, ela evita o desmatamento, que ?? altamente lucravito. Derrubar arvores da natureza ?? muito lucrativo!<br/><br/>No meu xin??lo da humildade eu gostaria muito de ver o Neymar e o Ganso. Por que eu acho que.... 11 entre 10 brasileiros gostariam. Voc?? veja, eu j?? vi, parei de ver. Voltei a ver, e acho que o Neymar e o Ganso t??m essa capacidade de fazer a gente olhar.<br/><br/>",
      "precoDe": 299,
      "precoPor": 119.99,
      "categoria": {
        "id": 1,
        "descricao": "Games",
        "urlImagem": "http://39ahd9aq5l9101brf3b8dq58.wpengine.netdna-cdn.com/wp-content/uploads/2013/06/3D-Gaming.png"
      }
    },
    {
      "id": 12,
      "nome": "Final Fantasy 15",
      "urlImagem": "https://images-submarino.b2w.io/produtos/01/00/item/128349/8/128349851_1GG.jpg",
      "descricao": "Primeiro eu queria cumprimentar os internautas. -Oi Internautas! Depois dizer que o meio ambiente ?? sem d??vida nenhuma uma amea??a ao desenvolvimento sustent??vel. E isso significa que ?? uma amea??a pro futuro do nosso planeta e dos nossos pa??ses. O desemprego beira 20%, ou seja, 1 em cada 4 portugueses.<br/><br/>A popula????o ela precisa da Zona Franca de Manaus, porque na Zona franca de Manaus, n??o ?? uma zona de exporta????o, ?? uma zona para o Brasil. Portanto ela tem um objetivo, ela evita o desmatamento, que ?? altamente lucravito. Derrubar arvores da natureza ?? muito lucrativo!<br/><br/>No meu xin??lo da humildade eu gostaria muito de ver o Neymar e o Ganso. Por que eu acho que.... 11 entre 10 brasileiros gostariam. Voc?? veja, eu j?? vi, parei de ver. Voltei a ver, e acho que o Neymar e o Ganso t??m essa capacidade de fazer a gente olhar.<br/><br/>",
      "precoDe": 299,
      "precoPor": 119.99,
      "categoria": {
        "id": 1,
        "descricao": "Games",
        "urlImagem": "http://39ahd9aq5l9101brf3b8dq58.wpengine.netdna-cdn.com/wp-content/uploads/2013/06/3D-Gaming.png"
      }
    },
    {
      "id": 13,
      "nome": "Just Dance 2017",
      "urlImagem": "https://images-submarino.b2w.io/produtos/01/00/item/129368/8/129368834_1GG.jpg",
      "descricao": "Mussum Ipsum, cacilds vidis litro abertis. Atirei o pau no gatis, per gatis num morreus. N??o sou faixa preta cumpadi, sou preto inteiris, inteiris. Praesent malesuada urna nisi, quis volutpat erat hendrerit non. Nam vulputate dapibus. Diuretics paradis num copo ?? motivis de denguis.<br/><br/>Copo furadis ?? disculpa de bebadis, arcu quam euismod magna. Casamentiss faiz malandris se pirulit??. Vehicula non. Ut sed ex eros. Vivamus sit amet nibh non tellus tristique interdum. in elementis m?? pra quem ?? amistosis quis leo.<br/><br/>A ordem dos tratores n??o altera o p??o duris Delegadis gente finis, bibendum egestas augue arcu ut est. M?? faiz elementum girarzis, nisi eros vermeio. Si u mundo t?? muito paradis? Toma um m?? que o mundo vai girarzis!",
      "precoDe": 299,
      "precoPor": 119.99,
      "categoria": {
        "id": 1,
        "descricao": "Games",
        "urlImagem": "http://39ahd9aq5l9101brf3b8dq58.wpengine.netdna-cdn.com/wp-content/uploads/2013/06/3D-Gaming.png"
      }
    },
    {
      "id": 14,
      "nome": "Skyrim",
      "urlImagem": "https://images-submarino.b2w.io/produtos/01/00/item/129768/6/129768635_1GG.jpg",
      "descricao": "Primeiro eu queria cumprimentar os internautas. -Oi Internautas! Depois dizer que o meio ambiente ?? sem d??vida nenhuma uma amea??a ao desenvolvimento sustent??vel. E isso significa que ?? uma amea??a pro futuro do nosso planeta e dos nossos pa??ses. O desemprego beira 20%, ou seja, 1 em cada 4 portugueses.<br/><br/>A popula????o ela precisa da Zona Franca de Manaus, porque na Zona franca de Manaus, n??o ?? uma zona de exporta????o, ?? uma zona para o Brasil. Portanto ela tem um objetivo, ela evita o desmatamento, que ?? altamente lucravito. Derrubar arvores da natureza ?? muito lucrativo!<br/><br/>No meu xin??lo da humildade eu gostaria muito de ver o Neymar e o Ganso. Por que eu acho que.... 11 entre 10 brasileiros gostariam. Voc?? veja, eu j?? vi, parei de ver. Voltei a ver, e acho que o Neymar e o Ganso t??m essa capacidade de fazer a gente olhar.<br/><br/>",
      "precoDe": 299,
      "precoPor": 119.99,
      "categoria": {
        "id": 1,
        "descricao": "Games",
        "urlImagem": "http://39ahd9aq5l9101brf3b8dq58.wpengine.netdna-cdn.com/wp-content/uploads/2013/06/3D-Gaming.png"
      }
    },
    {
      "id": 15,
      "nome": "Dishonered 2",
      "urlImagem": "https://images-submarino.b2w.io/produtos/01/00/item/129773/7/129773776_1GG.jpg",
      "descricao": "Primeiro eu queria cumprimentar os internautas. -Oi Internautas! Depois dizer que o meio ambiente ?? sem d??vida nenhuma uma amea??a ao desenvolvimento sustent??vel. E isso significa que ?? uma amea??a pro futuro do nosso planeta e dos nossos pa??ses. O desemprego beira 20%, ou seja, 1 em cada 4 portugueses.<br/><br/>A popula????o ela precisa da Zona Franca de Manaus, porque na Zona franca de Manaus, n??o ?? uma zona de exporta????o, ?? uma zona para o Brasil. Portanto ela tem um objetivo, ela evita o desmatamento, que ?? altamente lucravito. Derrubar arvores da natureza ?? muito lucrativo!<br/><br/>No meu xin??lo da humildade eu gostaria muito de ver o Neymar e o Ganso. Por que eu acho que.... 11 entre 10 brasileiros gostariam. Voc?? veja, eu j?? vi, parei de ver. Voltei a ver, e acho que o Neymar e o Ganso t??m essa capacidade de fazer a gente olhar.<br/><br/>",
      "precoDe": 299,
      "precoPor": 119.99,
      "categoria": {
        "id": 1,
        "descricao": "Games",
        "urlImagem": "http://39ahd9aq5l9101brf3b8dq58.wpengine.netdna-cdn.com/wp-content/uploads/2013/06/3D-Gaming.png"
      }
    },
    {
      "id": 16,
      "nome": "Assassins Creed",
      "urlImagem": "https://images-submarino.b2w.io/produtos/01/00/item/129735/8/129735892_1GG.jpg",
      "descricao": "Mussum Ipsum, cacilds vidis litro abertis. Atirei o pau no gatis, per gatis num morreus. N??o sou faixa preta cumpadi, sou preto inteiris, inteiris. Praesent malesuada urna nisi, quis volutpat erat hendrerit non. Nam vulputate dapibus. Diuretics paradis num copo ?? motivis de denguis.<br/><br/>Copo furadis ?? disculpa de bebadis, arcu quam euismod magna. Casamentiss faiz malandris se pirulit??. Vehicula non. Ut sed ex eros. Vivamus sit amet nibh non tellus tristique interdum. in elementis m?? pra quem ?? amistosis quis leo.<br/><br/>A ordem dos tratores n??o altera o p??o duris Delegadis gente finis, bibendum egestas augue arcu ut est. M?? faiz elementum girarzis, nisi eros vermeio. Si u mundo t?? muito paradis? Toma um m?? que o mundo vai girarzis!",
      "precoDe": 299,
      "precoPor": 119.99,
      "categoria": {
        "id": 1,
        "descricao": "Games",
        "urlImagem": "http://39ahd9aq5l9101brf3b8dq58.wpengine.netdna-cdn.com/wp-content/uploads/2013/06/3D-Gaming.png"
      }
    },
    {
      "id": 17,
      "nome": "Titanfall 2",
      "urlImagem": "https://images-submarino.b2w.io/produtos/01/00/item/129341/3/129341367_1GG.jpg",
      "descricao": "Primeiro eu queria cumprimentar os internautas. -Oi Internautas! Depois dizer que o meio ambiente ?? sem d??vida nenhuma uma amea??a ao desenvolvimento sustent??vel. E isso significa que ?? uma amea??a pro futuro do nosso planeta e dos nossos pa??ses. O desemprego beira 20%, ou seja, 1 em cada 4 portugueses.<br/><br/>A popula????o ela precisa da Zona Franca de Manaus, porque na Zona franca de Manaus, n??o ?? uma zona de exporta????o, ?? uma zona para o Brasil. Portanto ela tem um objetivo, ela evita o desmatamento, que ?? altamente lucravito. Derrubar arvores da natureza ?? muito lucrativo!<br/><br/>No meu xin??lo da humildade eu gostaria muito de ver o Neymar e o Ganso. Por que eu acho que.... 11 entre 10 brasileiros gostariam. Voc?? veja, eu j?? vi, parei de ver. Voltei a ver, e acho que o Neymar e o Ganso t??m essa capacidade de fazer a gente olhar.<br/><br/>",
      "precoDe": 299,
      "precoPor": 119.99,
      "categoria": {
        "id": 1,
        "descricao": "Games",
        "urlImagem": "http://39ahd9aq5l9101brf3b8dq58.wpengine.netdna-cdn.com/wp-content/uploads/2013/06/3D-Gaming.png"
      }
    },
    {
      "id": 18,
      "nome": "Dragon Ball 2 Xenoverse",
      "urlImagem": "https://images-submarino.b2w.io/produtos/01/00/item/129152/7/129152793_1GG.jpg",
      "descricao": "Mussum Ipsum, cacilds vidis litro abertis. Atirei o pau no gatis, per gatis num morreus. N??o sou faixa preta cumpadi, sou preto inteiris, inteiris. Praesent malesuada urna nisi, quis volutpat erat hendrerit non. Nam vulputate dapibus. Diuretics paradis num copo ?? motivis de denguis.<br/><br/>Copo furadis ?? disculpa de bebadis, arcu quam euismod magna. Casamentiss faiz malandris se pirulit??. Vehicula non. Ut sed ex eros. Vivamus sit amet nibh non tellus tristique interdum. in elementis m?? pra quem ?? amistosis quis leo.<br/><br/>A ordem dos tratores n??o altera o p??o duris Delegadis gente finis, bibendum egestas augue arcu ut est. M?? faiz elementum girarzis, nisi eros vermeio. Si u mundo t?? muito paradis? Toma um m?? que o mundo vai girarzis!",
      "precoDe": 299,
      "precoPor": 119.99,
      "categoria": {
        "id": 1,
        "descricao": "Games",
        "urlImagem": "http://39ahd9aq5l9101brf3b8dq58.wpengine.netdna-cdn.com/wp-content/uploads/2013/06/3D-Gaming.png"
      }
    },
    {
      "id": 19,
      "nome": "Hitman",
      "urlImagem": "https://images-submarino.b2w.io/produtos/01/00/item/131017/8/131017814_1GG.jpg",
      "descricao": "Mussum Ipsum, cacilds vidis litro abertis. Atirei o pau no gatis, per gatis num morreus. N??o sou faixa preta cumpadi, sou preto inteiris, inteiris. Praesent malesuada urna nisi, quis volutpat erat hendrerit non. Nam vulputate dapibus. Diuretics paradis num copo ?? motivis de denguis.<br/><br/>Copo furadis ?? disculpa de bebadis, arcu quam euismod magna. Casamentiss faiz malandris se pirulit??. Vehicula non. Ut sed ex eros. Vivamus sit amet nibh non tellus tristique interdum. in elementis m?? pra quem ?? amistosis quis leo.<br/><br/>A ordem dos tratores n??o altera o p??o duris Delegadis gente finis, bibendum egestas augue arcu ut est. M?? faiz elementum girarzis, nisi eros vermeio. Si u mundo t?? muito paradis? Toma um m?? que o mundo vai girarzis!",
      "precoDe": 299,
      "precoPor": 119.99,
      "categoria": {
        "id": 1,
        "descricao": "Games",
        "urlImagem": "http://39ahd9aq5l9101brf3b8dq58.wpengine.netdna-cdn.com/wp-content/uploads/2013/06/3D-Gaming.png"
      }
    },
    {
      "id": 20,
      "nome": "Ghost Recon",
      "urlImagem": "https://images-submarino.b2w.io/produtos/01/00/item/131132/6/131132644_1GG.jpg",
      "descricao": "Mussum Ipsum, cacilds vidis litro abertis. Atirei o pau no gatis, per gatis num morreus. N??o sou faixa preta cumpadi, sou preto inteiris, inteiris. Praesent malesuada urna nisi, quis volutpat erat hendrerit non. Nam vulputate dapibus. Diuretics paradis num copo ?? motivis de denguis.<br/><br/>Copo furadis ?? disculpa de bebadis, arcu quam euismod magna. Casamentiss faiz malandris se pirulit??. Vehicula non. Ut sed ex eros. Vivamus sit amet nibh non tellus tristique interdum. in elementis m?? pra quem ?? amistosis quis leo.<br/><br/>A ordem dos tratores n??o altera o p??o duris Delegadis gente finis, bibendum egestas augue arcu ut est. M?? faiz elementum girarzis, nisi eros vermeio. Si u mundo t?? muito paradis? Toma um m?? que o mundo vai girarzis!",
      "precoDe": 299,
      "precoPor": 119.99,
      "categoria": {
        "id": 1,
        "descricao": "Games",
        "urlImagem": "http://39ahd9aq5l9101brf3b8dq58.wpengine.netdna-cdn.com/wp-content/uploads/2013/06/3D-Gaming.png"
      }
    },
    {
      "id": 21,
      "nome": "Mafia 3",
      "urlImagem": "https://images-submarino.b2w.io/produtos/01/00/item/128938/9/128938997_1GG.jpg",
      "descricao": "Primeiro eu queria cumprimentar os internautas. -Oi Internautas! Depois dizer que o meio ambiente ?? sem d??vida nenhuma uma amea??a ao desenvolvimento sustent??vel. E isso significa que ?? uma amea??a pro futuro do nosso planeta e dos nossos pa??ses. O desemprego beira 20%, ou seja, 1 em cada 4 portugueses.<br/><br/>A popula????o ela precisa da Zona Franca de Manaus, porque na Zona franca de Manaus, n??o ?? uma zona de exporta????o, ?? uma zona para o Brasil. Portanto ela tem um objetivo, ela evita o desmatamento, que ?? altamente lucravito. Derrubar arvores da natureza ?? muito lucrativo!<br/><br/>No meu xin??lo da humildade eu gostaria muito de ver o Neymar e o Ganso. Por que eu acho que.... 11 entre 10 brasileiros gostariam. Voc?? veja, eu j?? vi, parei de ver. Voltei a ver, e acho que o Neymar e o Ganso t??m essa capacidade de fazer a gente olhar.<br/><br/>",
      "precoDe": 299,
      "precoPor": 119.99,
      "categoria": {
        "id": 1,
        "descricao": "Games",
        "urlImagem": "http://39ahd9aq5l9101brf3b8dq58.wpengine.netdna-cdn.com/wp-content/uploads/2013/06/3D-Gaming.png"
      }
    },
    {
      "id": 22,
      "nome": "Halo Wars 2",
      "urlImagem": "https://images-submarino.b2w.io/produtos/01/00/item/130949/4/130949468_1GG.jpg",
      "descricao": "Primeiro eu queria cumprimentar os internautas. -Oi Internautas! Depois dizer que o meio ambiente ?? sem d??vida nenhuma uma amea??a ao desenvolvimento sustent??vel. E isso significa que ?? uma amea??a pro futuro do nosso planeta e dos nossos pa??ses. O desemprego beira 20%, ou seja, 1 em cada 4 portugueses.<br/><br/>A popula????o ela precisa da Zona Franca de Manaus, porque na Zona franca de Manaus, n??o ?? uma zona de exporta????o, ?? uma zona para o Brasil. Portanto ela tem um objetivo, ela evita o desmatamento, que ?? altamente lucravito. Derrubar arvores da natureza ?? muito lucrativo!<br/><br/>No meu xin??lo da humildade eu gostaria muito de ver o Neymar e o Ganso. Por que eu acho que.... 11 entre 10 brasileiros gostariam. Voc?? veja, eu j?? vi, parei de ver. Voltei a ver, e acho que o Neymar e o Ganso t??m essa capacidade de fazer a gente olhar.<br/><br/>",
      "precoDe": 299,
      "precoPor": 119.99,
      "categoria": {
        "id": 1,
        "descricao": "Games",
        "urlImagem": "http://39ahd9aq5l9101brf3b8dq58.wpengine.netdna-cdn.com/wp-content/uploads/2013/06/3D-Gaming.png"
      }
    },
    {
      "id": 23,
      "nome": "Batman VR",
      "urlImagem": "https://images-submarino.b2w.io/produtos/01/00/item/129345/1/129345173_1GG.jpg",
      "descricao": "Primeiro eu queria cumprimentar os internautas. -Oi Internautas! Depois dizer que o meio ambiente ?? sem d??vida nenhuma uma amea??a ao desenvolvimento sustent??vel. E isso significa que ?? uma amea??a pro futuro do nosso planeta e dos nossos pa??ses. O desemprego beira 20%, ou seja, 1 em cada 4 portugueses.<br/><br/>A popula????o ela precisa da Zona Franca de Manaus, porque na Zona franca de Manaus, n??o ?? uma zona de exporta????o, ?? uma zona para o Brasil. Portanto ela tem um objetivo, ela evita o desmatamento, que ?? altamente lucravito. Derrubar arvores da natureza ?? muito lucrativo!<br/><br/>No meu xin??lo da humildade eu gostaria muito de ver o Neymar e o Ganso. Por que eu acho que.... 11 entre 10 brasileiros gostariam. Voc?? veja, eu j?? vi, parei de ver. Voltei a ver, e acho que o Neymar e o Ganso t??m essa capacidade de fazer a gente olhar.<br/><br/>",
      "precoDe": 299,
      "precoPor": 119.99,
      "categoria": {
        "id": 1,
        "descricao": "Games",
        "urlImagem": "http://39ahd9aq5l9101brf3b8dq58.wpengine.netdna-cdn.com/wp-content/uploads/2013/06/3D-Gaming.png"
      }
    },
    {
      "id": 24,
      "nome": "Ride 2",
      "urlImagem": "https://images-submarino.b2w.io/produtos/01/00/item/131124/6/131124644_1GG.jpg",
      "descricao": "Mussum Ipsum, cacilds vidis litro abertis. Atirei o pau no gatis, per gatis num morreus. N??o sou faixa preta cumpadi, sou preto inteiris, inteiris. Praesent malesuada urna nisi, quis volutpat erat hendrerit non. Nam vulputate dapibus. Diuretics paradis num copo ?? motivis de denguis.<br/><br/>Copo furadis ?? disculpa de bebadis, arcu quam euismod magna. Casamentiss faiz malandris se pirulit??. Vehicula non. Ut sed ex eros. Vivamus sit amet nibh non tellus tristique interdum. in elementis m?? pra quem ?? amistosis quis leo.<br/><br/>A ordem dos tratores n??o altera o p??o duris Delegadis gente finis, bibendum egestas augue arcu ut est. M?? faiz elementum girarzis, nisi eros vermeio. Si u mundo t?? muito paradis? Toma um m?? que o mundo vai girarzis!",
      "precoDe": 299,
      "precoPor": 119.99,
      "categoria": {
        "id": 1,
        "descricao": "Games",
        "urlImagem": "http://39ahd9aq5l9101brf3b8dq58.wpengine.netdna-cdn.com/wp-content/uploads/2013/06/3D-Gaming.png"
      }
    },
    {
      "id": 25,
      "nome": "Devil May Cry",
      "urlImagem": "https://images-submarino.b2w.io/produtos/01/00/item/121800/6/121800696_1GG.jpg",
      "descricao": "Mussum Ipsum, cacilds vidis litro abertis. Atirei o pau no gatis, per gatis num morreus. N??o sou faixa preta cumpadi, sou preto inteiris, inteiris. Praesent malesuada urna nisi, quis volutpat erat hendrerit non. Nam vulputate dapibus. Diuretics paradis num copo ?? motivis de denguis.<br/><br/>Copo furadis ?? disculpa de bebadis, arcu quam euismod magna. Casamentiss faiz malandris se pirulit??. Vehicula non. Ut sed ex eros. Vivamus sit amet nibh non tellus tristique interdum. in elementis m?? pra quem ?? amistosis quis leo.<br/><br/>A ordem dos tratores n??o altera o p??o duris Delegadis gente finis, bibendum egestas augue arcu ut est. M?? faiz elementum girarzis, nisi eros vermeio. Si u mundo t?? muito paradis? Toma um m?? que o mundo vai girarzis!",
      "precoDe": 299,
      "precoPor": 119.99,
      "categoria": {
        "id": 1,
        "descricao": "Games",
        "urlImagem": "http://39ahd9aq5l9101brf3b8dq58.wpengine.netdna-cdn.com/wp-content/uploads/2013/06/3D-Gaming.png"
      }
    }
  ],
  "offset": 0,
  "total": 75
}
''';
