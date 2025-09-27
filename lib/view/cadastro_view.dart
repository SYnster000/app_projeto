// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';


class CadastroView extends StatefulWidget {
  const CadastroView({super.key});

  @override
  State<CadastroView> createState() => _CadastroViewState();
}

class _CadastroViewState extends State<CadastroView> {

  var txtNome = TextEditingController();
  var txtEmail = TextEditingController();
  var txtSenha = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
        centerTitle: true,
        backgroundColor: Colors.grey.shade600,
      ),
        body: Center(
            child: Container(
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                   children: [
                  
                  
                  TextField(
                    controller: txtNome,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Nome',
                      hintText: 'Digite seu nome',
                      //hintStyle: TextStyle(color: Colors.white),

                    ),
                    ),

                    SizedBox(
                      height: 20,
                    ),


                   TextField(
                    controller: txtEmail,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      labelText: 'E-mail',
                      hintText: 'Digite seu e-mail',
                      //hintStyle: TextStyle(color: Colors.white),

                    ),
                    ),

                    SizedBox(
                      height: 20,
                    ),


                    TextField(
                    controller: txtSenha,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      hintText: 'Digite sua senha',
                      border: OutlineInputBorder(),
                    ),
                    ),

                    SizedBox(
                            height: 20,
                          ),

                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          //backgroundColor: Colors.white70,
                          //foregroundColor: Colors.white,
                          minimumSize: Size(140, 40)
                        ),
                       onPressed: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Cadastro'),
                            content: const Text('Deseja Confirmar o Cadastro?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'Não'),
                                child: const Text('Não'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'Sim'),
                                child: const Text('Sim'),
                              ),
                            ],
                          ),
                        ),
                    

                          //Navigator.pushNamed(context, 'menu');
                         
                        child: Text('Cadastrar'),
                        ),

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