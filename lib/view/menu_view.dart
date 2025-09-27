// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';


class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
        centerTitle: true,
        backgroundColor: Colors.grey.shade600,
      ),
        body: Center(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.yellow.shade400,
                    Colors.teal.shade800,
                  ],
                )
              ),

            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                              },
                            ),
                            Text('Cadastrar Produto'),

                          IconButton(
                              icon: const Icon(Icons.list),
                              iconSize: 100,

                              //tooltip: 'teste',
                              onPressed: () {
                              },
                            ),
                            Text('Listar Produtos em Estoque'),

                          IconButton(
                              icon: const Icon(Icons.edit_document),
                              iconSize: 100,

                              //tooltip: 'teste',
                              onPressed: () {
                              },
                            ),
                            Text('Editar Estoque'),

                    
                  

                    

              ],
            ),
              
            ),
              ],
            
  
            ),







            ),
        ),
    );
  }
}