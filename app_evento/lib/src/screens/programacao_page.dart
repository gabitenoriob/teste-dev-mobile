import 'package:app_evento/src/http/http_client.dart';
import 'package:app_evento/src/apis/programacao_api.dart';
import 'package:flutter/material.dart';
import 'package:app_evento/src/stores/programacao_store.dart';

class ProgramacaoPage extends StatefulWidget {
  @override
  _ProgramacaoPageState createState() => _ProgramacaoPageState();
}

class _ProgramacaoPageState extends State<ProgramacaoPage> {
  final ProgramacaoStore programacaoStore =
      ProgramacaoStore(programacao: Programacao(client: HttpClient()));

  @override
  void initState() {
    super.initState();
    programacaoStore.getHorarios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnimatedBuilder(
      animation: Listenable.merge([
        programacaoStore.erro,
        programacaoStore.isloading,
        programacaoStore.state,
      ]),
      builder: (context, child) {
        if (programacaoStore.isloading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (programacaoStore.erro.value.isNotEmpty) {
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
          return ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(
              height: 32,
            ),
            padding: const EdgeInsets.all(16),
            itemCount: programacaoStore.state.value!.length,
            itemBuilder: (_, index) {
              final item = programacaoStore.state.value?[index];

              if (item != null) {
                final atividade = item.atividade.toString();
                final nomeAtividade = item.atividade.nome.toString();
                final descricaoAtividade = item.atividade.descricao;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   const SizedBox(height: 8),
                    Text(
                      atividade,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      nomeAtividade,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      descricaoAtividade,
                      style: const TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ],
                );
              } else {
                return SizedBox.shrink();
              }
            },
          );
        }
      },
    ));
  }
}
