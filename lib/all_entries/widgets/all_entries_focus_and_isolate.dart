import 'dart:ui' as ui;

import 'package:entries_repository/entries_repository.dart';
import 'package:flutter/material.dart';

class FocusAndIsolate extends StatelessWidget {
  FocusAndIsolate(Entry entry, {Key? key}) : _entry = entry, super(key: key);

  Entry _entry;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: .5,
          child: Container(
            color: Colors.black,
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
              child: Card(
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
      ],
    );
  }
}
