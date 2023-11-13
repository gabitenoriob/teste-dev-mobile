import 'package:app_evento/src/apis/programacao_api.dart';
import 'package:app_evento/src/http/exceptions.dart';
import 'package:app_evento/src/models/programacao_model.dart';
import 'package:flutter/material.dart';

class ProgramacaoStore {
  final IProgramacao programacao;

  // Variável para indicar se os dados estão sendo carregados
  final ValueNotifier<bool> isloading = ValueNotifier<bool>(false);

  // Variável para armazenar o estado da lista de horários
  final ValueNotifier<List<Horarios>> state = ValueNotifier<List<Horarios>>([]);

  // Variável para armazenar mensagens de erro
  final ValueNotifier<String> erro = ValueNotifier<String>('');

  ProgramacaoStore({required this.programacao});

  // Método para atualizar o estado da lista de horários
  void updateState(List<Horarios> newState) {
    state.value = newState;
  }

  // Método para limpar o estado de erro
  void clearError() {
    erro.value = '';
  }

  // Método para buscar os horários de atividades
  Future<void> getHorarios() async {
    // Define que os dados estão sendo carregados
    isloading.value = true;
    try {
      // Tenta obter os horários de atividades por meio da API programacao
      final result = await programacao.getHorarios();
      // Atualiza o estado com os novos horários obtidos
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
