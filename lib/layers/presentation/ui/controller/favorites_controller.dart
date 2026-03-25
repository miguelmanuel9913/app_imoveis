import 'package:flutter/material.dart';

class FavoritesController extends ChangeNotifier {
  final List<Map<String, dynamic>> _favorites = [];

  List<Map<String, dynamic>> get favorites => _favorites;

  void toggleFavorite(Map<String, dynamic> casa) {
    final index = _favorites.indexWhere((c) => c['id'] == casa['id']);
    if (index >= 0) {
      _favorites.removeAt(index);
    } else {
      _favorites.add(casa);
    }
    notifyListeners();
  }

  bool isFavorite(Map<String, dynamic> casa) {

    if (casa.containsKey('id')) {
       return _favorites.any((c) => c['id'] == casa['id']);
    }
    return _favorites.contains(casa);
  }
}
