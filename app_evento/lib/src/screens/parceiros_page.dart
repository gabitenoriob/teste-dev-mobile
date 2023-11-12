import 'package:app_evento/src/http/http_client.dart';
import 'package:app_evento/src/apis/parceiros_api.dart';
import 'package:flutter/material.dart';
import 'package:app_evento/src/stores/parceiros_store.dart';

class ParceirosPage extends StatefulWidget {
  @override
  _ParceirosPageState createState() => _ParceirosPageState();
}

class _ParceirosPageState extends State<ParceirosPage> {
  final ParceirosStore parceirosStore =
      ParceirosStore(parceiros: Parceiro(client: HttpClient()));

  @override
  void initState() {
    super.initState();
    parceirosStore.getParceiros();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: Listenable.merge([
          parceirosStore.erro,
          parceirosStore.isloading,
          parceirosStore.state,
        ]),
        builder: (context, child) {
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

          if (parceirosStore.state.value.isEmpty) {
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
                  final categoriaDescricao = item.categoria.descricao;
                  final url = item.url;

                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white, 
                      borderRadius:
                          BorderRadius.circular(16), 
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: Offset(0, 2), 
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16), 
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Center(
                            child: Image.network(
                              imagem,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          categoriaDescricao,
                          style: const TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          url,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            );
          }
        },
      ),
    );
  }
}
