import 'package:app_evento/src/http/http_client.dart';
import 'package:app_evento/src/apis/programacao_api.dart';
import 'package:flutter/material.dart';
import 'package:app_evento/src/stores/programacao_store.dart';

class ProgramacaoPage extends StatefulWidget {
  @override
  _ProgramacaoPageState createState() => _ProgramacaoPageState();
}

class _ProgramacaoPageState extends State<ProgramacaoPage> {
  // Criando uma instância do ProgramacaoStore para gerenciar os dados da programação
  final ProgramacaoStore programacaoStore =
      ProgramacaoStore(programacao: Programacao(client: HttpClient()));

  @override
  void initState() {
    super.initState();
    // Ao iniciar a tela, carrega os horários da programação
    programacaoStore.getHorarios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        // Atualiza a interface com base nas mudanças no estado do ProgramacaoStore
        animation: Listenable.merge([
          programacaoStore.erro,
          programacaoStore.isloading,
          programacaoStore.state,
        ]),
        builder: (context, child) {
          if (programacaoStore.isloading.value) {
            // Exibe um indicador de carregamento enquanto os dados estão sendo buscados
            return const Center(child: CircularProgressIndicator());
          }
          if (programacaoStore.erro.value.isNotEmpty) {
            // Exibe uma mensagem de erro se ocorrer um erro no carregamento
            return Center(
              child: Text(
                programacaoStore.erro.value,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }
          if (programacaoStore.state.value.isEmpty) {
            // Exibe uma mensagem se a lista de programação estiver vazia
            return Center(
              child: Text(
                'Nenhum item na lista de programação',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            );
          } else {
            // Cria uma lista de horários da programação
            return ListView.builder(
              itemCount: programacaoStore.state.value!.length,
              itemBuilder: (context, index) {
                final item = programacaoStore.state.value![index];
                final nomeAtividade = item.atividade.nome;
                final horaAtividade = item.horaInicio;
                final localAtividade = item.atividade.local.toString();

                return Card(
                  margin: const EdgeInsets.all(16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nomeAtividade,
                          style: const TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Data: $horaAtividade',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),

                        const SizedBox(height: 8),
                        Text(
                          'Local: $localAtividade',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
