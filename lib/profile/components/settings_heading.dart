import 'package:flutter/material.dart';

class SettingsHeading extends StatelessWidget {
  const SettingsHeading({
    Key? key,
    required this.heading,
  }) : super(key: key);

  final String heading;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        heading,
        style: textTheme.bodyLarge,
      ),
    );
  }
}
