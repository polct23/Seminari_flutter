import 'package:flutter/material.dart';
import 'package:seminari_flutter/provider/users_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/UserCard.dart';

class BorrarScreen extends StatefulWidget {
  const BorrarScreen({super.key});
  @override
  State<BorrarScreen> createState() => _BorrarScreenState();
}
class _BorrarScreenState extends State<BorrarScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context, listen: true);
    return Scaffold(
    appBar: AppBar(title: const Text('Borrar')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Llista usuaris que es poden esborrar',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: provider.users.length,
              itemBuilder: (context, index) {
                final user = provider.users[index];
                return GestureDetector(
                  onTap: () {
                    provider.eliminarUsuari(user.name);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Usuari ${user.name} eliminat'),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  child: UserCard(user: user),
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
  }
}