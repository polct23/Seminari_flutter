import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:seminari_flutter/components/my_textfield.dart';
import 'package:seminari_flutter/components/my_button.dart';
import 'package:seminari_flutter/services/auth_service.dart';
import 'package:seminari_flutter/provider/users_provider.dart';
import 'package:provider/provider.dart';
import 'package:seminari_flutter/models/user.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn(BuildContext context) async {
    final authService = AuthService();
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    final email = emailController.text;
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      _showError(context, 'El email i la contrasenya no poden estar buits.');
      return;
    }

    final result = await authService.login(email, password);

    if (result.containsKey('error')) {
      _showError(context, result['error']);
    } else {
      print(result);
      userProvider.setCurrentUser(User.fromJson(result['user']));
      await Future.delayed(Duration.zero);
      context.go('/');
    }
  }

  void _showError(BuildContext context, String message) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Error'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 25),
                const Text(
                  'Benvingut!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 25),
                MyTextfield(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                MyTextfield(
                  controller: passwordController,
                  hintText: 'Contrasenya',
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Has oblidat la teva contrasenya?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                MyButton(onTap: () => signUserIn(context)),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Encara no ets membre?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'Registra\'t',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}