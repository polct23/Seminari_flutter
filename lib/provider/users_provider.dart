import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/UserService.dart';

class UserProvider with ChangeNotifier {
  List<User> _users = [];
  bool _isLoading = false;

  List<User> get users => _users;
  bool get isLoading => _isLoading;

  Future<void> loadUsers() async {
    _isLoading = true;
    notifyListeners();

    try {
      _users = await UserService.getUsers();
    } catch (e) {
      _users = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  crearUsuari(String nom, int edat, String email, String password) {
    final nouUsuari = User(name: nom, age: edat, email: email,password: password);
    _users.add(nouUsuari);
    notifyListeners();
  }

  eliminarUsuari(String name) {
    _users.removeWhere((user) => user.name == name);
    notifyListeners();
  }
}
