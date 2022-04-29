import 'package:entries_repository/entries_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ml_app/todays_review/todays_review.dart';

class TodaysReviewListTile extends StatelessWidget {
  const TodaysReviewListTile({
    Key? key,
    required Entry entry,
    this.onTap,
    this.onLongPressStart,
    this.onLongPressEnd,
  })  : _entry = entry,
        super(key: key);

  final Entry _entry;
  final VoidCallback? onTap;
  final void Function(LongPressStartDetails)? onLongPressStart;
  final void Function(LongPressEndDetails)? onLongPressEnd;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: GestureDetector(
        onLongPressStart: onLongPressStart,
        onLongPressEnd: onLongPressEnd,
        child: Card(
          elevation: 4,
          child: Column(
            children: [
              ListTile(
                title: Text(_entry.title),
                subtitle:
                    (_entry.source == null || _entry.source!.trim().isEmpty)
                        ? const SizedBox()
                        : Text(_entry.source!),
                trailing: (_entry.relatedUrl == null ||
                        _entry.relatedUrl!.trim().isEmpty)
                    ? const SizedBox()
                    : Container(
                        padding: const EdgeInsets.only(right: 8),
                        child: Transform.rotate(
                          angle: -0.78539,
                          child: InkWell(
                            onTap: () => context.read<TodaysReviewBloc>().add(
                                  TodaysReviewUrlLaunchRequested(
                                    _entry.relatedUrl!,
                                  ),
                                ),
                            child: const Icon(Icons.link, size: 18),
                          ),
                        ),
                      ),
              ),
              Text(_entry.notes),
              TextButton(onPressed: onTap, child: const Text('...'))
            ],
          ),
        ),
      ),
    );
  }
}
