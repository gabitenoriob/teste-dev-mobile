class Parceiros {
  final int id;
  final int ordem;
  final String? descricao;
  final String url;
  final String imagem;
  Categoria categoria;

  Parceiros({
    required this.id,
    required this.ordem,
     this.descricao,
    required this.url,
    required this.imagem,
    required this.categoria,
  });

  factory Parceiros.fromJson(Map<String, dynamic> json) {
    return Parceiros(
      id: json['id'],
      ordem: json['ordem'],
      descricao: json['descricao'] ?? " " ,
      url: json['url'],
      imagem: json['imagem'],
      categoria: Categoria.fromMap(json['categoria']),
    );
  }
}

class Categoria {
  final int id;
  final int ordem;
  final String descricao;
  final bool mostrar_site;
  final bool mostrar_doity_play;

  Categoria({
    required this.id,
    required this.ordem,
     required this.descricao,
    required this.mostrar_doity_play,
    required this.mostrar_site,
  });

  factory Categoria.fromMap(Map<String, dynamic> map) {
    return Categoria(
      id: map['id'],
      ordem: map['ordem'],
      descricao: map['descricao'] ,
      mostrar_doity_play: map['mostrar_doity_play'],
      mostrar_site: map['mostrar_site_evento'],
    );
  }
}
