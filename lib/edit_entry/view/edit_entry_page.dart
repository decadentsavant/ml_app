import 'package:entries_repository/entries_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ml_app/edit_entry/edit_entry.dart';
import 'package:ml_app/theme/theme.dart';


class EditEntryPage extends StatelessWidget {
  const EditEntryPage({Key? key}) : super(key: key);

  static Route<void> route({Entry? initialEntry}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider(
        create: (context) => EditEntryBloc(
          entriesRepository: context.read<EntriesRepository>(),
          initialEntry: initialEntry,
        ),
        child: const EditEntryPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditEntryBloc, EditEntryState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          current.status == EditEntryStatus.success,
      listener: (context, state) => Navigator.of(context).pop(),
      child: const EditEntryView(),
    );
  }
}

class EditEntryView extends StatelessWidget {
  const EditEntryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final status = context.select((EditEntryBloc bloc) => bloc.state.status);
    final isNewEntry = context.select(
      (EditEntryBloc bloc) => bloc.state.isNewEntry,
    );
    final theme = Theme.of(context);
    final floatingActionButtonTheme = theme.floatingActionButtonTheme;
    final fabBackgroundColor = floatingActionButtonTheme.backgroundColor ??
        theme.colorScheme.secondary;

    return ScaffoldWrapper(
      scaffold: Scaffold(
        floatingActionButton: FloatingActionButton(
          tooltip: 'Edit Entry',
          shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32)),
          ),
          backgroundColor: status.isLoadingOrSuccess
              ? fabBackgroundColor.withOpacity(0.5)
              : fabBackgroundColor,
          onPressed: status.isLoadingOrSuccess
              ? null
              : () =>
                  context.read<EditEntryBloc>().add(const EditEntrySubmitted()),
          child: status.isLoadingOrSuccess
              ? const CupertinoActivityIndicator()
              : const Icon(Icons.check_rounded),
        ),
        body: CupertinoScrollbar(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  AppBar(
                    title: Text(
                      isNewEntry ? 'Create Entry' : 'Edit Entry',
                    ),
                  ),
                  const _TitleField(),
                  const _NotesField(),
                  const _SourceField(),
                  const _RelatedUrlField(),
                  const _FrequencyTypeField(),
                  const _FrequencyInDaysField(),
                  if (!isNewEntry) const _ActivationDateField(),
                  const SizedBox(height: 20),
                  const _EntryPriority(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TitleField extends StatelessWidget {
  const _TitleField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditEntryBloc>().state;
    final needsMonitoring = context.read<EditEntryBloc>().state.monitor;

    return TextFormField(
      key: const Key('editEntryView_title_textFormField'),
      initialValue: state.title,
      decoration: InputDecoration(
        errorText: !isValidTitleOrNotes(string: state.title!) && needsMonitoring
            ? 'Gimme a title! ...please.'
            : null,
        enabled: !state.status.isLoadingOrSuccess,
        labelText: 'Title',
        hintText: 'Concise recap',
      ),
      maxLength: 50,
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
      ],
      onChanged: (value) {
        context.read<EditEntryBloc>().add(EditEntryTitleChanged(value));
      },
    );
  }
}

class _NotesField extends StatelessWidget {
  const _NotesField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditEntryBloc>().state;
    final needsMonitoring = context.read<EditEntryBloc>().state.monitor;

    return TextFormField(
      key: const Key('editEntryView_notes_textFormField'),
      initialValue: state.notes,
      decoration: InputDecoration(
        errorText: !isValidTitleOrNotes(string: state.notes!) && needsMonitoring
            ? 'What are you going to reinforce?'
            : null,
        enabled: !state.status.isLoadingOrSuccess,
        labelText: 'Learning Entry',
        hintText: 'Hammer this into my brain, please!',
      ),
      maxLength: 300,
      maxLines: 7,
      inputFormatters: [
        LengthLimitingTextInputFormatter(300),
      ],
      onChanged: (value) {
        context.read<EditEntryBloc>().add(EditEntryNotesChanged(value));
      },
    );
  }
}

class _SourceField extends StatelessWidget {
  const _SourceField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditEntryBloc>().state;

    return TextFormField(
      key: const Key('editEntryView_source_textFormField'),
      initialValue: state.source,
      decoration: InputDecoration(
        enabled: !state.status.isLoadingOrSuccess,
        labelText: 'Source',
        hintText: "Cite the sage. Even if it's you!",
      ),
      maxLength: 100,
      inputFormatters: [
        LengthLimitingTextInputFormatter(100),
      ],
      onChanged: (value) {
        context.read<EditEntryBloc>().add(EditEntrySourceChanged(value));
      },
    );
  }
}

