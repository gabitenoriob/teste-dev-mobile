class Horarios {
  final int id;
  final String dataAtividade;
  final String horaInicio;
  final String horaFim;
  final int idAtividade;
  Atividade atividade;
  final String? listaPalestrantes;

  Horarios({
    required this.id,
    required this.dataAtividade,
    required this.horaInicio,
    required this.horaFim,
    required this.atividade,
    required this.idAtividade,
    this.listaPalestrantes,
  });

  factory Horarios.fromJson(Map<String, dynamic> json) {
    return Horarios(
        id: json['id'],
        dataAtividade: json['data _atividade'] ?? " ",
        horaInicio: json['hora_inicio'],
        horaFim: json['hora_fim'],
        atividade: Atividade.fromJson(json['atividade']), 
        idAtividade: json['atividade_id'],
        listaPalestrantes: json['lista_palestrantes'] ?? " ");
  }
}

class Atividade {
  final int id;
  final String nome;
  final String descricao;
  final String local;
  final Bloco? bloco;
  List<Palestrante> palestrantes;

  Atividade({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.local,
    this.bloco,
    required this.palestrantes,
  });

  factory Atividade.fromJson(Map<String, dynamic> json) {
    return Atividade(
      id: json['id'],
      nome: json['nome'] ?? "Nome não disponível",
      descricao: json['descricao'] ?? "Descrição não disponível",
      local: json['local'] ?? "Local não disponível",
      bloco: json['bloco'] != null ? Bloco.fromMap(json['bloco']) : null,
      palestrantes: (json['palestrantes'] as List? ?? [])
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

class Palestrante {
  final int id;
  final String nome;
  final String empresa;
  final String descricao;
  final String imagem;
  final int ordem;

  Palestrante({
    required this.id,
    required this.nome,
    required this.empresa,
    required this.descricao,
    required this.imagem,
    required this.ordem,
  });

  factory Palestrante.fromJson(Map<String, dynamic> json) {
    return Palestrante(
      id: json['id'],
      nome: json['nome'],
      empresa: json['empresa'],
      descricao: json['descricao'],
      imagem: json['imagem'],
      ordem: json['ordem'],
    );
  }
}
