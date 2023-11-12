import 'package:app_evento/src/models/programacao_model.dart';

class Palestrantes {
  final int id;
  final int ordem;
  final String nome;
  final String empresa;
  final String descricao;
  final String imagem;
  Atividade atividade;

  Palestrantes({
    required this.ordem,
    required this.id,
    required this.nome,
    required this.descricao,
    required this.empresa,
    required this.imagem,
    required this.atividade,
  });

  factory Palestrantes.fromJson(Map<String, dynamic> json) {
    return Palestrantes(
      ordem: json['ordem'],
      id: json['id'],
      descricao: json['descricao'],
      imagem: json['imagem'],
      atividade: Atividade.fromJson(json['atividades'][0]),
      nome: json['nome'],
      empresa: json['empresa'],
    );
  }
}

class Atividade {
  final int id;
  final String nome;
  final String descricao;
  final String local;
  final Bloco? bloco;
  final List<Palestrante> palestrantes;

  Atividade({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.local,
    this.bloco,
    required this.palestrantes,
  });

  factory Atividade.fromJson(Map<String, dynamic> json) {
    final palestrantesData = json['palestrantes'] as List? ?? [];

    return Atividade(
      id: json['id'],
      nome: json['nome'] ?? "Nome não disponível",
      descricao: json['descricao'] ?? "Descrição não disponível",
      local: json['local'] ?? "Local não disponível",
      bloco: json['bloco'] != null ? Bloco.fromMap(json['bloco']) : null,
      palestrantes: palestrantesData
          .map((palestrantes) => Palestrante.fromJson(palestrantes))
          .toList(),
    );
  }
}

class Bloco {
  final int id;
  final String nome;
  final int ordem;
  final String cor;

  Bloco({
    required this.id,
    required this.nome,
    required this.ordem,
    required this.cor,
  });

  factory Bloco.fromMap(Map<String, dynamic> map) {
    return Bloco(
      id: map['id'],
      nome: map['nome'],
      ordem: map['ordem'],
      cor: map['cor'],
    );
  }
}
