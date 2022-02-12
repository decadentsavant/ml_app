import 'package:entries_repository/entries_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ml_app/todays_review/todays_review.dart';

class TodaysReviewListTile extends StatelessWidget {
  const TodaysReviewListTile({
    Key? key,
    required this.entry,
    this.onTap,
  }) : super(key: key);

  final Entry entry;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final _entryTitle = entry.title;
    final _entrySource = entry.source;
    final _entryNotes = entry.notes;
    final _entryUrl = entry.relatedUrl;

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Card(
        elevation: 4,
        child: Column(
          children: [
            ListTile(
              title: Text(_entryTitle),
              subtitle: (_entrySource == null || _entrySource.trim().isEmpty)
                  ? const SizedBox()
                  : Text(_entrySource),
              trailing: (_entryUrl == null || _entryUrl.trim().isEmpty)
                  ? const SizedBox()
                  : Container(
                      padding: const EdgeInsets.only(right: 8),
                      child: Transform.rotate(
                        angle: -0.78539,
                        child: InkWell(
                          onTap: () => context
                              .read<TodaysReviewBloc>()
                              .add(TodaysReviewUrlLaunchRequested(_entryUrl)),
                          child: const Icon(Icons.link, size: 18),
                        ),
                      ),
                    ),
            ),
            Text(_entryNotes),
            TextButton(onPressed: onTap, child: const Text('...'))
          ],
        ),
      ),
    );
  }
}
