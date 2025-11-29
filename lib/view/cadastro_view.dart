// ignore_for_file: prefer_const_constructors

import 'package:app_projeto/view/components/mensagem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class CadastroView extends StatefulWidget {
  const CadastroView({super.key});

  @override
  State<CadastroView> createState() => _CadastroViewState();
}

class _CadastroViewState extends State<CadastroView> {

  var txtNome = TextEditingController();
  var txtSobrenome = TextEditingController();
  var txtCidade = TextEditingController();
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
                    controller: txtSobrenome,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Sobrenome',
                      hintText: 'Digite seu sobrenome',
                      //hintStyle: TextStyle(color: Colors.white),

                    ),
                    ),

                    SizedBox(
                      height: 20,
                    ),

                  TextField(
                    controller: txtCidade,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Cidade',
                      hintText: 'Digite sua cidade',
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
                                onPressed: () { 
                                  criarConta(context, txtNome.text, txtEmail.text, txtSenha.text);
                                },
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

criarConta(context, String nome, String email, String senha) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: senha)
        .then((res) {
      //Armazenar informações adicionais no Firestore
      FirebaseFirestore.instance.collection('usuarios').add({
        "uid": res.user!.uid.toString(),
        "nome": nome,
      });
      sucesso(context, 'Usuário criado com sucesso.');
      Navigator.pop(context);
    }).catchError((e) {
      switch (e.code) {
        case 'email-already-in-use':
          erro(context, 'O email já foi cadastrado.'); break;
        case 'invalid-email':
          erro(context, 'O email é inválido.'); break;
        default:
          erro(context, e.code.toString());
      }
    });
  }






}