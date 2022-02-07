import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ml_app/all_entries/all_entries.dart';

class AllEntriesFilterButton extends StatelessWidget {
  const AllEntriesFilterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final activeFilter =
        context.select((AllEntriesBloc bloc) => bloc.state.filter);

    return PopupMenuButton<AllEntriesViewFilter>(
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      initialValue: activeFilter,
      tooltip: 'Choose a filter',
      onSelected: (filter) {
        context.read<AllEntriesBloc>().add(AllEntriesFilterChanged(filter));
      },
      itemBuilder: (context) {
        return [
          const PopupMenuItem(
            value: AllEntriesViewFilter.all,
            child: Text('All entries'),
          ),
          const PopupMenuItem(
            value: AllEntriesViewFilter.activeOnly,
            child: Text('Active entries only'),
          ),
          const PopupMenuItem(
            value: AllEntriesViewFilter.archiveOnly,
            child: Text('Archived entries only'),
          ),
        ];
      },
      icon: const Icon(Icons.filter_list_outlined),
    );
  }
}
