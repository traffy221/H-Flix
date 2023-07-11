import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:front/controllers/user_controller.dart';
import 'package:front/vues/Introduction/splashscreen.dart';
import 'package:front/vues/authentification/login_view.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<UserController>(context);
    switch (auth.status) {
      case Status.unInitialized:
        return SplashScreen();
      case Status.unAuthenticated:
        return const LoginView();
      case Status.authenticating:
        return const LoginView();
      default:
        return const LoginView();
    }
  }
}
