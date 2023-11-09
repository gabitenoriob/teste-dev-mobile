import 'package:app_evento/src/http/http_client.dart';
import 'package:app_evento/src/services/programacao_api.dart';
import 'package:flutter/material.dart';
import 'package:app_evento/src/stores/programacao_store.dart';

class ProgramacaoPage extends StatelessWidget {
  final ProgramacaoStore programacaoStore =
      ProgramacaoStore(programacao: Programacao(client: HttpClient()));

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
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
        // AS PAGINAS TAO VINDO P CA
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
            itemCount: programacaoStore.state.value.length,
            itemBuilder: (_, index) {
              final item = programacaoStore.state.value[index];
              return Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      item.atividade.nome,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.atividade.descricao,
                          style: const TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.dataAtividade,
                          style: const TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.w400,
                              fontSize: 18),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        )
                      ],
                    ),
                  )
                ],
              );
            },
          );
        }
      },
    );
  }
}
