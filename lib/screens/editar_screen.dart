import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:seminari_flutter/provider/users_provider.dart';
import 'package:provider/provider.dart';

class EditarScreen extends StatefulWidget {
  const EditarScreen({super.key});

  @override
  State<EditarScreen> createState() => _EditarScreenState();
}

class _EditarScreenState extends State<EditarScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final nomController = TextEditingController();
  final edatController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(title: const Text('Editar')),
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
                  onPressed: () => context.go('/borrar'),
                  child: const Text('/borrar'),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Center(
              child: Container(
                color: const Color.fromARGB(255, 254, 243, 255),
                padding: const EdgeInsets.all(16.0),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text("Crear Usuari", style: Theme.of(context).textTheme.titleLarge),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: nomController,
                          decoration: const InputDecoration(labelText: 'Nom'),
                          validator: (value) => value == null || value.isEmpty ? 'El nom no pot estar buit' : null,
                        ),
                        TextFormField(
                          controller: edatController,
                          decoration: const InputDecoration(labelText: 'Edat'),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) return 'La edat no pot estar buida';
                            final edat = int.tryParse(value);
                            if (edat == null || edat < 0) return 'La edat no és vàlida';
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(labelText: 'Email'),
                          validator: (value) =>
                              value == null || value.isEmpty ? 'El email no pot estar buit' : !value.contains('@') ? 'El email no és vàlid' : null,
                        ),
                        TextFormField(
                          controller: passwordController,
                          decoration: const InputDecoration(labelText: 'Contrasenya'),
                          obscureText: true,
                          validator: (value) =>
                              value == null || value.isEmpty ? 'La contrasenya no pot estar buida' : value.length < 6 ? 'Ha de tenir almenys 6 caràcters' : null,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              provider.crearUsuari(
                                nomController.text,
                                int.tryParse(edatController.text) ?? 0,
                                emailController.text,
                                passwordController.text,
                              );

                              nomController.clear();
                              edatController.clear();
                              emailController.clear();
                              passwordController.clear();

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Usuari creat')),
                              );
                            } 
                          },
                          child: const Text('Crear usuari'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}