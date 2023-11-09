import 'package:app_evento/src/http/exceptions.dart';
import 'package:app_evento/src/models/programacao_model.dart';
import 'package:app_evento/src/services/programacao_api.dart';
import 'package:flutter/material.dart';

class ProgramacaoStore {
  final IProgramacao programacao;

  // loading
  final ValueNotifier<bool> isloading = ValueNotifier<bool>(false);

  // state

  final ValueNotifier<List<Horarios>> state = ValueNotifier<List<Horarios>>([]);

  // erro

  final ValueNotifier<String> erro = ValueNotifier<String>('');

  ProgramacaoStore({required this.programacao});

  Future getHorarios() async {
    isloading.value = true;
    try {
      final result = await programacao.getProgramacao();
      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }
    isloading.value = false;
  }


}
