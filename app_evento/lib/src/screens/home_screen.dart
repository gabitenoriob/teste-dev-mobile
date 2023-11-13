import 'dart:typed_data';
import 'package:app_evento/src/screens/palestrantes_page.dart';
import 'package:app_evento/src/screens/parceiros_page.dart';
import 'package:app_evento/src/screens/programacao_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Image? _image; // Variável para armazenar a imagem carregada.

  @override
  void initState() {
    super.initState();
    loadImage(); // Carrega a imagem ao inicializar a tela.
  }

  // Função assíncrona para carregar a imagem da web.
  Future<void> loadImage() async {
    final response = await http.get(Uri.parse(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT9uBCZIGEtt5x_8lqHg_n8ZQO8rGn4HgrfaWx3za623-BCV6YYSxQjU_1U_iE5nukGlLc&usqp=CAU'));
    if (response.statusCode == 200) {
      final imageBytes = response.bodyBytes;
      final image = Image.memory(Uint8List.fromList(imageBytes));
      setState(() {
        _image = image; // Atualiza o estado com a imagem carregada.
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Congresso Direito em Alagoas'), // Título da AppBar.
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
            },
          ),
        ],
      ),
      body: Column(
        children: [
          GestureDetector(
            child: Container(
              width: double.infinity,
              height: 280,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT9uBCZIGEtt5x_8lqHg_n8ZQO8rGn4HgrfaWx3za623-BCV6YYSxQjU_1U_iE5nukGlLc&usqp=CAU',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.00),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      padding: EdgeInsets.all(30.0),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProgramacaoPage(),
                        ),
                      );
                    },
                    child: Text('Programação'), // Botão de Programação.
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      padding: EdgeInsets.all(30.0),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PalestrantesPage(),
                        ),
                      );
                    },
                    child: Text('Palestrantes'), // Botão de Palestrantes.
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      padding: EdgeInsets.all(30.0),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ParceirosPage(),
                        ),
                      );
                    },
                    child: Text('Parceiros'), // Botão de Parceiros.
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      //ConteudoApi:
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.phone),
              onPressed: () {
              },
            ),
            IconButton(
              icon: Icon(Icons.email),
              onPressed: () {
              },
            ),
            IconButton(
              icon: Icon(Icons.location_on),
              onPressed: () {
              },
            ),
          ],
        ),
      ),
    );
  }
}
