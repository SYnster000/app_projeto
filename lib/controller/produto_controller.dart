import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/produto_model.dart';

class ProdutoController extends ChangeNotifier {
  final List<Produto> _produtos = [
    Produto(nome: 'Chaveiro', preco: 25.00, quantidade: 5),
    Produto(nome: 'Copo', preco: 15.00, quantidade: 16),
    Produto(nome: 'Adereços', preco: 3.25, quantidade: 27),
  ];

  List<Produto> get produtos => _produtos;

  bool _visualizarLista = true;
  bool get visualizarLista => _visualizarLista;

  bool alterar = false;

  final txtNome = TextEditingController();
  final txtPreco = TextEditingController();
  final txtQuantidade = TextEditingController();

  void alterarVisualizacao(valor) {
    _visualizarLista = valor;
    notifyListeners();
  }

void adicionarItem() async {
  String nome = txtNome.text;
  double preco = double.tryParse(txtPreco.text) ?? 0.0;
  int quantidade = int.tryParse(txtQuantidade.text) ?? 0;

  // Cria o objeto
  Produto produto = Produto(
    nome: nome,
    preco: preco,
    quantidade: quantidade,
  );

  try {
    // Envia para o Firestore
    await FirebaseFirestore.instance.collection('produtos').add(
          produto.toJson(),
        );

    // Adiciona na lista local
    _produtos.add(produto);

    // Limpa inputs
    txtNome.clear();
    txtPreco.clear();
    txtQuantidade.clear();

    notifyListeners();
  } catch (e) {
    print('Erro ao adicionar item: $e');
  }
}

  void alterarItem(index){
    String nome = txtNome.text;
    double preco = double.tryParse(txtPreco.text) ?? 0.0;
    int quantidade = int.tryParse(txtQuantidade.text) ?? 0;

    _produtos[index] = Produto(nome: nome, preco: preco, quantidade: quantidade);

    txtNome.clear();
    txtPreco.clear();

    notifyListeners();
  }


  void removerItem(index){
    _produtos.removeAt(index);
    notifyListeners();
  }

}
