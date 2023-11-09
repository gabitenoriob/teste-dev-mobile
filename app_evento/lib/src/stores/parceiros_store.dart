import 'package:app_evento/src/http/exceptions.dart';
import 'package:app_evento/src/models/paceiros_model.dart';
import 'package:app_evento/src/services/parceiros_api.dart';
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

  Future getParceiros() async {
    isloading.value = true;
    try {
      final result = await parceiros.getParceiros();
      state.value = result;
    } on NotFoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }
    isloading.value = false;
  }
}
