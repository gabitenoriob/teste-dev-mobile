import 'dart:convert';

import 'package:app_evento/src/http/exceptions.dart';
import 'package:app_evento/src/http/http_client.dart';
import 'package:app_evento/src/models/palestrantes_model.dart';

// Interface que define os métodos que a classe Palestrante deve implementar
abstract class IPalestrantes {
  Future<List<Palestrantes>> getPalestrantes();
}

// Classe Palestrante que implementa a interface IPalestrantes
class Palestrante implements IPalestrantes {
  final IHttpClient client;

  Palestrante({required this.client});

  @override
  Future<List<Palestrantes>> getPalestrantes() async {
    // Faz uma solicitação HTTP GET para obter informações de palestrantes
    final response = await client.get(
        url:
            'https://api.doity.com.br/public/aplicativos/v2/eventos/24043/palestrantes?limit=200&d_rdhid=59c654f003e03cb1f34fb921af330a24cb619c99');

    if (response.statusCode == 200) {
      final List<Palestrantes> palestrantes = [];

      // Decodificando a resposta JSON
      final dynamic body = jsonDecode(response.body);
      print('Conteúdo da resposta: $body');

      if (body is Map && body.containsKey('palestrantes')) {
        print('Entrou no bloco if');
        for (var item in body['palestrantes']) {
          print('Item do palestrante: $item');
          try {
            // Tenta criar um objeto Palestrantes a partir dos dados JSON
            final Palestrantes palestrante = Palestrantes.fromJson(item);
            palestrantes.add(palestrante);
            print('Palestrante adicionado: $palestrante');
          } catch (e) {
            print('Erro ao criar Palestrantes a partir do JSON: $e');
          }
        }
        print('Lista de palestrantes após o loop: $palestrantes');
      } else {
        print('Não encontrou a chave "palestrantes" na resposta.');
      }

      return palestrantes;
    } else if (response.statusCode == 404) {
      // Lança uma exceção personalizada se a URL não for válida
      throw NotFoundException("A URL informada não é válida");
    } else {
      // Lança uma exceção genérica se não for possível carregar os dados
      throw Exception("Não foi possível carregar");
    }
  }
}
