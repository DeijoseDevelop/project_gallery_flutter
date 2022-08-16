import 'package:flutter/material.dart';
import 'package:gallery_image/views/views.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../modelview/services/services.dart';

class AuthView extends StatelessWidget {
  const AuthView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: const Text(
        'Local Authentication',
        style: TextStyle(color: Colors.black),
      )),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/Fingerprint.png',
                width: size.width * 0.8,
              ),
              const SizedBox(height: 20),
              const Text(
                  'Tap on the button to authenticate with the device\'s local authentication system.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 21,
                    color: Colors.black,
                  )),
              const SizedBox(height: 30),
              _LoginBiometric(size: size),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              _LoginEmailAndPassword(size: size)
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginEmailAndPassword extends StatelessWidget {
  const _LoginEmailAndPassword({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      child: TextButton(
        onPressed: () async {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => LoginView()),
                (Route<dynamic> route) => false);
        },
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(20),
          backgroundColor: Colors.blue,
          shadowColor: const Color(0xFF323247),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'LOGIN WITH EMAIL AND PASSWORD',
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.w600,
                wordSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoginBiometric extends StatelessWidget {
  const _LoginBiometric({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      child: TextButton(
        onPressed: () async {
          bool isAuthenticated = await AuthService.authenticateUser();
          const storage = FlutterSecureStorage();
          if (isAuthenticated) {
            await storage.write(key: 'token', value: 'tuehvuehnvuenuivneauncvuiebnuicvehnsui');
            // ignore: use_build_context_synchronously
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomeView()),
              (Route<dynamic> route) => false,
            );
          } else {
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Authentication failed.'),
              ),
            );
          }
        },
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(20),
          backgroundColor: Colors.blue,
          shadowColor: const Color(0xFF323247),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'LOGIN WITH BIOMETRICS',
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.w600,
                wordSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
