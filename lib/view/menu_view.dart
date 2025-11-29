// ignore_for_file: prefer_const_constructors

import 'package:app_projeto/controller/api_controller.dart';
import 'package:app_projeto/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../controller/produto_controller.dart';



class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {



  final ctrl = GetIt.I.get<ProdutoController>();
  final ctrlLogin = GetIt.I.get<LoginController>();

  final url = Uri.parse('https://fakestoreapi.com/products');


  @override
  void initState() {
    super.initState();
    ctrl.addListener(() => setState(() {}));
    ctrlLogin.addListener(() => setState(() {}));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(child: Text('Menu',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  )
                  ),
            FutureBuilder<String>(
              future: LoginController().usuarioLogado(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextButton.icon(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        textStyle: TextStyle(fontSize: 12),
                      ),
                      onPressed: () {
                        LoginController().logout(context);
                        Navigator.pushReplacementNamed(context, 'login');
                      },
                      icon: Icon(Icons.exit_to_app, size: 14),
                      label: Text(snapshot.data.toString()),
                    ),
                  );
                }
                return Text('');
              },
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.grey.shade600,
      ),

        body: Center(
            child: Container(
              width: double.infinity,

            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [


                          //fonts.google.com/icons
                          IconButton(
                              icon: const Icon(Icons.add),
                              iconSize: 100,

                              //tooltip: 'teste',
                              onPressed: () {
                                caixaDialogo(-1);
                              },
                            ),
                            Text('Cadastrar Produto'),

                          IconButton(
                              icon: const Icon(Icons.list),
                              iconSize: 100,

                              //tooltip: 'teste',
                              onPressed: () { 
                                Navigator.pushNamed(context, 'lista_produtos');
                              },
                            ),
                            Text('Listar Produtos em Estoque'),

                          IconButton(
                              icon: const Icon(Icons.edit_document),
                              iconSize: 100,

                              //tooltip: 'teste',
                              onPressed: () {
                                Navigator.pushNamed(context, 'edita_produtos');
                              },
                            ),
                            Text('Editar Estoque'),


                          IconButton(
                              icon: const Icon(Icons.api),
                              iconSize: 100,

                              //tooltip: 'teste',
                                onPressed: () async {
                                  await importarProdutosFakeStore(context);
                                },
                            ),
                            Text('Popular Estoque com API'),

                    
                  

                    

              ],
            ),
              
            ),
              ],
            
  
            ),







            ),
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
                    'Adicionar item',
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
                              ctrl.adicionarItem();
                              msg = 'Item adicionado com sucesso!';

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