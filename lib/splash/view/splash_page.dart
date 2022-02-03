import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ml_app/router/app_state.dart';
import 'package:ml_app/theme/shared_ui_widgets/shared_ui_widgets.dart';
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
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: const <Widget>[
            Background(),
            Center(
              child: Text('Splash Page'),
            ),
          ],
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
