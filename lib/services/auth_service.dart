import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import '../models/user.dart';

class AuthService {
  User? _currentUser; // Variable para almacenar el usuario logueado
  bool isLoggedIn =
      false; // Variable para verificar si el usuario está logueado
  static String get _baseUrl {
    if (kIsWeb) {
      return 'http://localhost:9000/api/users';
    } else if (!kIsWeb && Platform.isAndroid) {
      return 'http://10.0.2.2:9000/api/users';
    } else {
      return 'http://localhost:9000/api/users';
    }
  }

  // Método para iniciar sesión
  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$_baseUrl/login');
    final body = json.encode({'email': email, 'password': password});

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Extraer el ID del usuario del JSON de respuesta
        final userId = data['id'];

        // Hacer una solicitud GET para obtener los datos completos del usuario
        final userResponse = await http.get(
          Uri.parse('$_baseUrl/$userId'),
          headers: {'Content-Type': 'application/json'},
        );

        if (userResponse.statusCode == 200) {
          final userData = json.decode(userResponse.body);

          _currentUser = User(
            id: userData['id'],
            name: userData['name'],
            email: userData['email'],
            age: userData['age'],
            password: userData['password'],
          );
          print('Usuario logueado: ${_currentUser!.name}');
          isLoggedIn = true;
          // Devuelve los datos del usuario
          return {'success': true, 'user': userData};
        } else {
          return {'error': 'No se pudo obtener la información del usuario'};
        }
      } else {
        return {'error': 'Email o contraseña incorrectos'};
      }
    } catch (e) {
      return {'error': 'Error de conexión'};
    }
  }

  // Método para obtener el usuario logueado
  User getCurrentUser() {
    if (_currentUser == null) {
      throw Exception('No hay un usuario logueado');
    }
    return _currentUser!;
  }

  // Método para cerrar sesión
  void logout() {
    _currentUser = null;
    print("Sessió tancada");
  }
}
