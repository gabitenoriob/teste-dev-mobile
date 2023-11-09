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
  Future<List<Parceiros>> getParceiros() async {
    final response = await client.get(
        url:
            'https://api.doity.com.br/public/aplicativos/v2/eventos/24043/parceiros?sort=ordem&direction=ASC&limit=200&d_rdhid=59c654f003e03cb1f34fb921af330a24cb619c99');

    if (response.statusCode == 200) {
      final List<Parceiros> parceiros = [];

      //decodificando o json
      final body = jsonDecode(response.body);

      body['parceiros'].map((item) {
        final Parceiros parceiro = Parceiros.fromMap(item);
        // nao passa daqui
        parceiros.add(parceiro);
      }).toList();
      return parceiros;
    } else if (response.statusCode == 404) {
      throw NotFoundException("A url informada não é válida");
    } else {
      throw Exception("Não foi possivel carregar");
    }
  }
}
