import 'package:flutter/material.dart';

class JsonViewer extends StatelessWidget {
  final Map<String, dynamic> jsonMap;
  final bool isNested;

  const JsonViewer({super.key, required this.jsonMap, this.isNested = false});

  String _formatKey(String key) {
    final formatted = key
        .replaceAllMapped(RegExp(r'([A-Z])'), (match) => ' ${match.group(1)}')
        .trim();
    return formatted[0].toUpperCase() + formatted.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: jsonMap.entries.map((entry) {
            final key = _formatKey(entry.key);
            final value = entry.value;
            if (!key.toLowerCase().contains("id")) {
              if (value is Map<String, dynamic>) {
                return ExpandableSection(
                  title: key,
                  child: JsonViewer(jsonMap: value, isNested: true),
                );
              } else if (value is List) {
                return ExpandableSection(
                  title: key,
                  child: Column(
                    children: value.map((item) {
                      if (item is Map<String, dynamic>) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            left: 8,
                            top: 4,
                            bottom: 4,
                          ),
                          child: JsonViewer(jsonMap: item, isNested: true),
                        );
                      }
                      return _KeyValueRow(label: '-', value: item.toString());
                    }).toList(),
                  ),
                );
              } else {
                return _KeyValueRow(label: key, value: value?.toString() ?? '');
              }
            } else {
              return Container();
            }
          }).toList(),
        ),

        Divider(thickness: 0.1),
      ],
    );
  }
}

class _KeyValueRow extends StatelessWidget {
  final String label;
  final String value;

  const _KeyValueRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              "$label:",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ExpandableSection extends StatefulWidget {
  final String title;
  final Widget child;

  const ExpandableSection({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  State<ExpandableSection> createState() => _ExpandableSectionState();
}

class _ExpandableSectionState extends State<ExpandableSection> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.grey.withValues(alpha: 0.05),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ExpansionTile(
        initiallyExpanded: false,
        tilePadding: const EdgeInsets.symmetric(horizontal: 8),
        iconColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
        children: [
          Padding(padding: const EdgeInsets.all(8.0), child: widget.child),
        ],
      ),
    );
  }
}