class _RelatedUrlField extends StatelessWidget {
  const _RelatedUrlField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditEntryBloc>().state;
    final needsMonitoring = context.read<EditEntryBloc>().state.monitor;

    return TextFormField(
      key: const Key('editEntryView_relatedUrl_textFormField'),
      initialValue: state.relatedUrl,
      decoration: InputDecoration(
        errorText: (!needsMonitoring || state.relatedUrl == null)
            ? null
            : !isValidURL(state.relatedUrl!)
                ? 'URL is not valid'
                : null,
        enabled: !state.status.isLoadingOrSuccess,
        labelText: 'RelatedUrl',
        hintText: 'To refresh later...',
      ),
      maxLength: 100,
      inputFormatters: [
        LengthLimitingTextInputFormatter(100),
      ],
      onChanged: (value) {
        context.read<EditEntryBloc>().add(EditEntryRelatedUrlChanged(value));
      },
    );
  }
}

class _FrequencyTypeField extends StatelessWidget {
  const _FrequencyTypeField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditEntryBloc>().state;

    return Row(
      key: const Key('editEntryView_frequencyType_radioField'),
      children: <Widget>[
        const Text('Periodically'),
        Radio(
          value: FrequencyType.periodically,
          groupValue: state.frequencyType,
          onChanged: (FrequencyType? value) {
            context.read<EditEntryBloc>().add(
                  EditEntryFrequencyTypeChanged(value!),
                );
          },
        ),
        const Text('Daily'),
        Radio(
          value: FrequencyType.daily,
          groupValue: state.frequencyType,
          onChanged: (FrequencyType? value) {
            context.read<EditEntryBloc>().add(
                  EditEntryFrequencyTypeChanged(value!),
                );
          },
        ),
      ],
    );
  }
}

class _FrequencyInDaysField extends StatelessWidget {
  const _FrequencyInDaysField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditEntryBloc>().state;
    final initialValue = state.frequencyInDays?.join(', ');
    final needsMonitoring = context.read<EditEntryBloc>().state.monitor;

    return TextFormField(
      key: const Key('editEntryView_frequencyInDays_textFormField'),
      initialValue: initialValue,
      decoration: InputDecoration(
        errorText: (needsMonitoring &&
                !isValidFrequencyInDays(
                  integers: state.frequencyInDays!,
                  frequencyType: state.frequencyType!,
                ))
            ? 'See information icon above for details'
            : null,
        enabled: !state.status.isLoadingOrSuccess,
        labelText: 'Frequency In days',
        hintText: 'Numbers and commas only',
      ),
      maxLength: 100,
      inputFormatters: [
        LengthLimitingTextInputFormatter(100),
        FilteringTextInputFormatter.allow(RegExp(r'[0-9,\s]')),
      ],
      onChanged: (value) {
        context
            .read<EditEntryBloc>()
            .add(EditEntryFrequencyInDaysChanged(value));
      },
    );
  }
}

class _EntryPriority extends StatelessWidget {
  const _EntryPriority({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditEntryBloc>().state;
    final initialValue = state.entryPriority;

    return DropdownButtonHideUnderline(
      key: const Key('editEntryView_entryPriority_dropDown'),
      child: DropdownButton<EntryPriority>(
        value: initialValue,
        items: <EntryPriority>[
          EntryPriority.highest,
          EntryPriority.high,
          EntryPriority.normal,
        ].map<DropdownMenuItem<EntryPriority>>((EntryPriority value) {
          return DropdownMenuItem<EntryPriority>(
            value: value,
            child: Text(
              describeEnum(value)[0].toUpperCase() +
                  describeEnum(value).substring(1),
            ),
          );
        }).toList(),
        onChanged: (value) {
          context
              .read<EditEntryBloc>()
              .add(EditEntryEntryPriorityChanged(value!));
        },
      ),
    );
  }
}

class _ActivationDateField extends StatelessWidget {
  const _ActivationDateField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditEntryBloc>().state;
    // TODO(Corey): Remove hh:mm before production
    final formatter = DateFormat('MMMM d yyyy hh:mm');
    final convertUtcToLocal = state.activationDate?.toLocal();
    final displayDate = formatter.format(convertUtcToLocal!);

    return TextFormField(
      enabled: false,
      key: const Key('editEntryView_activationDate_textFormField'),
      initialValue: displayDate,
      decoration: InputDecoration(
        enabled: !state.status.isLoadingOrSuccess,
        labelText: 'Date you began this learning repetition:',
      ),
    );
  }
}
