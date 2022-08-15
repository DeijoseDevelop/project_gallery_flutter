import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class AuthService {
  static Future<bool> authenticateUser() async {

    final LocalAuthentication _localAuthentication = LocalAuthentication();

    bool isAuthenticated = false;

    if (await is_supported()) {
      try {
        isAuthenticated = await _localAuthentication.authenticate(
          localizedReason: 'Scan your fingerprint to authenticate',
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: true,
            sensitiveTransaction: true,
          )
        );
      } on PlatformException catch (e) {
        print(e);
      }
    }
    return isAuthenticated;
  }
  // ignore: non_constant_identifier_names
  static Future<bool> is_supported() async {
    final LocalAuthentication _localAuthentication = LocalAuthentication();
    bool isBiometricSupported = await _localAuthentication.isDeviceSupported();
    bool canCheckBiometrics = await _localAuthentication.canCheckBiometrics;
    if(isBiometricSupported && canCheckBiometrics) {
      return true;
    }
    return false;
  }
}