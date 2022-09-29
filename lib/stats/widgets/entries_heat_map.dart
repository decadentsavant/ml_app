import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ml_app/stats/stats.dart';
import 'package:ml_app/theme/theme.dart';

class EntriesHeatMap extends StatelessWidget {
  EntriesHeatMap({
    super.key,
    required this.startDate,
    required this.endDate,
  }) : _dateDifference = endDate.difference(startDate).inDays;

  final int _dateDifference;
  final DateTime startDate;
  final DateTime endDate;

  List<Widget> _heatMapColumnList() {
    final columns = <Widget>[];

    for (var index = 0 - (startDate.weekday % 7);
        index <= _dateDifference;
        index += 7) {
          
      final _firstDay = DateUtility.changeDay(startDate, index);

      columns.add(
        HeatMapColumn(
          startDate: _firstDay,
          endDate: index <= _dateDifference - 7
              ? DateUtility.changeDay(startDate, index + 6)
              : endDate,
          numDays: min(endDate.difference(_firstDay).inDays + 1, 7),
        ),
      );
    }
    return columns;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MLPadding.defaultWidget,
      child: Card(
        elevation: 1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ..._heatMapColumnList(),
          ],
        ),
      ),
    );
  }
}
