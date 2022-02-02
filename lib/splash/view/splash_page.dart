import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ml_app/router/app_state.dart';
import 'package:provider/provider.dart';

const String loggedInKey = 'LoggedIn';
class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  bool _initialized = false;
  late AppState appState;

  @override
  Widget build(BuildContext context) {
    appState = Provider.of<AppState>(context);
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('WTF SPLASH PAAAAAGE'),
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _initialized = true;
      Timer(const Duration(milliseconds: 500), () {
        appState.setSplashFinished();
      });
    }
  }
}
