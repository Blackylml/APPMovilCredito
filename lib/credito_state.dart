import 'package:flutter/material.dart';

class CreditoState with ChangeNotifier {
  double _credit = 3000; // Crédito inicial

  double get credit => _credit;

  void updateCredit(double newCredit) {
    _credit = newCredit;
    notifyListeners();
  }
}
