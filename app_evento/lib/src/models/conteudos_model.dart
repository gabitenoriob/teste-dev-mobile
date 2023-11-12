
import 'package:app_evento/src/models/notificacao_model.dart';

class Conteudo {
  final int id;
  final String titulo;
  Icone icone;
  final String texto;
  final String imagem;
  Tipo tipo;
  App app;

  Conteudo({
    required this.id,
    required this.titulo,
    required this.icone,
    required this.texto,
    required this.imagem,
    required this.tipo,
    required this.app,
  });

  factory Conteudo.fromJson(Map<String, dynamic> json) {
    return Conteudo(
      id: json['id'],
      texto: json['texto'],
      imagem: json['imagem'],
      titulo: json['titulo'],
      app: App.fromMap(json['app']),
      icone: Icone.fromJson(json['icone']),
      tipo: Tipo.fromJson(json['tipo']),
    );
  }
}

class Tipo {
  final int id;
  final String nome;

  Tipo({
    required this.id,
    required this.nome,
  });

  factory Tipo.fromJson(Map<String, dynamic> json) {
    return Tipo(
      id: json['id'],
      nome: json['nome'],
    );
  }
}

class Icone {
  final String classe;
  final String code;
  final String nome;

  Icone({
    required this.classe,
    required this.code,
    required this.nome,
  });

  factory Icone.fromJson(Map<String, dynamic> json) {
    return Icone(
      classe: json['class'],
      code: json['code'],
      nome: json['nome'],
    );
  }
}



