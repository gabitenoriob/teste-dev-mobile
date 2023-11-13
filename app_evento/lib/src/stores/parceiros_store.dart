import 'package:app_evento/src/apis/parceiros_api.dart';
import 'package:app_evento/src/http/exceptions.dart';
import 'package:app_evento/src/models/paceiros_model.dart';
import 'package:flutter/material.dart';

class ParceirosStore {
  final IParceiros parceiros;

  // Variável para indicar se os dados estão sendo carregados
  final ValueNotifier<bool> isloading = ValueNotifier<bool>(false);

  // Variável para armazenar o estado da lista de parceiros
  final ValueNotifier<List<Parceiros>> state =
      ValueNotifier<List<Parceiros>>([]);

  // Variável para armazenar mensagens de erro
  final ValueNotifier<String> erro = ValueNotifier<String>('');

  ParceirosStore({required this.parceiros});

  // Método para atualizar o estado da lista de parceiros
  void updateState(List<Parceiros> newState) {
    state.value = newState;
  }

  // Método para limpar o estado de erro
  void clearError() {
    erro.value = '';
  }

  // Método para buscar os parceiros
  Future<void> getParceiros() async {
    // Define que os dados estão sendo carregados
    isloading.value = true;
    try {
      // Tenta obter a lista de parceiros por meio da API parceiros
      final result = await parceiros.getParceiros();
      // Atualiza o estado com os novos parceiros obtidos
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
