import 'package:flutter/material.dart';

class ScaffoldWrapper extends StatelessWidget {
  const ScaffoldWrapper({required this.scaffold, Key? key})
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
                Color.fromRGBO(183, 249, 220, .1),
                Color.fromRGBO(255, 238, 187, .1),
                Color.fromRGBO(194, 193, 249, .1),
                Color.fromRGBO(255, 207, 187, .1),
              ],
            ),
          ),
          child: scaffold,
        ),
      ],
    );
  }
}
