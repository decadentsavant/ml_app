import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ml_app/all_entries/all_entries.dart';

class AllEntriesSearch extends StatelessWidget {
  const AllEntriesSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AllEntriesBloc>().state;

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: TextFormField(
        key: const Key('allEntriesView_query_textFormField'),
        initialValue: state.query,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          enabled: state.status.isSuccess,
          hintText: 'search',
          counter: const Offstage(),
        ),
        maxLength: 100,
        onChanged: (value) {
          context.read<AllEntriesBloc>().add(AllEntriesQueryChanged(value));
        },
      ),
    );
  }
}
