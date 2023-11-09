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
      dataAtividade: map['data _atividade'],
      horaInicio: map['hora_inicio'],
      horaFim: map['hora_fim'],
      atividade: Atividade.fromMap(map['atividade']), // Mapeia a atividade
      idAtividade: map['atividade_id'],
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
      nome: map['nome'] ?? "Nome não disponível",
      descricao: map['descricao'] ?? "Descrição não disponível",
      local: map['local'] ?? "Local não disponível",
      bloco: Bloco.fromMap(
          map['bloco'] ?? {}), // Passa um mapa vazio se bloco for nulo
      palestrantes: (map['lista_palestrantes'] as List? ?? []).isEmpty
          ? [
              Palestrante(
                  id: 0,
                  nome: "Sem Palestrantes",
                  empresa: "",
                  descricao: "",
                  imagem: "",
                  ordem: 0)
            ]
          : (map['palestrantes'] as List)
              .map((palestranteData) => Palestrante.fromMap(palestranteData))
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
