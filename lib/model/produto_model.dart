/*
  Classe utilizada para estruturar os
  dados que serão exibidos no ListView
*/
class Produto{
  final String nome;
  final double preco;
  final int quantidade;



  Produto({
    required this.nome,
    required this.preco,
    required this.quantidade
  });

Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'nome': nome,
      'preco': preco,
      'quantidade': quantidade
    };
  }

 factory Produto.fromJson(Map<String, dynamic> json) {
    return Produto(
      nome: json['nome'],
      preco: (json['preco'] as num).toDouble(),
      quantidade: json['quantidade'],
    );
  }


}
