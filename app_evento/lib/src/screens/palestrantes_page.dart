import 'package:flutter/material.dart';


class PalestrantesPage extends StatelessWidget {
  const PalestrantesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Palestrantes do Evento'),
      ),
      body: Center(
        child: Text('Esta é a página de palestrantes do evento.'),
      ),
    );
  }
}