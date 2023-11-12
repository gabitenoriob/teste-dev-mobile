import 'dart:convert';

import 'package:app_evento/src/http/exceptions.dart';
import 'package:app_evento/src/http/http_client.dart';
import 'package:app_evento/src/models/paceiros_model.dart';

abstract class IParceiros {
  Future<List<Parceiros>> getParceiros();
}

class Parceiro implements IParceiros {
  final IHttpClient client;

  Parceiro({required this.client});

  @override
  @override
  Future<List<Parceiros>> getParceiros() async {
    final response = await client.get(
        url:
            'https://api.doity.com.br/public/aplicativos/v2/eventos/24043/parceiros?sort=ordem&direction=ASC&limit=200&d_rdhid=59c654f003e03cb1f34fb921af330a24cb619c99');

    if (response.statusCode == 200) {
      final List<Parceiros> parceiros = [];

      // Decodificando o JSON
      final dynamic body = jsonDecode(response.body);
      print('Conteúdo da resposta: $body');

      if (body is Map && body.containsKey('parceiros')) {
        print('Entrou no bloco if');
        for (var item in body['parceiros']) {
          print('Item do parceiro: $item');
          try {
            final Parceiros parceiro = Parceiros.fromJson(item);
            parceiros.add(parceiro);
            print('Parceiro adicionado: $parceiro');
          } catch (e) {
            print('Erro ao criar Parceiros a partir do JSON: $e');
          }
        }
        print('Lista de parceiros após o loop: $parceiros');
      } else {
        print('Não encontrou a chave "parceiros" na resposta.');
      }

      return parceiros;
    } else if (response.statusCode == 404) {
      throw NotFoundException("A URL informada não é válida");
    } else {
      throw Exception("Não foi possível carregar");
    }
  }
}
