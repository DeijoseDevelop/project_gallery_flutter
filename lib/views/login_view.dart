// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:gallery_image/modelview/providers/auth_login.dart';
import 'package:gallery_image/ui/input_decorations.dart';
import 'package:gallery_image/views/views.dart';
import 'package:gallery_image/views/widgets/loader.dart';

class LoginView extends StatelessWidget {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login'
          , style: TextStyle(
            color: Colors.black,
            fontSize: 35
          ),
        )
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.8,
          child: _PostForm(
            email: _email,
            password: _password,
          ),
        ),
      ),
    );
  }
}

class _PostForm extends StatelessWidget {
  const _PostForm({
    required TextEditingController email,
    required TextEditingController password,
    Key? key,
  })  : _email = email,
        _password = password,
        super(key: key);

  final TextEditingController _email;
  final TextEditingController _password;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        //key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 200,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/secure_login.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                _EmailField(email: _email, password: _password),
                _PasswordField(password: _password, email: _email),
                const SizedBox(height: 50),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromRGBO(55, 58, 140, 1)),
                  ),
                  onPressed: () async {
                    final res = await login(context,
                        email: _email.text, password: _password.text);
                  },
                  child: const Text('Login'),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                TextButton(
                  onPressed: () => Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => RegisterView())),
                  child: const Text(
                    'do you need to register?',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                    ),
                  ),
                )
              ]),
        ),
      ),
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField({
    Key? key,
    required TextEditingController password,
    required TextEditingController email,
  }) : _password = password, _email = email, super(key: key);

  final TextEditingController _password;
  final TextEditingController _email;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      obscuringCharacter: '*',
      autocorrect: false,
      decoration: InputDecorations.authInputDecoration(
          labelText: 'Password', hintText: 'Enter the password'),
      controller: _password,
      onSubmitted: (value) async {
        FocusScope.of(context).requestFocus(FocusNode());
        final res = await login(context,
            email: _email.text, password: _password.text);
        print(res);
      },
    );
  }
}

class _EmailField extends StatelessWidget {
  const _EmailField({
    Key? key,
    required TextEditingController email,
    required TextEditingController password,
  }) : _email = email, _password = password, super(key: key);

  final TextEditingController _email;
  final TextEditingController _password;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      decoration: InputDecorations.authInputDecoration(
          labelText: 'Email', hintText: 'Enter the Email'),
      controller: _email,
      onSubmitted: (value) async {
        FocusScope.of(context).requestFocus(FocusNode());
        final res = await login(context,
            email: _email.text, password: _password.text);
        print(res);
      },
    );
  }
}

Future<Map<String, dynamic>> login(BuildContext context,
    {required String email, required String password}) async {
  final storage = AuthLogin().storage;
  // ignore: use_build_context_synchronously
  openLoader(context);
  AuthLogin _authLogin = AuthLogin();
  final res = await _authLogin.loginUser(email, password);
  if (res.containsKey('idToken')) {
    // ignore: use_build_context_synchronously
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
         builder: (context) => const HomeView()),
      (Route<dynamic> route) => false);
    print(await storage.read(key: 'token'));
  } else {
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('User Not Register.'),
      ),
    );
    // ignore: use_build_context_synchronously
    closeLoader(context);
  }
  return res;
}
