import 'package:go_router/go_router.dart';
import 'package:seminari_flutter/screens/auth/login_screen.dart';
import 'package:seminari_flutter/screens/borrar_screen.dart';
import 'package:seminari_flutter/screens/details_screen.dart';
import 'package:seminari_flutter/screens/editar_screen.dart';
import 'package:seminari_flutter/screens/imprimir_screen.dart';
import 'package:seminari_flutter/screens/home_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) =>  LoginPage(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'details',
          builder: (context, state) => const DetailsScreen(),
          routes: [
            GoRoute(
              path: 'imprimir',
              builder: (context, state) => const ImprimirScreen(),
            ),
          ],
        ),
        GoRoute(
          path: 'editar',
          builder: (context, state) => const EditarScreen(),
        ),
        GoRoute(
          path: 'borrar',
          builder: (context, state) => const BorrarScreen(),
        ),
      ],
    ),
  ],
);
