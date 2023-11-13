import 'package:app_evento/src/apis/palestrantes_api.dart';
import 'package:app_evento/src/http/exceptions.dart';
import 'package:app_evento/src/models/palestrantes_model.dart';
import 'package:flutter/material.dart';

class PalestrantesStore {
  final IPalestrantes palestrantes;

  // Variável para indicar se os dados estão sendo carregados
  final ValueNotifier<bool> isloading = ValueNotifier<bool>(false);

  // Variável para armazenar o estado da lista de palestrantes
  final ValueNotifier<List<Palestrantes>> state = ValueNotifier<List<Palestrantes>>([]);

  // Variável para armazenar mensagens de erro
  final ValueNotifier<String> erro = ValueNotifier<String>('');

  PalestrantesStore({required this.palestrantes});

  // Método para atualizar o estado da lista de palestrantes
  void updateState(List<Palestrantes> newState) {
    state.value = newState;
  }

  // Método para limpar o estado de erro
  void clearError() {
    erro.value = '';
  }

  // Método para buscar os palestrantes
  Future<void> getPalestrantes() async {
    // Define que os dados estão sendo carregados
    isloading.value = true;
    try {
      // Tenta obter a lista de palestrantes por meio da API palestrantes
      final result = await palestrantes.getPalestrantes();
      // Atualiza o estado com os novos palestrantes obtidos
      updateState(result);
      // Limpa o estado de erro
      clearError();
    } on NotFoundException catch (e) {
      // Trata exceção personalizada NotFoundException, exibindo a mensagem de erro
      erro.value = e.message;
    } catch (e) {
      // Trata outras exceções, exibindo a mensagem de erro
      erro.value = e.toString();
    } finally {
      // Define que os dados não estão mais sendo carregados
      isloading.value = false;
    }
  }
}
