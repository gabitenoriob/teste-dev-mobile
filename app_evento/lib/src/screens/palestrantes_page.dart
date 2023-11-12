import 'package:app_evento/src/apis/palestrantes_api.dart';
import 'package:app_evento/src/http/http_client.dart';
import 'package:app_evento/src/stores/palestrantes_store.dart';
import 'package:flutter/material.dart';

class PalestrantesPage extends StatefulWidget {
  @override
  _PalestrantesPageState createState() => _PalestrantesPageState();
}

class _PalestrantesPageState extends State<PalestrantesPage> {
  final PalestrantesStore palestrantesStore =
      PalestrantesStore(palestrantes: Palestrante(client: HttpClient()));

  @override
  void initState() {
    super.initState();
    palestrantesStore.getPalestrantes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: Listenable.merge([
          palestrantesStore.erro,
          palestrantesStore.isloading,
          palestrantesStore.state,
        ]),
        builder: (context, child) {
          if (palestrantesStore.isloading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (palestrantesStore.erro.value.isNotEmpty) {
            return Center(
              child: Text(
                palestrantesStore.erro.value,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }

          if (palestrantesStore.state.value.isEmpty) {
            return Center(
              child: Text(
                'Nenhum item na lista de palestrantes',
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
              itemCount: palestrantesStore.state.value!.length,
              itemBuilder: (_, index) {
                final item = palestrantesStore.state.value?[index];

                if (item != null) {
                  final imagemURL = item.imagem;
                  final nome = item.nome;
                  final empresa = item.empresa;
                  final atividades = item.atividade.nome;

                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white, // Cor de fundo da "caixa"
                      borderRadius:
                          BorderRadius.circular(16), // Borda arredondada
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: Offset(0, 2), // Sombra
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16), // Espaçamento interno
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Center(
                            child: Image.network(
                              imagemURL,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          nome,
                          style: const TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          empresa,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          atividades,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
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
