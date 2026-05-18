import 'package:flutter/material.dart';

class MatchProvider with ChangeNotifier {
  // Lógica de consumo de API de futebol
  // Integração com API-Football ou similar
  
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Cache offline e atualização em tempo real
}
