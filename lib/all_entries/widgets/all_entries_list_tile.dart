import 'package:entries_repository/entries_repository.dart';
import 'package:flutter/material.dart';

class AllEntriesListTile extends StatelessWidget {
  const AllEntriesListTile({
    Key? key,
    required this.entry,
    this.onToggleIsActive,
    this.onDismissed,
    this.onTap,
  }) : super(key: key);

  final Entry entry;
  final ValueChanged<bool>? onToggleIsActive;
  final DismissDirectionCallback? onDismissed;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dismissible(
      key: UniqueKey(),
      onDismissed: onDismissed,
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        color: theme.colorScheme.error,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: const Icon(
          Icons.delete,
        ),
      ),
      child: ListTile(
        onTap: onTap,
        tileColor: entry.isActive
            ? null
            : Theme.of(context).colorScheme.error.withOpacity(.25),
        title: (entry.source == null || entry.source == '')
            ? Text(
                entry.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            : Text(
                '${entry.title} - ${entry.source}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
        subtitle: Text(
          entry.notes,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
