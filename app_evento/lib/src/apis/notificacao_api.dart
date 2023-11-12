import 'dart:convert';
import 'package:app_evento/src/http/exceptions.dart';
import 'package:app_evento/src/http/http_client.dart';
import 'package:app_evento/src/models/notificacao_model.dart';

abstract class INotificacao{
  Future<List<Notificacao>> getNotificacao();
}

class Notificacaos implements INotificacao {
  final IHttpClient client;

  Notificacaos({required this.client});

  @override
  @override
  Future<List<Notificacao>> getNotificacao() async {
    final response = await client.get(
        url:
            'https://api.doity.com.br/public/aplicativos/v2/eventos/24043/apps/20/notificacoes?status=3&sort=id&direction=desc&limit=200&servico_id=1&d_rdhid=59c654f003e03cb1f34fb921af330a24cb619c99');

    if (response.statusCode == 200) {
      final List<Notificacao> notificacoes = [];

      // Decodificando o JSON
      final dynamic body = jsonDecode(response.body);
      print('Conteúdo da resposta: $body');

      if (body is Map && body.containsKey('notificacoes')) {
        print('Entrou no bloco if');
        for (var item in body['notificacoes']) {
          print('Item do Notificacao: $item');
          try {
            final Notificacao notificacao = Notificacao.fromJson(item);
            notificacoes.add(notificacao);
            print('Parceiro adicionado: $notificacao');
          } catch (e) {
            print('Erro ao criar Notificacao a partir do JSON: $e');
          }
        }
        print('Lista de parceiros após o loop: $notificacoes');
      } else {
        print('Não encontrou a chave "parceiros" na resposta.');
      }

      return notificacoes;
    } else if (response.statusCode == 404) {
      throw NotFoundException("A URL informada não é válida");
    } else {
      throw Exception("Não foi possível carregar");
    }
  }
}
