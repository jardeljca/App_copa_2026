import 'package:flutter/material.dart';
import '../services/api_service.dart';

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

    try {
      final data = await ApiService.fetchStandings();
      _standings = data;
    } catch (e) {
      // falha silenciosa — manter estado anterior
    }

    _isLoading = false;
    notifyListeners();
  }
}
