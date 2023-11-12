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
  Image? _image;

  @override
  void initState() {
    super.initState();
    loadImage();
  }

//gerando imagem da home
  Future<void> loadImage() async {
    final response = await http.get(Uri.parse(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT9uBCZIGEtt5x_8lqHg_n8ZQO8rGn4HgrfaWx3za623-BCV6YYSxQjU_1U_iE5nukGlLc&usqp=CAU'));
    if (response.statusCode == 200) {
      final imageBytes = response.bodyBytes;
      final image = Image.memory(Uint8List.fromList(imageBytes));
      setState(() {
        _image = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Congresso Direito em Alagoas'),
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              // menu..
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
                    child: Text('Programação'),
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
                    child: Text('Palestrantes'),
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
                    child: Text('Parceiros'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.phone),
              onPressed: () {
                // Iredes sociais do conteudo
              },
            ),
            IconButton(
              icon: Icon(Icons.email),
              onPressed: () {
                // conteudo
              },
            ),
            IconButton(
              icon: Icon(Icons.location_on),
              onPressed: () {
                // conteudo
              },
            ),
          ],
        ),
      ),
    );
  }
}
