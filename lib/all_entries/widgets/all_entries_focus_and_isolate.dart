import 'dart:ui' as ui;

import 'package:entries_repository/entries_repository.dart';
import 'package:flutter/material.dart';

class FocusAndIsolate extends StatelessWidget {
  const FocusAndIsolate(Entry entry, Tween tween, {Key? key})
      : _entry = entry, _tween = tween,
        super(key: key);

  final Entry _entry;
  final Tween _tween;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TweenAnimationBuilder(
          tween: _tween,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInQuad,
          builder: (context, opacity, child) {
            return AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: opacity! as double,
              child: child,
            );
          },
          child: Opacity(
            opacity: .5,
            child: Container(
              color: Colors.black,
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * .1,
          height: MediaQuery.of(context).size.height * .8,
          left: MediaQuery.of(context).size.width * .1,
          width: MediaQuery.of(context).size.width * .8,
          child: BackdropFilter(
            filter: ui.ImageFilter.blur(
              sigmaX: 2,
              sigmaY: 2,
            ),
            child: Material(
              type: MaterialType.transparency,
              child: TweenAnimationBuilder(
                tween: _tween,
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOut,
                builder: (context, scale, child) {
                  return Transform.scale(
                    scale: scale! as double,
                    filterQuality: ui.FilterQuality.high,
                    child: child,
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Text(_entry.title),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(_entry.notes),
                        Text(_entry.learningStamps.toString()),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
