class Produto {
  final int id;
  final String nome;
  final int quantidade;
  final double preco;
  final String? imagemUrl;

  Produto({
    required this.id,
    required this.nome,
    required this.quantidade,
    required this.preco,
    this.imagemUrl,
  });

  factory Produto.fromMap(Map<String, dynamic> map) {
    return Produto(
      id: map['id'],
      nome: map['nome'],
      quantidade: map['quantidade'],
      preco: double.tryParse(map['preco'].toString()) ?? 0.0,
      imagemUrl: map['imagem_url'],
    );
  }
}