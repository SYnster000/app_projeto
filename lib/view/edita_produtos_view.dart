import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../controller/produto_controller.dart';

class EditaProdutosView extends StatefulWidget {
  const EditaProdutosView({super.key});

  @override
  State<EditaProdutosView> createState() => _EditaProdutosViewState();
}

class _EditaProdutosViewState extends State<EditaProdutosView> {
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
          'Editar Produtos',
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
      // height: 300,
      child: ListView.builder(
        // scrollDirection: Axis.horizontal,
        itemCount: ctrl.produtos.length,
        itemBuilder: (context, index) {
          final item = ctrl.produtos[index];

          return SizedBox(
            //     width: 150,
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
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          ctrl.txtNome.text = ctrl.produtos[index].nome;
                          ctrl.txtQuantidade.text = ctrl.produtos[index].quantidade
                              .toString();
                          ctrl.txtPreco.text = ctrl.produtos[index].preco
                              .toString();

                          caixaDialogo(index);
                        },
                        icon: Icon(
                          Icons.edit,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          ctrl.removerItem(index);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Item removido com sucesso!',
                              ),
                            ),
                          );
                        },
                        icon: Icon(Icons.delete_outline),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    ),
/*
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
*/
      ),
    );
  }
  caixaDialogo(index) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.all(20),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Alterar item',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  //
                  // NOME
                  //
                  SizedBox(height: 20),
                  TextField(
                    controller: ctrl.txtNome,
                    decoration: InputDecoration(
                      labelText: 'Nome',
                      labelStyle: TextStyle(
                        color: Colors.grey[600],
                      ),
                      filled: true,
                      fillColor: Colors.grey[50],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  //
                  // QUANTIDADE
                  //
                  TextField(
                    controller: ctrl.txtQuantidade,
                    decoration: InputDecoration(
                      labelText: 'Quantidade',
                      labelStyle: TextStyle(
                        color: Colors.grey[600],
                      ),
                      filled: true,
                      fillColor: Colors.grey[50],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  //
                  // PREÇO
                  //
                  TextField(
                    controller: ctrl.txtPreco,
                    decoration: InputDecoration(
                      labelText: 'Preço',
                      labelStyle: TextStyle(
                        color: Colors.grey[600],
                      ),
                      filled: true,
                      fillColor: Colors.grey[50],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2,
                        ),
                      ),
                      prefixText: 'R\$ ',
                      prefixStyle: TextStyle(
                        color: Colors.grey[700],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  //
                  // BOTÕES
                  //
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          ctrl.txtNome.clear();
                          ctrl.txtPreco.clear();
                          Navigator.of(context).pop();
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.grey[700],
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                        ),
                        child: Text('cancelar'),
                      ),
                      SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: () {
                          //
                          // ADICIONAR um novo ITEM na LISTA
                          //
                          if (ctrl.txtNome.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Informe o nome do produto.',
                                ),
                              ),
                            );
                          } else {
                            String msg = '';

                              ctrl.alterarItem(index);
                              msg = 'Item alterado com sucesso!';


                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(msg)),
                            );

                            Navigator.of(context).pop();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.grey,
                          padding: EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                        child: Text('salvar'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

}