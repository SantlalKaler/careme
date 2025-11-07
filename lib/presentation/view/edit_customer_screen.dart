import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class EditCustomerScreen extends StatefulWidget {
  final Map<String, dynamic> customerData;

  const EditCustomerScreen({super.key, required this.customerData});

  @override
  State<EditCustomerScreen> createState() => _EditCustomerScreenState();
}

class _EditCustomerScreenState extends State<EditCustomerScreen> {
  late Map<String, dynamic> editableData;

  @override
  void initState() {
    super.initState();
    editableData = Map<String, dynamic>.from(widget.customerData);
  }

  String _formatKey(String key) {
    final formatted = key
        .replaceAllMapped(RegExp(r'([A-Z])'), (m) => ' ${m.group(1)}')
        .trim();
    return formatted[0].toUpperCase() + formatted.substring(1);
  }

  Widget _buildFields(Map<String, dynamic> data, {String? parentKey}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: data.entries.map((entry) {
        final key = entry.key;
        final value = entry.value;

        if (key.toLowerCase().contains("id")) return const SizedBox.shrink();

        final fullKey = parentKey != null ? "$parentKey.$key" : key;

        if (value is Map<String, dynamic>) {
          return ExpansionTile(
            title: Text(
              _formatKey(key),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            children: [_buildFields(value, parentKey: fullKey)],
          );
        } else if (value is List) {
          return ExpansionTile(
            title: Text(
              _formatKey(key),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            children: value.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;

              if (item is Map<String, dynamic>) {
                return Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: _buildFields(item, parentKey: "$fullKey[$index]"),
                );
              }
              return _buildTextField(
                label: "$key[$index]",
                initialValue: item.toString(),
                onChanged: (val) =>
                    _updateNestedValue(fullKey, val, index: index),
              );
            }).toList(),
          );
        } else if (_isDate(value.toString())) {
          return _buildDateField(fullKey, _formatKey(key), value.toString());
        } else {
          return _buildTextField(
            label: _formatKey(key),
            initialValue: value?.toString() ?? '',
            onChanged: (val) => _updateNestedValue(fullKey, val),
          );
        }
      }).toList(),
    );
  }

  bool _isDate(String value) {
    final dateRegExp = RegExp(r'^\d{4}-\d{2}-\d{2}$');
    return dateRegExp.hasMatch(value);
  }

  void _updateNestedValue(String key, dynamic newValue, {int? index}) {
    List<String> path = key.split('.');
    dynamic current = editableData;

    for (int i = 0; i < path.length; i++) {
      String segment = path[i];
      final listMatch = RegExp(r'(\w+)\[(\d+)\]').firstMatch(segment);
      if (listMatch != null) {
        final listKey = listMatch.group(1)!;
        final listIndex = int.parse(listMatch.group(2)!);

        if (i == path.length - 1) {
          current[listKey][listIndex] = newValue;
        } else {
          current = current[listKey][listIndex];
        }
      } else {
        if (i == path.length - 1) {
          current[segment] = newValue;
        } else {
          current = current[segment];
        }
      }
    }

    setState(() {});
  }

  Widget _buildTextField({
    required String label,
    required String initialValue,
    required ValueChanged<String> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: TextField(
        controller: TextEditingController(text: initialValue)
          ..selection = TextSelection.fromPosition(
            TextPosition(offset: initialValue.length),
          ),
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildDateField(String key, String label, String value) {
    return GestureDetector(
      onTap: () async {
        final currentDate = DateTime.tryParse(value) ?? DateTime.now();
        final picked = await showDatePicker(
          context: context,
          initialDate: currentDate,
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );

        if (picked != null) {
          final formatted = DateFormat('yyyy-MM-dd').format(picked);
          _updateNestedValue(key, formatted);
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(value, style: const TextStyle(fontSize: 15)),
            const Icon(Icons.calendar_today, size: 18),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(CupertinoIcons.back),
        ),
        title: Text(
          "Edit Customer",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: _buildFields(editableData),
      ),
    );
  }
}
