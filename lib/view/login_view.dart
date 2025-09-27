// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';




class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {


  var txtEmail = TextEditingController();
  var txtSenha = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                //fonts.google.com/icons
                const Icon(
                  Icons.receipt_long,
                  size: 160,
                  color: Colors.white,
                ),
                const Text(
                  'STOCK PLUS',
                  style: TextStyle(
                    fontSize: 44,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Um aplicativo para cadastro e listagem de estoque',
                  style: TextStyle(
                    //fontSize: 44,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),),

                //Expandir até a largura limite do dispositivo

                const SizedBox(width: double.infinity, height: 40,
                ),


                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                   children: [
                  
                  
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




                  Row( 
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                  children: [

                    Container(
                    //alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'esquece_senha');
                      }, 
                      child: Text('Esqueceu sua senha?', style: TextStyle(color: Colors.indigo.shade900)
                                ),
                             ),
                    ),

                    Container(
                    //alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'sobre');
                      }, 
                      child: Text('Sobre', style: TextStyle(color: Colors.indigo.shade900))),
                    ),

                  ],


                  ),



                   ],
                  ),
                  ),
                

                 


                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    //backgroundColor: Colors.white70,
                    //foregroundColor: Colors.white,
                    minimumSize: Size(140, 40)
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, 'menu');
                    ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Seja Bem Vindo(a)!!!"),
                            duration: Duration(seconds: 3),
                          ),
                        );
                  }, 
                  child: Text('Entrar'),
                  ),

                SizedBox(
                      height: 20,
                    ),

                  Container(
                    //alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'cadastro');
                      }, 
                      child: Text('Novo Usuário? Cadastre-se', style: TextStyle(color: Colors.indigo.shade900)
                                ),
                             ),
                  ),

              ],


            ),

            ),
          ),
        );
  }
}