class Horarios {
  final int id;
  final String dataAtividade;
  final String horaInicio;
  final String horaFim;
  final int idAtividade;
  Atividade atividade;

  Horarios({
    required this.id,
    required this.dataAtividade,
    required this.horaInicio,
    required this.horaFim,
    required this.atividade,
    required this.idAtividade,
  });

  factory Horarios.fromMap(Map<String, dynamic> map) {
    return Horarios(
      id: map['id'],
      dataAtividade: map['dataAtividade'],
      horaInicio: map['horaInicio'],
      horaFim: map['horaFim'],
      atividade: Atividade.fromMap(map['atividade']), // Mapeia a atividade
      idAtividade: map['idAtividade'],
    );
  }
}

class Atividade {
  final int id;
  final String nome;
  final String descricao;
  final String local;
  final Bloco bloco;
  List<Palestrante> palestrantes;

  Atividade({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.local,
    required this.bloco,
    required this.palestrantes,
  });

  factory Atividade.fromMap(Map<String, dynamic> map) {
    return Atividade(
      id: map['id'],
      nome: map['nome'],
      descricao: map['descricao'],
      local: map['local'],
      bloco: Bloco.fromMap(map['bloco']), // Mapeia o bloco
      palestrantes: (map['palestrantes'] as List)
          .map((palestranteData) => Palestrante.fromMap(palestranteData))
          .toList(), // Mapeia a lista de palestrantes
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

  factory Palestrante.fromMap(Map<String, dynamic> map) {
    return Palestrante(
      id: map['id'],
      nome: map['nome'],
      empresa: map['empresa'],
      descricao: map['descricao'],
      imagem: map['imagem'],
      ordem: map['ordem'],
    );
  }
}
