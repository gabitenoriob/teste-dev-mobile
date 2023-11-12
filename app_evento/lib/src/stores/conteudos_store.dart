import 'package:app_evento/src/apis/conteudos_api.dart';
import 'package:app_evento/src/http/exceptions.dart';
import 'package:app_evento/src/models/conteudos_model.dart';
import 'package:flutter/material.dart';

class ConteudosStore {
  final IConteudos conteudos;

  // loading
  final ValueNotifier<bool> isloading = ValueNotifier<bool>(false);

  // state
  final ValueNotifier<List<Conteudo>> state =
      ValueNotifier<List<Conteudo>>([]);

  // erro
  final ValueNotifier<String> erro = ValueNotifier<String>('');

  ConteudosStore({required this.conteudos});

  // Método para atualizar o estado
  void updateState(List<Conteudo> newState) {
    state.value = newState;
  }

  // Método para limpar o estado de erro
  void clearError() {
    erro.value = '';
  }

  Future<void> getConteudos() async {
    isloading.value = true;
    try {
      final result = await conteudos.getConteudos();
      updateState(result);
      clearError();
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    } finally {
      isloading.value = false;
    }
  }
}
