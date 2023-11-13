import 'dart:convert';
import 'package:app_evento/src/http/exceptions.dart';
import 'package:app_evento/src/http/http_client.dart';
import 'package:app_evento/src/models/notificacao_model.dart';

// Interface que define os métodos que a classe Notificacaos deve implementar
abstract class INotificacao {
  Future<List<Notificacao>> getNotificacao();
}

// Classe Notificacaos que implementa a interface INotificacao
class Notificacaos implements INotificacao {
  final IHttpClient client;

  Notificacaos({required this.client});

  @override
  Future<List<Notificacao>> getNotificacao() async {
    // Faz uma solicitação HTTP GET para obter notificações de um evento
    final response = await client.get(
        url:
            'https://api.doity.com.br/public/aplicativos/v2/eventos/24043/apps/20/notificacoes?status=3&sort=id&direction=desc&limit=200&servico_id=1&d_rdhid=59c654f003e03cb1f34fb921af330a24cb619c99');

    if (response.statusCode == 200) {
      final List<Notificacao> notificacoes = [];

      // Decodificando a resposta JSON
      final dynamic body = jsonDecode(response.body);
      print('Conteúdo da resposta: $body');

      if (body is Map && body.containsKey('notificacoes')) {
        print('Entrou no bloco if');
        for (var item in body['notificacoes']) {
          print('Item do Notificacao: $item');
          try {
            // Tenta criar um objeto Notificacao a partir dos dados JSON
            final Notificacao notificacao = Notificacao.fromJson(item);
            notificacoes.add(notificacao);
            print('Notificacao adicionada: $notificacao');
          } catch (e) {
            print('Erro ao criar Notificacao a partir do JSON: $e');
          }
        }
        print('Lista de notificacoes após o loop: $notificacoes');
      } else {
        print('Não encontrou a chave "notificacoes" na resposta.');
      }

      return notificacoes;
    } else if (response.statusCode == 404) {
      // Lança uma exceção personalizada se a URL não for válida
      throw NotFoundException("A URL informada não é válida");
    } else {
      // Lança uma exceção genérica se não for possível carregar os dados
      throw Exception("Não foi possível carregar");
    }
  }
}
