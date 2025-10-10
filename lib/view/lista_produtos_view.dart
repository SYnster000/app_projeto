import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../controller/produto_controller.dart';

class ListaProdutosView extends StatefulWidget {
  const ListaProdutosView({super.key});

  @override
  State<ListaProdutosView> createState() => _ListaProdutosViewState();
}

  class _ListaProdutosViewState extends State<ListaProdutosView> {
  final ctrl = GetIt.I.get<ProdutoController>();

 @override
  void initState() {
    super.initState();
    ctrl.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Produtos',
          style: TextStyle(fontSize: 24, color: Colors.white),
          
        ),
        centerTitle: true,
        backgroundColor: Colors.grey.shade600,

      ),
      //
      // BODY
      //
      body: Padding(
        padding: EdgeInsets.all(30),
        child:

        SizedBox(
      child: ListView.builder(
        itemCount: ctrl.produtos.length,
        itemBuilder: (context, index) {
          final item = ctrl.produtos[index];

          return SizedBox(
            child: Card(
              child: ListTile(
                title: Text(
                  '${item.nome} x${item.quantidade}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'R\$ ${item.preco.toStringAsFixed(2)}',
                ),
                trailing: SizedBox(
                  width: 80,
                                  ),
              ),
            ),
          );
        },
      ),
    )
      ),
    );
  }
}