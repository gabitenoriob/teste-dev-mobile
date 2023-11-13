import 'package:app_evento/src/apis/conteudos_api.dart';
import 'package:app_evento/src/http/exceptions.dart';
import 'package:app_evento/src/models/conteudos_model.dart';
import 'package:flutter/material.dart';

class ConteudosStore {
  final IConteudos conteudos;

  // Variável para indicar se os dados estão sendo carregados
  final ValueNotifier<bool> isloading = ValueNotifier<bool>(false);

  // Variável para armazenar o estado da lista de conteúdos
  final ValueNotifier<List<Conteudo>> state = ValueNotifier<List<Conteudo>>([]);

  // Variável para armazenar mensagens de erro
  final ValueNotifier<String> erro = ValueNotifier<String>('');

  ConteudosStore({required this.conteudos});

  // Método para atualizar o estado da lista de conteúdos
  void updateState(List<Conteudo> newState) {
    state.value = newState;
  }

  // Método para limpar o estado de erro
  void clearError() {
    erro.value = '';
  }

  // Método para buscar os conteúdos
  Future<void> getConteudos() async {
    // Define que os dados estão sendo carregados
    isloading.value = true;
    try {
      // Tenta obter a lista de conteúdos por meio da API de conteúdos
      final result = await conteudos.getConteudos();
      // Atualiza o estado com os novos conteúdos obtidos
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
