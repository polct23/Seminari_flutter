import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Details')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Botons Push', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              children: [
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
          ],
        ),
      ),
    );
  }
}