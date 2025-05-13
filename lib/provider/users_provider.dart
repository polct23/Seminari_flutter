import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/UserService.dart';

class UserProvider with ChangeNotifier {
  List<User> _users = [];
  bool _isLoading = false;
  String? _error;


  User currentUser = User(
    id: null,
    name: '',
    age: 0,
    email: '',
    password: '',
  );


  List<User> get users => _users;
  bool get isLoading => _isLoading;
  String? get error => _error;

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String? errorMessage) {
    _error = errorMessage;
    notifyListeners();
  }

  void setCurrentUser(User user) {
    currentUser = user;
    print('Usuario actualizado: ${currentUser.toJson()}');
    notifyListeners();
  }

  Future<void> loadUsers() async {
    _setLoading(true);
    _setError(null);
    //notifyListeners();

    try {
      _users = await UserService.getUsers();
    } catch (e) {
      _setError('Error loading users: $e');
      _users = [];
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> crearUsuari(String nom, int edat, String email, String password) async {
    _setLoading(true);
    _setError(null);

    try {
      final nouUsuari = User(name: nom, age: edat, email: email,password: password);
      final createdUser = await UserService.createUser(nouUsuari);
      _users.add(nouUsuari);
      _setLoading(false);
      notifyListeners();
      return true;
    } catch (e) {
      _setError('Error creating user: $e');
      _setLoading(false);
      return false;
    }
  }
  Future<bool> modificarUsuari(
  String? id,
  String nom,
  int edat,
  String email,
) async {
  if (id == null || id.isEmpty) {
    _setError('Error: El ID del usuario es nulo o vacío');
    return false;
  }

  _setLoading(true);
  _setError(null);

  final password = currentUser.password ?? '';

  final nouUsuari = User(
    id: id,
    name: nom,
    age: edat,
    email: email,
    password: password,
  );

  try {
    final createdUser = await UserService.modificaUser(nouUsuari);
    if (createdUser != null) {
      setCurrentUser(createdUser);
      _setLoading(false);
      notifyListeners();
      return true;
    } else {
      _setError('Error: El servicio devolvió un usuario nulo');
      _setLoading(false);
      return false;
    }
  } catch (e) {
    _setError('Error modificando el usuario: $e');
    _setLoading(false);
    return false;
  }
}

  Future<bool> eliminarUsuariPerId (String id) async {
    _setLoading(true);
    _setError(null);
    try{
      final success = await UserService.deleteUser(id);
      if (success) {
        _users.removeWhere((user) => user.id == id);
        notifyListeners();
      }
      _setLoading(false);
      return success;
    } catch (e) {
      _setError('Error deleting user: $e');
      _setLoading(false);
      return false;
    }
  }
  Future<bool> eliminarUsuari(String name) async {
    _setLoading(true);
    _setError(null);

    try {
      // Trobem l'usuari pel nom
      final userToDelete = _users.firstWhere((user) => user.name == name);
      
      if (userToDelete.id != null) {
        final success = await UserService.deleteUser(userToDelete.id!);
        
        if (success) {
          // Eliminar l'usuari de la llista local
          _users.removeWhere((user) => user.name == name);
          notifyListeners();
        }
        
        _setLoading(false);
        return success;
      } else {
        // Si no té id, eliminar localment
        _users.removeWhere((user) => user.name == name);
        notifyListeners();
        _setLoading(false);
        return true;
      }
    } catch (e) {
      _setError('Error deleting user: $e');
      _setLoading(false);
      return false;
    }
  }
  Future<bool> canviarContrasenya(String password) async {
  _setLoading(true);
  _setError(null);

  final newUser = User(
    id: currentUser.id,
    name: currentUser.name,
    age: currentUser.age,
    email: currentUser.email,
    password: password,
  );

  try {
    final user = await UserService.modificaUser(newUser);

    if (user != null) {
      currentUser = user;
      notifyListeners();
      return true;
    } else {
      _setError('Error canviant contrasenya: Usuari no trobat');
      return false;
    }
  } catch (e) {
    _setError('Error canviant contrasenya: $e');
    _setLoading(false);
    return false;
  } finally {
    _setLoading(false);
  }
}
}