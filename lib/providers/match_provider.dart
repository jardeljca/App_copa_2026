import 'package:flutter/material.dart';
import '../models/match_model.dart';
import '../services/api_service.dart';

class MatchProvider with ChangeNotifier {
  // Lógica de consumo de API de futebol
  // Integração com API-Football ou similar
  
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<MatchModel> _upcoming = [];
  List<MatchModel> get upcoming => _upcoming;

  Future<void> loadUpcoming({int limit = 8}) async {
    _isLoading = true;
    notifyListeners();
    try {
      final items = await ApiService.fetchUpcomingMatches(limit: limit);
      _upcoming = items;
    } catch (e) {
      // manter cache antigo em caso de erro
    }
    _isLoading = false;
    notifyListeners();
  }

  // Cache offline e atualização em tempo real
}
