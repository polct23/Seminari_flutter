import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../widgets/UserCard.dart';
import 'package:seminari_flutter/provider/users_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: SingleChildScrollView( // Permite el desplazamiento vertical
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Botons Push', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () => context.push('/details'),
                    child: const Text('/details'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () => context.push('/details/imprimir'),
                    child: const Text('/details/imprimir'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () => context.push('/editar'),
                    child: const Text('/editar'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () => context.push('/borrar'),
                    child: const Text('/borrar'),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              const Text('Botons Go', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () => context.go('/details'),
                    child: const Text('/details'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () => context.go('/details/imprimir'),
                    child: const Text('/details/imprimir'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () => context.go('/editar'),
                    child: const Text('/editar'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () => context.go('/borrar'),
                    child: const Text('/borrar'),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  onPressed: () => provider.loadUsers(),
                  child: const Text('Obtindre Usuaris'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    textStyle: const TextStyle(fontSize: 25),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              if (provider.users.isNotEmpty)
                SizedBox( 
                  height: 400, 
                  child: ListView.builder(
                    itemCount: provider.users.length,
                    itemBuilder: (context, index) {
                      final user = provider.users[index];
                      return UserCard(user: user);
                    },
                  ),
                ),
              if (provider.isLoading)
                const Center(
                  child: CircularProgressIndicator(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}