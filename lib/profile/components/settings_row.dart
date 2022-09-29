import 'package:flutter/material.dart';

class SettingsRow extends StatelessWidget {
  const SettingsRow({
    Key? key,
    required this.icon,
    required this.title,
    required this.function,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final Function() function;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: GestureDetector(
        onTap: function,
        child: Row(
          children: <Widget>[
            Icon(icon),
            const SizedBox(width: 4),
            Flexible(
              child: Text(title),
            ),
          ],
        ),
      ),
    );
  }
}
