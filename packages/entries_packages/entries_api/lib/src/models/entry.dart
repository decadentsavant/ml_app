import 'package:entries_api/entries_api.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'entry.g.dart';

/// A Priority value for an entry.
enum EntryPriority {
  /// Lowest value
  @JsonValue('Normal')
  normal,

  /// Medium value
  @JsonValue('High')
  high,

  /// High value
  @JsonValue('Highest')
  highest,
}

/// A frequency value for an entry.
enum FrequencyType {
  /// Indicates the entry should recur daily.
  @JsonValue('Daily')
  daily,

  /// Indicates the entry should recur periodically.
  @JsonValue('Periodically')
  periodically,
}

/// {@template entry}
/// A single entry item.
///
/// Contains an [id], [title], [source], [notes], [relatedUrl], [frequencyType],
/// [frequencyInDays], [entryPriority], [activationDate], and an [isActive]
/// flag.
/// {@endtemplate}
@immutable
@JsonSerializable()
class Entry extends Equatable {
  /// {@macro entry}
  Entry({
    String? id,
    required this.title,
    required this.notes,
    this.source,
    this.relatedUrl,
    this.frequencyType = FrequencyType.periodically,
    this.frequencyInDays = const [1, 2, 4, 7, 14, 21, 30, 60, 90, 180, 365],
    this.entryPriority = EntryPriority.normal,
    DateTime? activationDate,
    this.isActive = true,
    this.learningStamps = const {},
  })  : assert(
          id == null || id.isNotEmpty,
          'id can not be null and should not be empty',
        ),
        id = id ?? const Uuid().v4(),
        activationDate = activationDate ?? DateTime.now().toUtc();

  /// The entry's id.
  ///
  /// Cannot be empty. Initialized with argument or via Uuid().v4().
  final String id;

  /// The entry's title.
  ///
  /// The title is required.
  final String title;

  /// The entry's source.
  ///
  /// The source may be empty.
  final String? source;

  /// The entry's notes.
  ///
  /// The notes are required.
  final String notes;

  /// The URL related to the entry.
  ///
  /// The URL may be empty.
  final String? relatedUrl;

  /// The frequency type for the entry.
  ///
  /// Defaults to periodically.
  final FrequencyType frequencyType;

  /// A list of numbers representing the frequency in which the entry occurs.
  ///
  /// Defaults to [1,2,4,7,14,21,30,60,90,180,365].
  final List<int> frequencyInDays;

  /// The priority value for the entry.
  ///
  /// Defaults to [EntryPriority].normal.
  final EntryPriority entryPriority;

  /// The entry's date of activation.
  ///
  /// Cannot be empty. Initialzied with argument or via [DateTime].now().
  final DateTime activationDate;

  /// Indicates the entry should still have at least one recurrance
  /// in the future.
  final bool isActive;

  /// The entry's records of focused learning time.
  ///
  /// [Map] consisting of [DateTime] timestamps and [int] lengths of
  /// focused learning time.
  final Map<DateTime, int> learningStamps;

  /// Returns a copy of this entry with the given values updated.
  ///
  /// {@macro entry}
  Entry copyWith(
      {String? id,
      String? title,
      String? notes,
      String? source,
      String? relatedUrl,
      FrequencyType? frequencyType,
      List<int>? frequencyInDays,
      EntryPriority? entryPriority,
      DateTime? activationDate,
      bool? isActive,
      Map<DateTime, int>? learningStamps,
      }) {
    assert(
      !(frequencyType == FrequencyType.daily && frequencyInDays!.length != 1),
      'frequencyInDays must have a length of 1 for dailies',
    );
    assert(
      !(frequencyType == FrequencyType.periodically &&
          frequencyInDays!.isEmpty),
      'Periodicals cannot have empty frequencyInDays',
    );
    return Entry(
      id: id ?? this.id,
      title: title ?? this.title,
      notes: notes ?? this.notes,
      source: source ?? this.source,
      relatedUrl: relatedUrl ?? this.relatedUrl,
      frequencyType: frequencyType ?? this.frequencyType,
      frequencyInDays: frequencyInDays ?? this.frequencyInDays,
      entryPriority: entryPriority ?? this.entryPriority,
      activationDate: activationDate ?? this.activationDate,
      isActive: isActive ?? this.isActive,
      learningStamps: learningStamps ?? this.learningStamps,
    );
  }

  /// Deserializes the given [JsonMap] into a [Entry].
  static Entry fromJson(JsonMap json) => _$EntryFromJson(json);

  /// Converts this [Entry] into a [JsonMap].
  JsonMap toJson() => _$EntryToJson(this);

  @override
  List<Object?> get props => [
        id,
        title,
        notes,
        source,
        relatedUrl,
        frequencyType,
        frequencyInDays,
        entryPriority,
        activationDate,
        isActive,
        learningStamps
      ];
}
