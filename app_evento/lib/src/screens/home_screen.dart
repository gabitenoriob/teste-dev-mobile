import 'package:app_evento/src/screens/palestrantes_page.dart';
import 'package:app_evento/src/screens/parceiros_page.dart';
import 'package:app_evento/src/screens/programacao_page.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela Inicial do Evento'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PalestrantesPage()),
                );
              },
              child: const Text('Palestrantes do Evento'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProgramacaoPage()),
    );
  },
  child: const Text('Programação do Evento'),
),


            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ParceirosPage()),
                );
              },
              child: const Text('Parceiros do Evento'),
            ),
          ],
        ),
      ),
    );
  }

}
