import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.15, 1],
          colors: [
            Color.fromRGBO(63, 66, 94, 1),
            Color.fromRGBO(33, 37, 58, 1),
          ],
        ),
      ),
    );
  }
}
