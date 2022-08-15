import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class AuthService {
  static Future<bool> authenticateUser() async {

    final LocalAuthentication _localAuthentication = LocalAuthentication();

    bool isAuthenticated = false;

    bool isBiometricSupported = await _localAuthentication.isDeviceSupported();

    bool canCheckBiometrics = await _localAuthentication.canCheckBiometrics;

    if (isBiometricSupported && canCheckBiometrics) {
      try {
        isAuthenticated = await _localAuthentication.authenticate(
          localizedReason: 'Scan your fingerprint to authenticate'
        );
      } on PlatformException catch (e) {
        print(e);
      }
    }
    return isAuthenticated;
  }
}