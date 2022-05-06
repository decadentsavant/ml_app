import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ml_app/login/login.dart';
import 'package:ml_app/theme/theme.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: LoginPage());

  @override
  Widget build(BuildContext context) {
    return ScaffoldBackground(
      scaffold: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocProvider(
            create: (_) => LoginCubit(context.read<AuthenticationRepository>()),
            child: const LoginForm(),
          ),
        ),
      ),
    );
  }
}
