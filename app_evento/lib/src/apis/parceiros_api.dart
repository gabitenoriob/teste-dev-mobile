import 'dart:convert';
import 'package:app_evento/src/http/exceptions.dart';
import 'package:app_evento/src/http/http_client.dart';
import 'package:app_evento/src/models/paceiros_model.dart';

// Interface que define os métodos que a classe Parceiro deve implementar
abstract class IParceiros {
  Future<List<Parceiros>> getParceiros();
}

// Classe Parceiro que implementa a interface IParceiros
class Parceiro implements IParceiros {
  final IHttpClient client;

  Parceiro({required this.client});

  @override
  Future<List<Parceiros>> getParceiros() async {
    // Faz uma solicitação HTTP GET para obter informações de parceiros
    final response = await client.get(
        url:
            'https://api.doity.com.br/public/aplicativos/v2/eventos/24043/parceiros?sort=ordem&direction=ASC&limit=200&d_rdhid=59c654f003e03cb1f34fb921af330a24cb619c99');

    if (response.statusCode == 200) {
      final List<Parceiros> parceiros = [];

      // Decodificando a resposta JSON
      final dynamic body = jsonDecode(response.body);
      print('Conteúdo da resposta: $body');

      if (body is Map && body.containsKey('parceiros')) {
        print('Entrou no bloco if');
        for (var item in body['parceiros']) {
          print('Item do parceiro: $item');
          try {
            // Tenta criar um objeto Parceiros a partir dos dados JSON
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
      // Lança uma exceção personalizada se a URL não for válida
      throw NotFoundException("A URL informada não é válida");
    } else {
      // Lança uma exceção genérica se não for possível carregar os dados
      throw Exception("Não foi possível carregar");
    }
  }
}
