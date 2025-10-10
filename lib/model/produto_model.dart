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
}
