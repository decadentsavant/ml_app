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
    final captionColor = theme.textTheme.caption?.color;

    return Dismissible(
      key: Key('allEntriesListTile_dismissible_${entry.id}'),
      onDismissed: onDismissed,
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        color: theme.colorScheme.error,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: const Icon(
          Icons.delete,
          color: Color(0xAAFFFFFF),
        ),
      ),
      child: ListTile(
        onTap: onTap,
        title: Text(
          entry.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: entry.isActive
            ? null
            : TextStyle(
              color: captionColor,
              decoration: TextDecoration.lineThrough,
            ),
        ),
        subtitle: Text(
          entry.isActive.toString(),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        ),
    )    ;
  }
}
