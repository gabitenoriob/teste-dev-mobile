import 'package:app_evento/src/http/http_client.dart';
import 'package:app_evento/src/apis/parceiros_api.dart';
import 'package:flutter/material.dart';
import 'package:app_evento/src/stores/parceiros_store.dart';

class ParceirosPage extends StatelessWidget {
  final ParceirosStore parceirosStore =
      ParceirosStore(parceiros: Parceiro(client: HttpClient()));

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        parceirosStore.erro,
        parceirosStore.isloading,
        parceirosStore.state,
      ]),
      builder: (context, child) {
        print('IsLoading: ${parceirosStore.isloading.value}');
        print('Erro: ${parceirosStore.erro.value}');
        print('State Length: ${parceirosStore.state.value?.length}');

        if (parceirosStore.isloading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (parceirosStore.erro.value.isNotEmpty) {
          return Center(
            child: Text(
              parceirosStore.erro.value,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          );
        }

        if (parceirosStore.state.value!.isEmpty) {
          return Center(
            child: Text(
              'Nenhum item na lista de parceiros',
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
            itemCount: parceirosStore.state.value!.length,
            itemBuilder: (_, index) {
              final item = parceirosStore.state.value?[index];

              if (item != null) {
                final imagem = item.imagem;
                final categoriaDescricao = item.categoria.descricao.toString();
                final url = item.url;

                return Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        imagem,
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
                            categoriaDescricao,
                            style: const TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            url,
                            style: const TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          )
                        ],
                      ),
                    )
                  ],
                );
              } else {
                // Lógica para lidar com um item nulo, se necessário.
                return SizedBox.shrink(); // ou outro widget vazio ou padrão
              }
            },
          );
        }
      },
    );
  }
}
