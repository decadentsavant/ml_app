import 'package:flutter/material.dart';
import 'package:ml_app/stats/stats.dart';
import 'package:ml_app/theme/theme.dart';

class HeatMapColumn extends StatelessWidget {
  HeatMapColumn({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.numDays,
  })  : dayContainers = List.generate(
          numDays,
          (i) => HeatMapContainer(
            date: DateUtility.changeDay(startDate, 1),
          ),
        ),
        emptySpace = (numDays != 7)
            ? List.generate(
                7 - numDays,
                (i) => const HeatMapContainer(
                  date: null,
                  color: MLColors.primaryColor,
                ),
              )
            : [];

  final List<Widget> dayContainers;
  final List<Widget> emptySpace;

  final DateTime startDate;
  final DateTime endDate;

  final int numDays;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: <Widget>[
          ...dayContainers,
          ...emptySpace,
        ],
      ),
    );
  }
}
