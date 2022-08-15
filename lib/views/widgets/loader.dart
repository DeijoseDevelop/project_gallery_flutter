import 'package:flutter/material.dart';

class _Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: const Material(
        color: Colors.transparent,
        child: Center(
          child: CircularProgressIndicator(),
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
