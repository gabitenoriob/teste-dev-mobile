import 'package:app_evento/src/models/programacao_model.dart';

class Palestrantes {
  final int id;
  final String nome;
  final String empresa;
  final String descricao;
  final String imagem;
  final int ordem;
  Atividade atividade;

  Palestrantes(
      {required this.nome,
      required this.id,
      required this.ordem,
      required this.descricao,
      required this.empresa,
      required this.imagem,
      required this.atividade});

  factory Palestrantes.fromJson(Map<String, dynamic> json) {
    return Palestrantes(
      id: json['id'],
      ordem: json['ordem'],
      descricao: json['descrição'] ,
      imagem: json['imagem'],
      atividade: Atividade.fromJson(json['atividade']),
      nome: json['nome'],
      empresa: json['empresa'],
    );
  }
}
