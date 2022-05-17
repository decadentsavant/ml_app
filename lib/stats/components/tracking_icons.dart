import 'package:flutter/material.dart';

class TrackingIcons extends StatelessWidget {
  const TrackingIcons({
    required this.focused,
    required this.entryMade,
    required this.label,
    super.key,
  });

  final bool focused;
  final bool entryMade;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 32,
          width: 20,
          child: Stack(
            children:  const <Widget>[
              Text('Widgets here')
            ],
          ),
        )
      ],
    );
  }
}
