import 'package:flutter/foundation.dart';

class CadUserLoginController extends ChangeNotifier {
  String _nameUser = "";
  String _senhaUser = "";

  String get nameUser => _nameUser;
  String get senhaUser => _senhaUser;

  set nome(String nome) {
    _nameUser = nome;
    notifyListeners();
  }

  set senha(String senha) {
    _senhaUser = senha;
    notifyListeners();
  }
}
