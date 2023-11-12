import 'package:app_evento/src/apis/conteudos_api.dart';
import 'package:app_evento/src/http/http_client.dart';
import 'package:app_evento/src/stores/conteudos_store.dart';
import 'package:flutter/material.dart';

class ConteudosPage extends StatefulWidget {
  @override
  _ConteudosPageState createState() => _ConteudosPageState();
}

class _ConteudosPageState extends State<ConteudosPage> {
  final ConteudosStore conteudosStore =
      ConteudosStore(conteudos: Conteudos(client: HttpClient()));

  @override
  void initState() {
    super.initState();
    conteudosStore.getConteudos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: Listenable.merge([
          conteudosStore.erro,
          conteudosStore.isloading,
          conteudosStore.state,
        ]),
        builder: (context, child) {
          if (conteudosStore.isloading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (conteudosStore.erro.value.isNotEmpty) {
            return Center(
              child: Text(
                conteudosStore.erro.value,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }

          if (conteudosStore.state.value.isEmpty) {
            return Center(
              child: Text(
                'Nenhum item na lista de conteudos',
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
              itemCount: conteudosStore.state.value.length,
              itemBuilder: (_, index) {
                final item = conteudosStore.state.value[index];

                if (item != null) {
                  final imagemURL ;
                  final descricao ;
                  final empresa ;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Text(
                        'oi',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'descricao',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                       ' empresa',
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
      ),
    );
  }
}
