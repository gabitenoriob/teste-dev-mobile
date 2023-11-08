import 'package:flutter/material.dart';


class ParceirosPage extends StatelessWidget {
  const ParceirosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parceiros do Evento'),
      ),
      body: Center(
        child: Text('Esta é a página dos parceiros do evento.'),
      ),
    );
  }
}