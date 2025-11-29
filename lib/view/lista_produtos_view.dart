import 'package:cloud_firestore/cloud_firestore.dart';
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
      child: StreamBuilder<QuerySnapshot>(
  stream: FirebaseFirestore.instance.collection('produtos').snapshots(),
  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    
    if (snapshot.hasError) {
      return Text('Erro ao carregar dados: ${snapshot.error}');
    }

    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator());
    }

    // Lista final de documentos
    final docs = snapshot.data!.docs;

    return ListView.builder(
      itemCount: docs.length,
      itemBuilder: (context, index) {
        final data = docs[index].data() as Map<String, dynamic>;

        final nome = data['nome'] ?? '';
        final preco = (data['preco'] as num).toDouble();
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
              ),
            ),
          ),
        );
      },
    );
  },
),
    )
      ),
    );
  }
}