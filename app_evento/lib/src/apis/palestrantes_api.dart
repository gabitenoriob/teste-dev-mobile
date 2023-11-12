import 'dart:convert';

import 'package:app_evento/src/http/exceptions.dart';
import 'package:app_evento/src/http/http_client.dart';
import 'package:app_evento/src/models/palestrantes_model.dart';

abstract class IPalestrantes {
  Future<List<Palestrantes>> getPalestrantes();
}

class Palestrante implements IPalestrantes {
  final IHttpClient client;

  Palestrante({required this.client});

  @override
  @override
  Future<List<Palestrantes>> getPalestrantes() async {
    final response = await client.get(
        url:
            'https://api.doity.com.br/public/aplicativos/v2/eventos/24043/palestrantes?limit=200&d_rdhid=59c654f003e03cb1f34fb921af330a24cb619c99');

    if (response.statusCode == 200) {
      final List<Palestrantes> palestrantes = [];

      // Decodificando o JSON
      final dynamic body = jsonDecode(response.body);
      print('Conteúdo da resposta: $body');

      if (body is Map && body.containsKey('palestrantes')) {
        print('Entrou no bloco if');
        for (var item in body['palestrantes']) {
          print('Item do palestrante: $item');
          try {
            final Palestrantes palestrante = Palestrantes.fromJson(item);
            palestrantes.add(palestrante);
            print('Parceiro adicionado: $palestrante');
          } catch (e) {
            print('Erro ao criar Palestrantes a partir do JSON: $e');
          }
        }
        print('Lista de parceiros após o loop: $palestrantes');
      } else {
        print('Não encontrou a chave "palestrantes" na resposta.');
      }

      return palestrantes;
    } else if (response.statusCode == 404) {
      throw NotFoundException("A URL informada não é válida");
    } else {
      throw Exception("Não foi possível carregar");
    }
  }
}
