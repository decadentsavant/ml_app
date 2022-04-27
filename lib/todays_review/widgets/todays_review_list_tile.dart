import 'dart:ui' as ui;

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
    final _overlayState = Overlay.of(context);
    final _overlayEntry = FocusAndIsolate(_entryTitle, _entryNotes);

    return Padding(
      padding: const EdgeInsets.all(12),
      child: GestureDetector(
        onLongPressStart: (_) {
          _overlayState?.insert(_overlayEntry);
          // context
          //     .read<TodaysReviewBloc>()
          //     .add(TodaysReviewFocusedLearningStart(entry));
        },
        onLongPressEnd: (_) {
            _overlayEntry.remove();
        },
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
      ),
    );
  }
}

class FocusAndIsolate extends OverlayEntry {
  FocusAndIsolate(
    String title,
    String notes,
  ) : super(
          maintainState: true,
          builder: (context) {
            final mediaQuery = MediaQuery.of(context);
            return Stack(
              children: [
                Opacity(
                  opacity: .5,
                  child: Container(
                    color: Colors.black,
                  ),
                ),
                Positioned(
                  top: mediaQuery.size.height * .1,
                  height: mediaQuery.size.height * .8,
                  left: mediaQuery.size.width * .1,
                  width: mediaQuery.size.width * .8,
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(
                      sigmaX: 2,
                      sigmaY: 2,
                    ),
                    child: Material(
                      type: MaterialType.transparency,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Text(title),
                              const SizedBox(
                                height: 12,
                              ),
                              Text(notes),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
}
