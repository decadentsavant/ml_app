import 'package:entries_api/entries_api.dart';

bool isValidFrequencyInDays({
  required List<int> integers,
  required FrequencyType frequencyType,
}) {
  if (frequencyType == FrequencyType.daily && integers.length != 1) {
    return false;
  }
  if (frequencyType == FrequencyType.periodically && integers.isEmpty) {
    return false;
  }
  return true;
}
