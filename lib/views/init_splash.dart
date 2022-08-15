import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:gallery_image/views/views.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class InitSplash extends StatelessWidget {
  const InitSplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return AnimatedSplashScreen(
      nextScreen: const AuthView(),
      splash: Column(
        children: [
          Expanded(
            child: Image.asset(
              'assets/Google-Photos-logo.jpg',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: _height * 0.1,
          ),
          Text(
            'Google',
            style: GoogleFonts.poppins(
              fontSize: 30,
              color: Colors.black54,
            ),
          ),
        ],
      ),
      splashIconSize: 250,
      backgroundColor: Colors.white,
      duration: 2000,
      splashTransition: SplashTransition.slideTransition,
      pageTransitionType: PageTransitionType.fade,
      animationDuration: const Duration(seconds: 2),
    );
  }
}
