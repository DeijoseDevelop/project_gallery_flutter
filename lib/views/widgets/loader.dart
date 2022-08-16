import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class _Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Material(
        color: Colors.transparent,
        child: Center(
          child: Lottie.asset('assets/loading.json'),
        ),
      ),
    );
  }
}

void openLoader(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    useRootNavigator: true,
    builder: (BuildContext context) {
      return _Loader();
    },
  );
}

void closeLoader(BuildContext context) {
  Navigator.of(context, rootNavigator: true).pop();
}
