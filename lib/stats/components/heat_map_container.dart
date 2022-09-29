import 'package:flutter/material.dart';

class HeatMapContainer extends StatelessWidget {
  const HeatMapContainer({
    required this.date,
    this.color,
    super.key,
  });

  final DateTime? date;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    width = (width - 160) / 52;
    return Padding(
      padding: const EdgeInsets.all(1),
      child: SizedBox(
        child: Container(
          height: width,
          width: width,
          decoration: BoxDecoration(
            color: color ?? Colors.black12,
            borderRadius: const BorderRadius.all(
              Radius.circular(4),
            ),
          ),
        ),
      ),
    );
  }
}
