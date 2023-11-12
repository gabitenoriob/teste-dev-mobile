class Notificacao {
  final int id;
  final int status;
  final String mensagem;
  final String created;
  final String titulo;
  final bool atualizacao;
  Servico servico;
  App app;

  Notificacao({
    required this.id,
    required this.status,
    required this.mensagem,
    required this.atualizacao,
    required this.created,
    required this.servico,
    required this.titulo,
    required this.app,
  });

  factory Notificacao.fromJson(Map<String, dynamic> json) {
    return Notificacao(
      id: json['id'],
      mensagem: json['mensagem'],
      status: json['status'],
      created: json['created'],
      titulo: json['titulo'],
      atualizacao: json['atualizacao'],
      servico: Servico.fromMap(json['servico']),
      app: App.fromMap(json['app']),
    );
  }
}

class Servico {
  final int id;
  final String nome;

  Servico({
    required this.id,
    required this.nome,
  });

  factory Servico.fromMap(Map<String, dynamic> map) {
    return Servico(
      id: map['id'],
      nome: map['nome'],
    );
  }
}

class App {
  final int id;
  final String nome;
  final String banner;
  final String mapa;
  final String tema;
  final String nps;
  final String googleAnalytics;
  final bool ativo;
  final bool permitirNotificacao;
  final bool atualizacao;

  App({
    required this.id,
    required this.nome,
    required this.ativo,
    required this.atualizacao,
    required this.banner,
    required this.googleAnalytics,
    required this.mapa,
    required this.nps,
    required this.permitirNotificacao,
    required this.tema,
  });

  factory App.fromMap(Map<String, dynamic> map) {
    return App(
      id: map['id'],
      nome: map['nome'],
      ativo: map['ativo'],
      atualizacao: map['atualizacao'],
      banner: map['banner'],
      googleAnalytics: map['google_analytics'],
      mapa: map['mapa'],
      nps: map['nps'],
      permitirNotificacao: map['permitir_notificacoes'],
      tema: map['tema'],
    );
  }
}
