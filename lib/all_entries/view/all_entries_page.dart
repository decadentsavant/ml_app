import 'package:entries_repository/entries_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ml_app/all_entries/all_entries.dart';
import 'package:ml_app/edit_entry/edit_entry.dart';

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
                      content: Text('Error on BlocListener[allEntriesView]'),
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
                      '${deletedEntry.title} entry deleted',
                    ),
                    action: SnackBarAction(
                      label: 'Undo Deletion',
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
          ),
        ],
        child: BlocBuilder<AllEntriesBloc, AllEntriesState>(
          builder: (context, state) {
            if (state.entries.isEmpty) {
              if (state.status == AllEntriesStatus.loading) {
                return const Center(child: CupertinoActivityIndicator());
              } else if (state.status != AllEntriesStatus.success) {
                return const SizedBox();
              } else {
                return Center(
                  child: Text(
                    'You have no entries. Make some! Prettify this page.',
                    // TODO(Corey): Likely a message for new people.
                    // Link to a video on your website
                    style: Theme.of(context).textTheme.caption,
                  ),
                );
              }
            }

            return CupertinoScrollbar(
              child: ListView(
                controller: ScrollController(),
                children: [
                  AppBar(
                    title: const Text('All Entries'),
                    actions: const [],
                  ),
                  const AllEntriesSearch(),
                  for (final entry in state.queriedEntries)
                    AllEntriesListTile(
                      entry: entry,
                      onToggleIsActive: (isIsActive) {
                        context.read<AllEntriesBloc>().add(
                              AllEntriesIsActiveToggled(
                                entry: entry,
                                isActive: isIsActive,
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
      ),
    );
  }
}
