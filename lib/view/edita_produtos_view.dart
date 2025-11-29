import 'package:cloud_firestore/cloud_firestore.dart';
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

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late final CollectionReference dados = firestore.collection('produtos');

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
      child: StreamBuilder<QuerySnapshot>(
  stream: FirebaseFirestore.instance.collection('produtos').snapshots(),
  builder: (context, snapshot) {
    if (snapshot.hasError) {
      return Text('Erro ao carregar dados: ${snapshot.error}');
    }

    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator());
    }

    final docs = snapshot.data!.docs;

    return ListView.builder(
      itemCount: docs.length,
      itemBuilder: (context, index) {
        final DocumentSnapshot doc = docs[index];
        final String id = doc.id;

        final data = doc.data() as Map<String, dynamic>;

        final nome = data['nome'] ?? '';
        final preco = (data['preco'] ?? 0).toDouble();
        final quantidade = data['quantidade'] ?? 0;

        return SizedBox(
          child: Card(
            child: ListTile(
              title: Text(
                '$nome x$quantidade',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'R\$ ${preco.toStringAsFixed(2)}',
              ),
              trailing: SizedBox(
                width: 80,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        // Preenche os campos para edição
                        ctrl.txtNome.text = nome;
                        ctrl.txtQuantidade.text = quantidade.toString();
                        ctrl.txtPreco.text = preco.toString();

                        // Agora você passa o ID, não o index
                        caixaDialogo(id);
                      },
                      icon: Icon(Icons.edit),
                    ),

                    IconButton(
                      onPressed: () async {
                        // Remove direto no Firebase
                        await FirebaseFirestore.instance
                            .collection('produtos')
                            .doc(id)
                            .delete();

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Item removido com sucesso!'),
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
  caixaDialogo(String id) {                          // ⭐ ALTERADO: agora recebe o ID do Firebase
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

                SizedBox(height: 20),
                //
                // NOME
                //
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
                      onPressed: () async {
                        if (ctrl.txtNome.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Informe o nome do produto.'),
                            ),
                          );
                        } else {
                          String msg = '';

                          // ⭐ ALTERADO: Atualizar no Firestore usando o ID
                          await FirebaseFirestore.instance
                              .collection('produtos')
                              .doc(id)
                              .update({
                            'nome': ctrl.txtNome.text,
                            'preco': double.tryParse(ctrl.txtPreco.text) ?? 0.0,
                            'quantidade':
                                int.tryParse(ctrl.txtQuantidade.text) ?? 0,
                          });

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


Stream<QuerySnapshot> buscarProdutos(String filtro) {
  if (filtro.isEmpty) {
    return dados.orderBy('nome').snapshots();
  }

  return dados
      .orderBy('nome')
      .startAt([filtro])
      .endAt(['$filtro\uf8ff'])
      .snapshots();
}



}