import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ml_app/sign_up/sign_up.dart';
import 'package:ml_app/theme/theme.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SignUpPage());
  }
 
  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      scaffold: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocProvider<SignUpCubit>(
            create: (_) => SignUpCubit(
              context.read<AuthenticationRepository>(),
            ),
            child: const SignUpForm(),
          ),
        ),
      ),
    );
  }
}
