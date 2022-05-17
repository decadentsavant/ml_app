import 'package:flutter/material.dart';

class SevenDayTracking extends StatelessWidget {
  const SevenDayTracking({
    required this.didMakeEntryLastSevenDays,
    required this.didFocusLastSevenDays,
    super.key,
  });

  final Map<int, bool> didMakeEntryLastSevenDays;
  final Map<int, bool> didFocusLastSevenDays;

  List<Map<String, bool>> get sevenDaysData {
    return List.generate(
      7,
      (index) {
        final weekDay = DateTime.now().subtract(
          Duration(days: index),
        );

        return {
          'entry': false,
          'focus': false,
        };
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Text('whatup');
  }
}
