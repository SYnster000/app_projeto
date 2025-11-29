// ignore_for_file: prefer_const_constructors

import 'package:app_projeto/view/components/mensagem.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class EsquecesenhaView extends StatefulWidget {
  const EsquecesenhaView({super.key});

  @override
  State<EsquecesenhaView> createState() => _EsquecesenhaViewState();
}

class _EsquecesenhaViewState extends State<EsquecesenhaView> {

  var txtEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Esqueci Minha Senha'),
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


                

                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          //backgroundColor: Colors.white70,
                          //foregroundColor: Colors.white,
                          minimumSize: Size(140, 40)
                        ),
                       onPressed: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Recuperação de Cadastro'),
                            content: const Text('Enviar e-mail de recuperação de cadastro?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'Não'),
                                child: const Text('Não'),
                              ),
                              TextButton(
                                onPressed: () {
                                  esqueceuSenha(context, txtEmail.text);
                                  Navigator.pop(context, 'Sim');
                                },
                                child: const Text('Sim'),
                              ),
                            ],
                          ),
                        ),
                    

                          //Navigator.pushNamed(context, 'menu');
                         
                        child: Text('Confirmar'),
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

/*
esqueceuSenha(context, String email) async {
  if (email.isEmpty) {
    if (!mounted) return;
    erro(context, 'Informe o e-mail para recuperar a senha.');
    return;
  }

  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

    if (!mounted) return;
    sucesso(context, 'E-mail enviado com sucesso.');

  } on FirebaseAuthException catch (e) {
    if (!mounted) return;

    // Mapeia mensagens amigáveis
    switch (e.code) {
      case 'invalid-email':
        erro(context, 'E-mail inválido.');
        break;

      case 'user-not-found':
        erro(context, 'Nenhum usuário encontrado com este e-mail.');
        break;

      default:
        erro(context, 'Erro: ${e.message}');
        break;
    }

  } catch (e) {
    if (!mounted) return;
    erro(context, 'Erro inesperado: $e');
  }
}
*/

esqueceuSenha(context, String email) {
  if (email.isNotEmpty) {
    FirebaseAuth.instance
    .sendPasswordResetEmail(email: email)
    .then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('E-mail de recuperação enviado!')),
      );
    })
    .catchError((error) {
      if (error is FirebaseAuthException) {
        String msg = 'Erro ao enviar e-mail';

        switch (error.code) {
          case 'user-not-found':
            msg = 'Nenhuma conta encontrada com esse e-mail.';
            break;
          case 'invalid-email':
            msg = 'E-mail inválido.';
            break;
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(msg)),
        );
      }
    });
    sucesso(context, 'E-mail enviado com sucesso.');
  } else {
    erro(context, 'Informe o e-mail para recuperar a senha.');
  }

  //Navigator.pop(context);
}




}