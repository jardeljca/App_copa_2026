import 'package:flutter/material.dart';

class StandingProvider with ChangeNotifier {
  // Estado e dados de classificação (standings)
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Estrutura exemplo para armazenar standings
  List<Map<String, dynamic>> _standings = [];
  List<Map<String, dynamic>> get standings => _standings;

  Future<void> loadStandings() async {
    _isLoading = true;
    notifyListeners();

    // TODO: implementar chamada à API e mapeamento para modelos
    await Future.delayed(const Duration(milliseconds: 200));

    _isLoading = false;
    notifyListeners();
  }
}
