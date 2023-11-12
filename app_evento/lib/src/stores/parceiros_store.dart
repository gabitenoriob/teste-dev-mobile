import 'package:app_evento/src/apis/parceiros_api.dart';
import 'package:app_evento/src/http/exceptions.dart';
import 'package:app_evento/src/models/paceiros_model.dart';
import 'package:flutter/material.dart';

class ParceirosStore {
  final IParceiros parceiros;

  // loading
  final ValueNotifier<bool> isloading = ValueNotifier<bool>(false);

  // state
  final ValueNotifier<List<Parceiros>> state =
      ValueNotifier<List<Parceiros>>([]);

  // erro
  final ValueNotifier<String> erro = ValueNotifier<String>('');

  ParceirosStore({required this.parceiros});

  // Método para atualizar o estado
  void updateState(List<Parceiros> newState) {
    state.value = newState;
  }

  // Método para limpar o estado de erro
  void clearError() {
    erro.value = '';
  }

  Future<void> getParceiros() async {
    isloading.value = true;
    try {
      final result = await parceiros.getParceiros();
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
