import 'dart:convert';

import 'package:app_evento/src/http/exceptions.dart';
import 'package:app_evento/src/http/http_client.dart';
import 'package:app_evento/src/models/programacao_model.dart';

abstract class IProgramacao {
  Future<List<Horarios>> getProgramacao();
}

class Programacao implements IProgramacao {
  final IHttpClient client;

  Programacao({required this.client});

  @override
  Future<List<Horarios>> getProgramacao() async {
    final response = await client.get(
        url:
            'https://api.doity.com.br/public/aplicativos/v2/eventos/24043/atividades_horarios?sort=hora_inicio&direction=ASC&limit=200&d_rdhid=59c654f003e03cb1f34fb921af330a24cb619c99');

    if (response.statusCode == 200) {
      final List<Horarios> horarios = [];
      
      //decodificando o json
      final body = jsonDecode(response.body);

      body['horarios'].map((item) {
        final Horarios horario = Horarios.fromMap(item);
        // nao passa daqui ai ta dando empty pq n ta adicionando na lista 
        horarios.add(horario);
      }).toList();
      return horarios;
    } else if (response.statusCode == 404) {
      throw NotFoundException("A url informada não é válida");
    } else {
      throw Exception("Não foi possivel carregar");
    }
  }
}
