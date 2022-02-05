import 'package:entries_repository/entries_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ml_app/all_entries/all_entries.dart';
import 'package:ml_app/all_entries/widgets/all_entries_list_tile.dart';
import 'package:ml_app/edit_entry/edit_entry.dart';
import 'package:ml_app/theme/shared_ui_widgets/shared_ui_widgets.dart';

class AllEntriesPage extends StatelessWidget {
  const AllEntriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AllEntriesBloc(
        entriesRepository: context.read<EntriesRepository>(),
      )..add(const AllEntriesSubscriptionRequested()),
      child: const AllEntriesView(),
    );
  }
}

class AllEntriesView extends StatelessWidget {
  const AllEntriesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Entries'),
        actions: const [
          AllEntriesFilterButton(),
          // TODO(Corey): Add a search icon/ implement functionality
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<AllEntriesBloc, AllEntriesState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status == AllEntriesStatus.failure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                      content: Text('AllEntriesStatus.failure'),
                    ),
                  );
              }
            },
          ),
          BlocListener<AllEntriesBloc, AllEntriesState>(
            listenWhen: (previous, current) =>
                previous.lastDeletedEntry != current.lastDeletedEntry &&
                current.lastDeletedEntry != null,
            listener: (context, state) {
              final deletedEntry = state.lastDeletedEntry!;
              final messenger = ScaffoldMessenger.of(context);
              messenger
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(
                      '$deletedEntry Deleted',
                    ),
                    action: SnackBarAction(
                      label: 'Undo Delete',
                      onPressed: () {
                        messenger.hideCurrentSnackBar();
                        context
                            .read<AllEntriesBloc>()
                            .add(const AllEntriesUndoDeletionRequested());
                      },
                    ),
                  ),
                );
            },
          )
        ],
        child: Stack(
          children: [
            const Background(),
            BlocBuilder<AllEntriesBloc, AllEntriesState>(
              builder: (context, state) {
                if (state.entries.isEmpty) {
                  if (state.status == AllEntriesStatus.loading) {
                    return const Center(child: CupertinoActivityIndicator());
                  } else if (state.status != AllEntriesStatus.success) {
                    return const SizedBox();
                  } else {
                    return const Center(
                      child: Text('The Entries are empty'),
                    );
                  }
                }

                return CupertinoScrollbar(
                  child: ListView(
                    children: [
                      for (final entry in state.filteredEntries)
                        AllEntriesListTile(
                          entry: entry,
                          onToggleIsActive: (isActive) {
                            context.read<AllEntriesBloc>().add(
                                  AllEntriesEntryIsActiveToggled(
                                    entry: entry,
                                    isActive: isActive,
                                  ),
                                );
                          },
                          onDismissed: (_) {
                            context
                              .read<AllEntriesBloc>()
                              .add(AllEntriesEntryDeleted(entry));
                          },
                          onTap: () {
                            Navigator.of(context).push(
                              EditEntryPage.route(initialEntry: entry),
                            );
                          },
                        ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
