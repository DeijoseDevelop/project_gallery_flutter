import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:gallery_image/modelview/services/services.dart';
import 'package:gallery_image/views/views.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class InitSplash extends StatefulWidget {
  const InitSplash({Key? key}) : super(key: key);

  @override
  State<InitSplash> createState() => _InitSplashState();
}

class _InitSplashState extends State<InitSplash> {
  bool? deviceSupported;
  bool? isLogged;

  void isSupported() async {
    final supported = await AuthService.isSupported();
    setState(() {
      deviceSupported = supported;
    });
  }

  void verifyLogged() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    setState(() {
      isLogged = token != null;
    });
  }

  @override
  void initState() {
    super.initState();
    isSupported();
    verifyLogged();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return AnimatedSplashScreen(
      nextScreen: isLogged == true
          ? const HomeView()
          : deviceSupported != false
              ? const AuthView()
              : LoginView(),
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
