import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class UserService {
  static String get baseUrl {
  if (kIsWeb) {
    return 'http://localhost:9000/api/users';
  } 
  else if (!kIsWeb && Platform.isAndroid) {
    return 'http://10.0.2.2:9000/api/users';
  } 
  else {
    return 'http://localhost:9000/api/users';
  }
}

  static Future<List<User>> getUsers() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Error en carregar usuaris');
    }
  }

  static Future<User> createUser(User user) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al crear usuari: ${response.statusCode}');
    }
  }

  static Future<User> getUserById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Error a l'obtenir usuari: ${response.statusCode}");
    }
  }

  static Future<User> updateUser(String id, User user) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error actualitzant usuari: ${response.statusCode}');
    }
  }

  static Future<bool> deleteUser(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Error eliminant usuari: ${response.statusCode}');
    }
  }

  static Future<User?> modificaUser(User user) async {
  print('Enviant dades al backend per modificar usuari: ${user.toJson()}');
  try {
    final body = {
      "_id": user.id,
      "name": user.name,
      "age": user.age,
      "email": user.email,
      "password": user.password,
    };

    final response = await http.put(
      Uri.parse('http://localhost:9000/api/users/${user.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return User.fromJson(data);
    } else {
      print('Error del backend: ${response.body}');
      return null;
    }
  } catch (e) {
    throw Exception('Error al modificar usuari: $e');
  }
}
}