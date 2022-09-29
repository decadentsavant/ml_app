import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ml_app/app/bloc/app_bloc.dart';
import 'package:ml_app/profile/profile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(),
      child: const ProfileView(),
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            AppBar(
              centerTitle: true,
              title: const Text('Settings'),
            ),
            const SettingsHeading(heading: 'SUBSCRIPTION'),
            const SizedBox(
              height: 4,
            ),
            SettingsRow(
              title: 'My Subscription: Free for me!',
              icon: Icons.diamond_outlined,
              function: () {},
            ),
            const SizedBox(height: 16),
            const SettingsHeading(heading: 'LEGAL'),
            const SizedBox(
              height: 4,
            ),
            SettingsRow(
              title: 'Terms of Service',
              icon: Icons.article_outlined,
              function: () {},
            ),
            SettingsRow(
              title: 'Privacy Policy',
              icon: Icons.lock_person_outlined,
              function: () {},
            ),
            const SizedBox(height: 16),
            SettingsRow(
              title: 'Sign out',
              icon: Icons.logout_outlined,
              function: () => context.read<AppBloc>().add(AppLogoutRequested()),
            ),
          ],
        ),
      ),
    );
  }
}
