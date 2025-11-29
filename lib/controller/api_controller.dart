import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<void> importarProdutosFakeStore(BuildContext context) async {
  final url = Uri.parse('https://fakestoreapi.com/products');

  try {
    final response = await http.get(url);

    if (response.statusCode != 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Erro ao acessar API (${response.statusCode})"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final List<dynamic> lista = jsonDecode(response.body);

    final CollectionReference produtos =
        FirebaseFirestore.instance.collection('produtos');

    for (var item in lista) {
      final Map<String, dynamic> produto = {
        'nome': item['title'] ?? '',
        'preco': (item['price'] ?? 0).toDouble(),
        'quantidade': item['rating']?['count'] ?? 0,
        'imagem': item['image'] ?? '',
        'categoria': item['category'] ?? '',
        'descricao': item['description'] ?? '',
        'criadoEm': FieldValue.serverTimestamp(),
      };

      await produtos.add(produto);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Produtos importados com sucesso!"),
        backgroundColor: Colors.green,
      ),
    );

  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Erro ao importar produtos: $e"),
        backgroundColor: Colors.red,
      ),
    );
  }
}
