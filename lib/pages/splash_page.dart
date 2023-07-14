import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:doto/pages/navigator_page.dart';
import 'package:doto/utils/constants.dart';
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
      nextScreen: const NavigatorPage(),
      duration: 1000,
    );
  }
}
