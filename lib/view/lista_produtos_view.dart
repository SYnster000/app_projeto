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

  final TextEditingController searchCtrl = TextEditingController();

  // Ordenação escolhida pelo usuário
  String orderBy = 'nome'; // valor padrão

  Stream<QuerySnapshot> streamProdutos = const Stream.empty();

  @override
  void initState() {
    super.initState();
    ctrl.addListener(() => setState(() {}));

    streamProdutos = buscarProdutos('', orderBy);

    searchCtrl.addListener(() {
      setState(() {
        streamProdutos = buscarProdutos(searchCtrl.text.trim(), orderBy);
      });
    });
  }

  @override
  void dispose() {
    searchCtrl.removeListener(() {});
    searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Produtos', style: TextStyle(fontSize: 24, color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.grey.shade600,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [

            // 🔍 Campo de pesquisa
            TextField(
              controller: searchCtrl,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                labelText: 'Pesquisar produto',
                labelStyle: TextStyle(
                  color: Colors.black, // cor do label
                ),
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 20),

            // 🔽 Dropdown para ordenação
            Row(
              children: [
                Text("Ordenar por: ", style: TextStyle(fontSize: 16)),
                SizedBox(width: 20),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: orderBy,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'nome', child: Text("Nome (A-Z)")),
                      DropdownMenuItem(value: 'preco', child: Text("Valor (Preço)")),
                      DropdownMenuItem(value: 'quantidade', child: Text("Quantidade")),
                    ],
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() {
                        orderBy = value;
                        streamProdutos = buscarProdutos(searchCtrl.text.trim(), orderBy);
                      });
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),

            // LISTA
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: streamProdutos,
                builder: (context, snapshot) {
                  
                  if (snapshot.hasError) {
                    return Text('Erro ao carregar: ${snapshot.error}');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  // Documentos recuperados
                  final docsOrig = snapshot.data!.docs;

                  // 🔍 Case-insensitive local filter
                  final filtro = searchCtrl.text.trim().toLowerCase();

                  final docs = docsOrig.where((doc) {
                    final data = doc.data() as Map<String, dynamic>? ?? {};
                    final nome = data['nome']?.toString().toLowerCase() ?? '';
                    return nome.contains(filtro);
                  }).toList();

                  // 🔽 Ordenação adicional local se necessário
                  if (filtro.isNotEmpty && orderBy != 'nome') {
                    docs.sort((a, b) {
                      final da = a.data() as Map<String, dynamic>? ?? {};
                      final db = b.data() as Map<String, dynamic>? ?? {};

                      final va = da[orderBy];
                      final vb = db[orderBy];

                      if (va is num && vb is num) {
                        return va.compareTo(vb);
                      }

                      return (va?.toString() ?? '').compareTo(vb?.toString() ?? '');
                    });
                  }

                  if (docs.isEmpty) {
                    return Center(
                      child: Text(
                        'Nenhum produto encontrado',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final data = docs[index].data() as Map<String, dynamic>?;

                      if (data == null) return SizedBox();

                      final nome = data['nome']?.toString() ?? '';
                      final preco = (data['preco'] is num) ? (data['preco'] as num).toDouble() : 0.0;
                      final quantidade = (data['quantidade'] is num) ? data['quantidade'] : 0;

                      return Card(
                        child: ListTile(
                          title: Text('$nome x$quantidade', style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text('R\$ ${preco.toStringAsFixed(2)}'),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔎 BUSCA + ORDENACAO
  Stream<QuerySnapshot> buscarProdutos(String filtro, String orderField) {
    if (filtro.isEmpty) {
      return dados.orderBy(orderField).snapshots();
    }

    // 🔥 Carrega tudo ordenado por nome (não filtra aqui)
    return dados.orderBy('nome').snapshots();
  }
}
