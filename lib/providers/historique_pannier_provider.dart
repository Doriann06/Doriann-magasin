import 'package:flutter/material.dart';
import '../models/pannier.dart';
import '../services/pannier_database_service.dart';

class HistoriquePannierProvider with ChangeNotifier {
  final PannierDatabaseService _dbService;

  List<Pannier> _items = [];
  bool _isLoading = false;

  List<Pannier> get items => _items;
  bool get isLoading => _isLoading;
  int get itemCount => _items.length;

  HistoriquePannierProvider({PannierDatabaseService? dbService})
      : _dbService = dbService ?? PannierDatabaseService() {
    _chargerPannier();
  }

  Future<void> _chargerPannier() async {
    _isLoading = true;
    notifyListeners();
    try {
      _items = await _dbService.getPannier();
    } catch (_) {
      _items = [];
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> ajouterAPannier(Pannier pannier) async {
    if (_items.any((i) => i.id == pannier.id)) return;
    _items.add(pannier);
    await _dbService.savePannier(_items);
    notifyListeners();
  }

  Future<void> retirerPannier(int pannierId) async {
    _items.removeWhere((i) => i.id == pannierId);
    await _dbService.savePannier(_items);
    notifyListeners();
  }
  Future<void> clearPannier() async {
    _items.clear();
    await _dbService.clearPannier();
    notifyListeners();
  }
  Future<Pannier?> getPannierById(int pannierId) async {
    return _items.firstWhere((i) => i.id == pannierId);
  }
}