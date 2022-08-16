import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';
import 'package:local_auth_platform_interface/local_auth_platform_interface.dart';
import 'package:local_auth_windows/local_auth_windows.dart';

class AuthService {
  static Future<bool> authenticateUser() async {

    final LocalAuthentication _localAuthentication = LocalAuthentication();

    bool isAuthenticated = false;

    if (await isSupported()) {
      try {
        isAuthenticated = await _localAuthentication.authenticate(
          localizedReason: 'Scan your fingerprint to authenticate',
          authMessages: <AuthMessages>[
            const AndroidAuthMessages(
              cancelButton: 'Cancel',
              goToSettingsButton: 'Settings',
              goToSettingsDescription: 'Open settings to configure your device',
              deviceCredentialsRequiredTitle: 'Authentication required',
              deviceCredentialsSetupDescription: 'Configure your device',
              signInTitle: 'Authenticate',
            ),
            const IOSAuthMessages(
              cancelButton: 'Cancel',
              goToSettingsButton: 'Settings',
              goToSettingsDescription: 'Open settings to configure your device',
            ),
          ],
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
  static Future<bool> isSupported() async {
    final LocalAuthentication _localAuthentication = LocalAuthentication();
    bool isBiometricSupported = await _localAuthentication.isDeviceSupported();
    bool canCheckBiometrics = await _localAuthentication.canCheckBiometrics;
    if(isBiometricSupported && canCheckBiometrics) {
      return true;
    }
    return false;
  }
}