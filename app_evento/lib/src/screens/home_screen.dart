import 'package:app_evento/src/http/http_client.dart';
import 'package:app_evento/src/services/programacao_api.dart';
import 'package:app_evento/src/stores/programacao_store.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProgramacaoStore store =
      ProgramacaoStore(programacao: Programacao(client: HttpClient()));

  @override
  void initState() {
    super.initState();
    //aq tb
    store.getHorarios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Evento APP",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: AnimatedBuilder(
        animation: Listenable.merge([
          store.erro,
          store.isloading,
          store.state,
        ]),
        builder: (context, child) {
          if (store.isloading.value) {
            return Center(child: const CircularProgressIndicator());
          }
          if (store.erro.value.isNotEmpty) {
            return Center(
              child: Text(
                store.erro.value,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }

          if (store.state.value.isEmpty) {
            return Center(
              child: Text(
                'Nenhum item na lista',
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
              itemCount: store.state.value.length,
              itemBuilder: (_, index) {
                final item = store.state.value[index];
                return Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    //FALTA POR MAIS DETALHES
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
      ),
    );
  }
}
