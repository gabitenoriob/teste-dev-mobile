import 'package:app_evento/src/services/programacao_api.dart';
import 'package:flutter/material.dart';

class ProgramacaoPage extends StatelessWidget {
  final ApiService apiService =
      ApiService(); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Programação do Evento'),
      ),
      body: FutureBuilder(
        future: apiService
            .fetchProgramacao(), // Use o método fetchProgramacao para buscar os dados
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(), // Indicador de carregamento
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Erro: ${snapshot.error}'), // ta dando erro aqui
            );
          } else {
            final programacao =
                snapshot.data as Programacao; // Obtenha os dados da API
            final horarios = programacao.horarios;

            return ListView.builder(
              itemCount: horarios.length,
              itemBuilder: (context, horarioIndex) {
                final horario = horarios[horarioIndex];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Data: ${horario.data_atividade}',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    for (var atividade in horario.atividades)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nome: ${atividade.nome}',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              'Descrição: ${atividade.descricao}',
                              style: TextStyle(fontSize: 14),
                            ),
                            Divider(),
                          ],
                        ),
                      ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
