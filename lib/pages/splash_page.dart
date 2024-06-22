import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:doto/pages/login_page.dart';
import 'package:doto/pages/navigator_page.dart';
import 'package:doto/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: primaryColor,
      splash: Image.asset('assets/icons/splash.png'),
      splashTransition: SplashTransition.fadeTransition,
      nextScreen: _getNextScreen(),
      duration: 1000,
    );
  }

  Widget _getNextScreen() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const LoginPage();
    } else {
      return const NavigatorPage(
        selectedPage: 0,
      );
    }
  }
}
