import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:front/controllers/user_controller.dart';
import 'package:front/vues/authentification/login_view.dart';
import 'package:front/vues/authentification/register_view.dart';
import 'package:front/vues/wrapper.dart';
import 'package:provider/provider.dart';
import 'config/firebase_options.dart';
import 'vues/accueil/humeur_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserController>.value(
          value: UserController.initialize(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const Wrapper(),
        routes: {
          'login': (context) => const LoginView(),
          'register': (context) => const RegisterView(),
          'accueil': (context) =>
              HumeurView(), // Ajout de la route vers HumeurView
        },
      ),
    );
  }
}
