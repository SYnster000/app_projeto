// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';


class SobreView extends StatelessWidget {
  const SobreView
({super.key});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text('Sobre'),
        centerTitle: true,
        backgroundColor: Colors.grey.shade600,
      ),
        body: Center(
            child: Container(
              width: double.infinity,
              height: double.infinity,
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

              
              child: Padding(
                padding: EdgeInsets.all(50),
                child: Column(

              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
                children:[ 
                  Text("STOCK PLUS"),
                  Text("Aplicativo criado para o projeto da disciplina Programação para dispositivos Móveis"),
                  
                  Text("Um aplicativo para cadastro e listagem de estoque"),
                  Text("Nome: Vinícius Felipe Rocha                               "
                        "RA: 2840482323011"),
                ]
            ),
              ),
            ),
        ),
    );
  }
}