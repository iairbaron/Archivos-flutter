import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inscripcion_esgrima_fae/pages/mis_datos.dart';
import 'package:flutter_inscripcion_esgrima_fae/pages/pdf_Screen.dart';
import 'package:flutter_inscripcion_esgrima_fae/pages/ad_usuario_prueba.dart';
import 'package:flutter_inscripcion_esgrima_fae/pages/afiliacion_anual.dart';
import 'package:flutter_inscripcion_esgrima_fae/pages/crear_torneo_page.dart';
import 'package:flutter_inscripcion_esgrima_fae/pages/inscripcion_torneo.dart';
import 'package:flutter_inscripcion_esgrima_fae/pages/lista_inscripciones.dart';
import 'package:flutter_inscripcion_esgrima_fae/services/auth_services.dart';
import 'package:flutter_inscripcion_esgrima_fae/widget/AppBar/app_bar.dart';
import 'package:flutter_inscripcion_esgrima_fae/widget/bottomNavigation/bottom_navigation.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_inscripcion_esgrima_fae/services/notifications_service.dart';

import 'package:flutter_inscripcion_esgrima_fae/pages/UdemyPages/register_screen.dart';
import 'package:flutter_inscripcion_esgrima_fae/pages/UdemyPages/log_in2.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        "/": (context) => LoginScreen(),
        "/Home": (context) => Builder(
              builder: (context) => const MyScaffold(
                body: LoginScreen(),
              ),
            ),
        "/AddTorneo": (context) => Builder(
              builder: (context) => const MyScaffold(
                body: AddTorneo(),
              ),
            ),
        "/LogIn": (context) => const LoginScreen(),
        "/Register": (context) => const RegisterScreen(),
        "/Prueba": (context) => Builder(
              builder: (context) => FutureBuilder<bool>(
                future: checkIfUserExists(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final userExists = snapshot.data!;
                    if (userExists) {
                      return MyScaffold(
                          body: MisDatos(
                        title: '',
                      ));
                    } else {
                      return const MyScaffold(
                        body: AddUsuario(),
                      );
                    }
                  } else if (snapshot.hasError) {
                    return const MyScaffold(
                      body: Text('Error'),
                    );
                  } else {
                    return const MyScaffold(
                      body: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              ),
            ),
        "/Afiliacion2023": (context) => Builder(
              builder: (context) => FutureBuilder<bool>(
                future: checkIfAfiliadoExists(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final userExists = snapshot.data!;
                    if (userExists) {
                      return MyScaffold(body: PDFScreen());
                    } else {
                      return MyScaffold(
                        body: AfiliacionAnual(),
                      );
                    }
                  } else if (snapshot.hasError) {
                    return const MyScaffold(
                      body: Text('Error'),
                    );
                  } else {
                    return const MyScaffold(
                      body: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              ),
            ),
        '/Inscripciones': (context) => Builder(
              builder: (context) => const MyScaffold(
                body: InscripcionTorneo(),
              ),
            ),
        "/MisInscripciones": (context) => Builder(
              builder: (context) => const MyScaffold(
                body: ListInscripcciones(
                  title: '',
                ),
              ),
            ),
      },
      scaffoldMessengerKey: NotificationsService.messengerKey,
    );
  }
}

class MyScaffold extends StatelessWidget {
  final Widget body;
  const MyScaffold({required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: body,
      bottomNavigationBar:
          CustomBottomNavigation(), // Agrega CustomBottomNavigation aquí
    );
  }
}

Future<bool> checkIfUserExists() async {
  final emailValue = await AuthService().readEmail();
  final querySnapshot = await FirebaseFirestore.instance
      .collection('UsuarioPrueba')
      .where('Usuario', isEqualTo: emailValue)
      .limit(1)
      .get();

  return querySnapshot.docs.isNotEmpty;
}

Future<bool> checkIfAfiliadoExists() async {
  final emailValue = await AuthService().readEmail();
  final querySnapshot = await FirebaseFirestore.instance
      .collection('Afiliacion2023')
      .where('Usuario', isEqualTo: emailValue)
      .limit(1)
      .get();

  return querySnapshot.docs.isNotEmpty;
}
