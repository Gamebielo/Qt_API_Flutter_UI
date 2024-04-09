// ignore_for_file: avoid_print, library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String _apiUrl =
      'http://localhost:8082'; // Certifique-se de que o IP e a porta estão corretos
  String _data = '';

  void _helloRoute() async {
    try {
      String url = '$_apiUrl/hello';
      final response = await http.get(Uri.parse(url));
      print(response.statusCode);
      if (response.statusCode == 200) {
        setState(() {
          _data = response.body;
          //_data = json.decode(response.body); // Modifique de acordo com a estrutura dos seus dados
        });
      } else {
        throw Exception('Falha ao carregar os dados');
      }
    } catch (e) {
      print('Erro: $e');
    }
  }

  void _byeRoute() async {
    try {
      String url = '$_apiUrl/bye';
      final response = await http.get(Uri.parse(url));
      print(response.statusCode);
      if (response.statusCode == 200) {
        setState(() {
          _data = response.body;
          //_data = json.decode(response.body); // Modifique de acordo com a estrutura dos seus dados
        });
      } else {
        throw Exception('Falha ao carregar os dados');
      }
    } catch (e) {
      print('Erro: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter com API REST em Qt C++'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Dados da API:',
            ),
            const SizedBox(height: 20),
            Text(
              _data,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: _helloRoute,
                  child: const Text('Hello'),
                ),
                const SizedBox(width: 20),
                OutlinedButton(
                  onPressed: _byeRoute,
                  child: const Text('Bye'),
                ),
              ],
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _helloRoute,
      //   tooltip: 'Atualizar',
      //   child: const Icon(Icons.refresh),
      // ),
    );
  }
}
