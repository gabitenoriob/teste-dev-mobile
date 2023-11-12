import 'package:app_evento/src/apis/palestrantes_api.dart';
import 'package:app_evento/src/http/exceptions.dart';
import 'package:app_evento/src/models/palestrantes_model.dart';
import 'package:flutter/material.dart';

class PalestrantesStore {
  final IPalestrantes palestrantes;

  // loading
  final ValueNotifier<bool> isloading = ValueNotifier<bool>(false);

  // state
  final ValueNotifier<List<Palestrantes>> state =
      ValueNotifier<List<Palestrantes>>([]);

  // erro
  final ValueNotifier<String> erro = ValueNotifier<String>('');

  PalestrantesStore({required this.palestrantes});

  // Método para atualizar o estado
  void updateState(List<Palestrantes> newState) {
    state.value = newState;
  }

  // Método para limpar o estado de erro
  void clearError() {
    erro.value = '';
  }

  Future<void> getPalestrantes() async {
    isloading.value = true;
    try {
      final result = await palestrantes.getPalestrantes();
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
