import 'package:flutter/material.dart';

class ScaffoldBackground extends StatelessWidget {
  const ScaffoldBackground({required this.scaffold, Key? key})
      : super(key: key);
  final Widget scaffold;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
        ),
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromRGBO(183, 249, 220, .4),
                Color.fromRGBO(255, 238, 187, .4),
                Color.fromRGBO(194, 193, 249, .4),
                Color.fromRGBO(255, 207, 187, .4),
              ],
            ),
          ),
          child: scaffold,
        ),
      ],
    );
  }
}
