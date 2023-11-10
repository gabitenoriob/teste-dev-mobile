class Parceiros {
  final int id;
  final int ordem;
  final String? descricao;
  final String url;
  final String imagem;
  final Categoria categoria;

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
      descricao: json['descricao'] ?? " ",
      url: json['url'],
      imagem: json['imagem'],
      categoria: Categoria.fromJson(json['categoria']),
    );
  }
}

class Categoria {
  final int id;
  final int ordem;
  final String? descricao;
  final bool mostrarSite;
  final bool mostrarDoityPlay;

  Categoria({
    required this.id,
    required this.ordem,
    this.descricao,
    required this.mostrarDoityPlay,
    required this.mostrarSite,
  });

  factory Categoria.fromJson(Map<String, dynamic> json) {
    return Categoria(
      id: json['id'],
      ordem: json['ordem'],
      descricao: json['descricao'] ?? " ",
      mostrarDoityPlay: json['mostrar_doity_play'],
      mostrarSite: json['mostrar_site_evento'],
    );
  }
}
