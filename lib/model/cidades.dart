class Cidade {
  final String codigo;
  final String nome;

  Cidade(this.codigo, this.nome);

  Cidade.fromJson(Map<String, dynamic> json)
      : codigo = json['codigo'],
        nome = json['nome'];

  Map<String, dynamic> toJson() => {
        'codigo': codigo,
        'email': nome,
      };
}
