import 'package:flutter/material.dart';

import '../model/produto_model.dart';

class ProdutoController extends ChangeNotifier {
  final List<Produto> _produtos = [
    Produto(nome: 'Chaveiro', preco: 25.00),
    Produto(nome: 'Copo', preco: 15.00),
    Produto(nome: 'Adereços', preco: 3.25),
  ];

  List<Produto> get produtos => _produtos;

  bool _visualizarLista = true;
  bool get visualizarLista => _visualizarLista;

  bool alterar = false;

  final txtNome = TextEditingController();
  final txtPreco = TextEditingController();

  void alterarVisualizacao(valor) {
    _visualizarLista = valor;
    notifyListeners();
  }

  void adicionarItem() {
    String nome = txtNome.text;
    double preco = double.tryParse(txtPreco.text) ?? 0.0;

    _produtos.add(Produto(nome: nome, preco: preco));

    txtNome.clear();
    txtPreco.clear();

    notifyListeners();
  }

  void alterarItem(index){
    String nome = txtNome.text;
    double preco = double.tryParse(txtPreco.text) ?? 0.0;

    _produtos[index] = Produto(nome: nome, preco: preco);

    txtNome.clear();
    txtPreco.clear();

    notifyListeners();
  }


  void removerItem(index){
    _produtos.removeAt(index);
    notifyListeners();
  }

}
