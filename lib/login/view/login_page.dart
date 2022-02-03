import 'package:flutter/material.dart';
import 'package:ml_app/theme/shared_ui_widgets/shared_ui_widgets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: const [
          Background(),
          Center(
            child: Text('Login Page'),
          )
        ],
      ),
    );
  }
}
