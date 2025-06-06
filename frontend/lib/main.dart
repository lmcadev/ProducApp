import 'package:flutter/material.dart';
import 'package:frontend/screens/login/login_page.dart';
import 'package:frontend/screens/home_page.dart';
import 'package:frontend/utils/shared_preferences_helper.dart';
import 'package:frontend/widgets/dialogs/loading_general.dart';

// Simular token y rol guardado para probar navegación directa a HomePage
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await SharedPreferencesHelper.saveToken(
//     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJ1c3VhcmlvIiwiaWF0IjoxNjkxMjM0NTY3LCJleHAiOjE2OTEyMzgxNjd9.dGhpcy1pcy1hLXNlY3JldC1zaWduYXR1cmU',
//   );

//   await SharedPreferencesHelper.saveRol('Administrador');

//   runApp(ProducApp());
// }

void main() {
  runApp(ProducApp());
}

class ProducApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<String?>(
        future: SharedPreferencesHelper.getToken(),
        builder: (context, tokenSnapshot) {
          if (tokenSnapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: LoadingDialog(),
            );
          }

          // Si no hay token, ir a la LoginPage
          if (!tokenSnapshot.hasData || tokenSnapshot.data!.isEmpty) {
            return const LoginPage();
          }

          // Ya hay token, ahora obtener el rol
          return FutureBuilder<String?>(
            future: SharedPreferencesHelper.getRol(),
            builder: (context, rolSnapshot) {
              if (rolSnapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: LoadingDialog(),
                );
              }

              // Aquí empieza la validación que agregamos
              final rawRole = rolSnapshot.data;

              final validRoles = [
                'ADMINISTRADOR',
                'SUPERVISOR',
                'OPERARIO',
                'USUARIO'
              ];

              final normalizedRole = rawRole?.toUpperCase();

              // Si el rol no es válido o no existe, enviamos a LoginPage (o lo que quieras)
              if (normalizedRole == null ||
                  !validRoles.contains(normalizedRole)) {
                return const LoginPage();
              }

              // Si todo está OK, mandamos el rol normalizado a HomePage
              return HomePage(userRole: normalizedRole);
            },
          );
        },
      ),
    );
  }
}
