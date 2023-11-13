import 'dart:convert';
import 'package:app_evento/src/http/exceptions.dart';
import 'package:app_evento/src/http/http_client.dart';
import 'package:app_evento/src/models/conteudos_model.dart';

// Interface que define os métodos que a classe Conteudos deve implementar
abstract class IConteudos {
  Future<List<Conteudo>> getConteudos();
}

// Classe Conteudos que implementa a interface IConteudos
class Conteudos implements IConteudos {
  final IHttpClient client;

  Conteudos({required this.client});

  @override
  Future<List<Conteudo>> getConteudos() async {
    // Faz uma solicitação HTTP GET para obter conteúdos de um evento
    final response = await client.get(
        url:
            'https://api.doity.com.br/public/aplicativos/v2/eventos/24043/apps/20/conteudos?ativo=1&sort=ordem&direction=asc&limit=200&d_rdhid=59c654f003e03cb1f34fb921af330a24cb619c99');

    if (response.statusCode == 200) {
      final List<Conteudo> conteudos = [];

      // Decodificando a resposta JSON
      final dynamic body = jsonDecode(response.body);

      if (body is Map && body.containsKey('conteudos')) {
        print('Entrou no bloco if');
        for (var item in body['conteudos']) {
          print('Item do conteudos: $item');
          try {
            // Tenta criar um objeto Conteudo a partir dos dados JSON
            final Conteudo conteudo = Conteudo.fromJson(item as Map<String, dynamic>);
            conteudos.add(conteudo);
            print('conteudo adicionado: $conteudo');
          } catch (e) {
            print('Erro ao criar Conteudo a partir do JSON: $e');
          }
        }
        print('Lista de conteudos após o loop: $conteudos');
      } else {
        print('Não encontrou a chave "conteudos" na resposta.');
      }

      return conteudos;
    } else if (response.statusCode == 404) {
      // Lança uma exceção personalizada se a URL não for válida
      throw NotFoundException("A URL informada não é válida");
    } else {
      // Lança uma exceção genérica se não for possível carregar os dados
      throw Exception("Não foi possível carregar");
    }
  }
}
