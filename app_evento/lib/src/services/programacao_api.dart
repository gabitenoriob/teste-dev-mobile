import 'dart:convert';
import 'package:http/http.dart' as http;

class Programacao {
  final List<Atividade> horarios;

  Programacao({required this.horarios});

  factory Programacao.fromJson(Map<String, dynamic> json) {
    final List<dynamic> horarios = json['horarios'];
    return Programacao(
      horarios: horarios.map((data) => Atividade.fromJson(data)).toList(),
    );
  }
}

class Atividade {
  final String nome;
  final String descricao;

  Atividade({required this.nome, required this.descricao});

  factory Atividade.fromJson(Map<String, dynamic> json) {
    return Atividade(
      nome: json['nome'],
      descricao: json['descricao'],
    );
  }

  get data_atividade => null;

  get atividades => null;
}

class ApiService {
  final String baseUrl =
      'https://api.doity.com.br/public/aplicativos/v2/eventos/24043/atividades_horarios';

  Future<Programacao> fetchProgramacao() async {
    final response = await http.get(Uri.parse(
        '$baseUrl?sort=hora_inicio&direction=ASC&limit=200&d_rdhid=59c654f003e03cb1f34fb921af330a24cb619c99'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Programacao.fromJson(data);
    } else {
      throw ApiRequestException(
          'Falha na solicitação: ${response.reasonPhrase}');
    }
  }
}

class ApiRequestException implements Exception {
  final String message;

  ApiRequestException(this.message);

  @override
  String toString() {
    return 'ApiRequestException: $message';
  }
}

void main() async {
  final apiService = ApiService();

  try {
    final programacao = await apiService.fetchProgramacao();
    // Use os dados da programação conforme necessário
    print(programacao.horarios[0].nome);
    print(programacao.horarios[0].descricao);
  } catch (e) {
    print(e);
  }
}
