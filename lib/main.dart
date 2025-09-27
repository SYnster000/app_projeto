import 'package:app_projeto/view/esquece_senha_view.dart';
import 'package:app_projeto/view/login_view.dart';
import 'package:app_projeto/view/sobre_view.dart';
import 'package:app_projeto/view/menu_view.dart';
import 'package:app_projeto/view/cadastro_view.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

void main() {
  //iniciar a execução do App
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => MaterialApp(
        
        theme: ThemeData(
    //primarySwatch: Colors.blue,
    inputDecorationTheme: const InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 3, color: Colors.white),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 3, color: Colors.white),
      ),
      labelStyle: TextStyle(color: Colors.white),
      hintStyle: TextStyle(color: Colors.white),
      

    ),
  ),





        useInheritedMediaQuery: true,
        debugShowCheckedModeBanner: false,

        initialRoute: 'login',
        routes: {
          'login': (context) => LoginView(), 
          'sobre':(context) => SobreView(),
          'menu':(context) => MenuView(),
          'cadastro':(context) => CadastroView(),
          'esquece_senha':(context) => EsquecesenhaView(),
        },
      ),
    ),

  );
}
