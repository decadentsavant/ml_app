import 'package:entries_repository/entries_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ml_app/edit_entry/edit_entry.dart';
import 'package:ml_app/theme/shared_ui_widgets/shared_ui_widgets.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isNewEntry ? 'Edit Entry' : 'Create Entry',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Entry',
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
      body: Stack(
        children: [
          const Background(),
          CupertinoScrollbar(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: const [_TitleField(), _NotesField(),],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TitleField extends StatelessWidget {
  const _TitleField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditEntryBloc>().state;
    final hintText = state.initialEntry?.title ?? '';

    return TextFormField(
      key: const Key('editEntryView_title_textFormField'),
      initialValue: state.title,
      decoration: InputDecoration(
        enabled:  !state.status.isLoadingOrSuccess,
        labelText: 'Title',
        hintText: hintText,
      ),
      maxLength: 50,
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]')),
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
    final hintText = state.initialEntry?.notes ?? '';

    return TextFormField(
      key: const Key('editEntryView_notes_textFormField'),
      initialValue: state.notes,
      decoration: InputDecoration(
        enabled: !state.status.isLoadingOrSuccess,
        labelText: 'Entry',
        hintText: hintText,
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
