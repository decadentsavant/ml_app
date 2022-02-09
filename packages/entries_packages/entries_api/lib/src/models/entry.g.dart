// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter, cast_nullable_to_non_nullable,
// ignore_for_file: require_trailing_commas

part of 'entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Entry _$EntryFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Entry',
      json,
      ($checkedConvert) {
        final val = Entry(
          id: $checkedConvert('id', (v) => v as String?),
          title: $checkedConvert('title', (v) => v as String),
          notes: $checkedConvert('notes', (v) => v as String),
          source: $checkedConvert('source', (v) => v as String?),
          relatedUrl: $checkedConvert('related_url', (v) => v as String?),
          frequencyType: $checkedConvert(
              'frequency_type',
              (v) =>
                  _$enumDecodeNullable(_$FrequencyTypeEnumMap, v) ??
                  FrequencyType.periodically),
          frequencyInDays: $checkedConvert(
              'frequency_in_days',
              (v) =>
                  (v as List<dynamic>?)?.map((e) => e as int).toList() ??
                  const [1, 2, 4, 7, 14, 21, 30, 60, 90, 180, 365]),
          entryPriority: $checkedConvert(
              'entry_priority',
              (v) =>
                  _$enumDecodeNullable(_$EntryPriorityEnumMap, v) ??
                  EntryPriority.normal),
          activationDate: $checkedConvert('activation_date',
              (v) => v == null ? null : DateTime.parse(v as String)),
          isActive: $checkedConvert('is_active', (v) => v as bool? ?? true),
        );
        return val;
      },
      fieldKeyMap: const {
        'relatedUrl': 'related_url',
        'frequencyType': 'frequency_type',
        'frequencyInDays': 'frequency_in_days',
        'entryPriority': 'entry_priority',
        'activationDate': 'activation_date',
        'isActive': 'is_active'
      },
    );

Map<String, dynamic> _$EntryToJson(Entry instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'source': instance.source,
      'notes': instance.notes,
      'related_url': instance.relatedUrl,
      'frequency_type': _$FrequencyTypeEnumMap[instance.frequencyType],
      'frequency_in_days': instance.frequencyInDays,
      'entry_priority': _$EntryPriorityEnumMap[instance.entryPriority],
      'activation_date': instance.activationDate.toIso8601String(),
      'is_active': instance.isActive,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$FrequencyTypeEnumMap = {
  FrequencyType.daily: 'Daily',
  FrequencyType.periodically: 'Periodically',
};

const _$EntryPriorityEnumMap = {
  EntryPriority.normal: 'Normal',
  EntryPriority.high: 'High',
  EntryPriority.highest: 'Highest',
};
