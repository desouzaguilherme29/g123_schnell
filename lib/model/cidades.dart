class Cidade {
  final String nome;

  Cidade(this.nome);

  factory Cidade.fromJson(dynamic json) {
    return Cidade(json['nome'] as String);
  }

  Map<String, dynamic> toJson() => {
        'nome': nome,
      };

  @override
  String toString() {
    return '${this.nome}';
  }
}
