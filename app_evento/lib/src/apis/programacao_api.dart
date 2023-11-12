import 'dart:convert';
import 'package:app_evento/src/http/exceptions.dart';
import 'package:app_evento/src/http/http_client.dart';
import 'package:app_evento/src/models/programacao_model.dart';

abstract class IProgramacao {
  Future<List<Horarios>> getHorarios();
}

class Programacao implements IProgramacao {
  final IHttpClient client;

  Programacao({required this.client});

  @override
  @override
  Future<List<Horarios>> getHorarios() async {
    final response = await client.get(
        url:
            'https://api.doity.com.br/public/aplicativos/v2/eventos/24043/atividades_horarios?sort=hora_inicio&direction=ASC&limit=200&d_rdhid=59c654f003e03cb1f34fb921af330a24cb619c99?sort=hora_inicio&direction=ASC&limit=200&d_rdhid=59c654f003e03cb1f34fb921af330a24cb619c99');

    if (response.statusCode == 200) {
      final List<Horarios> horarios = [];

      // Decodificando o JSON
      final dynamic body = jsonDecode(response.body);
      print('Conteúdo da resposta: $body');

      if (body is Map && body.containsKey('horarios')) {
        print('Entrou no bloco if');
        for (var item in body['horarios']) {
          print('Item do horario: $item\n');
          try {
            final Horarios horario = Horarios.fromJson(item);
            horarios.add(horario);
            print('\n\nHorarioadicionado: $horario\n\n');
          } catch (e) {
            print('Erro ao criar Programacao a partir do JSON: $e');
          }
        }
        print('Lista de horarios após o loop: $horarios');
      } else {
        print('Não encontrou a chave "horarios" na resposta.');
      }

      return horarios;
    } else if (response.statusCode == 404) {
      throw NotFoundException("A URL informada não é válida");
    } else {
      throw Exception("Não foi possível carregar");
    }
  }
}
