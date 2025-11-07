import 'package:careme/core/widget/app_loader.dart';
import 'package:careme/presentation/viewmodel/customer_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/config/search_config.dart';
import '../../core/constants/route_names.dart';
import '../../core/widget/app_error.dart';
import '../../core/widget/icon_with_data.dart';
import '../../core/widget/json_viewer.dart';
import '../../data/model/field_config.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(customerViewModelProvider.notifier).getCustomers();
    });
  }

  final sortedFields = searchConfig.entries.toList()
    ..sort((a, b) => a.value.renderOrder.compareTo(b.value.renderOrder));
  TextEditingController searchController = TextEditingController();

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
        title: Text("Search", style: Theme.of(context).textTheme.titleMedium),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          var state = ref.watch(customerViewModelProvider);
          var customers = state.filteredCustomers ?? state.customers ?? [];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          labelText: "Search",
                          hintText: "Search",
                          border: const OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          ref
                              .read(customerViewModelProvider.notifier)
                              .filterCustomersGlobally(value);
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        searchController.clear();
                        ref
                            .read(customerViewModelProvider.notifier)
                            .clearFilters();
                      },
                      icon: Icon(
                        Icons.filter_alt_off_sharp,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    /* TextButton(
              onPressed: () {
                resetData(ref);

                ref
                    .read(selectedFieldProvider.notifier)
                    .update((state) => null);
              },
              child: Text("Clear Filter"),
            ),*/
                  ],
                ),
                Gap(16),
                state.isLoading
                    ? Center(child: AppLoader())
                    : customers.isEmpty || state.error != null
                    ? Center(child: AppError())
                    : Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            ref
                                .read(searchValuesProvider.notifier)
                                .update((state) => {});
                            ref
                                .read(customerViewModelProvider.notifier)
                                .filterCustomers(
                                  {},
                                  ref.read(searchConfigProvider),
                                );
                            await ref
                                .read(customerViewModelProvider.notifier)
                                .getCustomers();
                          },
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: customers.length,
                            itemBuilder: (context, index) {
                              var customer = customers[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: GestureDetector(
                                  onTap: () {
                                    final Map<String, String> extra = {
                                      "title":
                                          "${customer.firstName} ${customer.lastName}",
                                      "id": customer.id!,
                                    };
                                    context.push(
                                      RouteNames.details,
                                      extra: extra,
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsetsGeometry.all(16),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadiusGeometry.circular(5),
                                      color: Colors.grey.withValues(alpha: 0.1),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,

                                          children: [
                                            Expanded(
                                              child: Text(
                                                "${customer.firstName} ${customer.lastName}",
                                                style: Theme.of(
                                                  context,
                                                ).textTheme.titleMedium,
                                              ),
                                            ),
                                            Gap(10),
                                            Text(
                                              "DOB: ${customer.dateOfBirth}",
                                              style: Theme.of(
                                                context,
                                              ).textTheme.labelSmall,
                                            ),
                                          ],
                                        ),
                                        Gap(10),
                                        IconWithData(
                                          icon: CupertinoIcons.mail,
                                          data:
                                              customer.emails
                                                  ?.firstWhere(
                                                    (email) =>
                                                        email.isPrimary ??
                                                        false,
                                                    orElse: () =>
                                                        customer.emails!.first,
                                                  )
                                                  .address ??
                                              "",
                                        ),
                                        Gap(5),
                                        IconWithData(
                                          icon: CupertinoIcons.phone,
                                          data:
                                              customer.phones
                                                  ?.firstWhere(
                                                    (phone) =>
                                                        phone.isPrimary ??
                                                        false,
                                                    orElse: () =>
                                                        customer.phones!.first,
                                                  )
                                                  .number ??
                                              "",
                                        ),
                                        ExpandableSection(
                                          title: "More Details",
                                          child: JsonViewer(
                                            jsonMap: customer.toJson(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class SearchForm extends ConsumerWidget {
  SearchForm({super.key});

  resetData(WidgetRef ref) {
    ref.read(customerViewModelProvider.notifier).filterCustomers({}, {});

    ref.read(searchValuesProvider.notifier).update((state) => {});
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedField = ref.watch(selectedFieldProvider);
    final config = ref.watch(searchConfigProvider);
    final selectedFieldNotifier = ref.read(selectedFieldProvider.notifier);

    final sortedFields = config.entries.toList()
      ..sort((a, b) => a.value.renderOrder.compareTo(b.value.renderOrder));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Search",
                  hintText: "Search",
                  border: const OutlineInputBorder(),
                ),
                onChanged: (value) {
                  ref
                      .read(customerViewModelProvider.notifier)
                      .filterCustomersGlobally(value);
                },
              ),
            ),
            IconButton(
              onPressed: () {
                ref.read(customerViewModelProvider.notifier).clearFilters();
              },
              icon: Icon(
                Icons.filter_alt_off_sharp,
                color: Theme.of(context).primaryColor,
              ),
            ),
            /* TextButton(
              onPressed: () {
                resetData(ref);

                ref
                    .read(selectedFieldProvider.notifier)
                    .update((state) => null);
              },
              child: Text("Clear Filter"),
            ),*/
          ],
        ),
        /* SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: sortedFields.map((entry) {
              final isSelected = entry.key == selectedField;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: ChoiceChip(
                  showCheckmark: false,
                  label: Text(
                    entry.value.label,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: isSelected ? Colors.white : Colors.black45,
                    ),
                  ),
                  selected: isSelected,
                  onSelected: (_) {
                    selectedFieldNotifier.state = isSelected ? null : entry.key;
                    resetData(ref);
                  },
                ),
              );
            }).toList(),
          ),
        ),

        const SizedBox(height: 16),
        if (selectedField != null)
          _buildFieldInput(ref, selectedField, searchConfig[selectedField]!),*/
      ],
    );
  }

  Widget _buildFieldInput(WidgetRef ref, String fieldKey, FieldConfig field) {
    final values = ref.watch(searchValuesProvider);
    final currentValue = values[fieldKey];
    switch (field.type) {
      case 'text':
        return TextField(
          decoration: InputDecoration(
            labelText: field.label,
            hintText: field.placeholder,
            border: const OutlineInputBorder(),
          ),
          onChanged: (value) {
            ref
                .read(searchValuesProvider.notifier)
                .update((state) => {...state, fieldKey: value});

            final filters = ref.read(searchValuesProvider);
            final config = ref.read(searchConfigProvider);
            ref
                .read(customerViewModelProvider.notifier)
                .filterCustomers(filters, config);
          },
        );

      case 'date':
        return GestureDetector(
          onTap: () async {
            final pickedDate = await showDatePicker(
              context: ref.context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );

            if (pickedDate != null) {
              final formatter = DateFormat('yyyy-MM-dd');
              var formatted = formatter.format(pickedDate);
              ref
                  .read(searchValuesProvider.notifier)
                  .update((state) => {...state, fieldKey: formatted});

              final filters = ref.read(searchValuesProvider);
              final config = ref.read(searchConfigProvider);
              ref
                  .read(customerViewModelProvider.notifier)
                  .filterCustomers(filters, config);
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  currentValue ?? 'Select ${field.label}',
                  style: TextStyle(
                    color: currentValue == null
                        ? Colors.grey.shade600
                        : Colors.black,
                  ),
                ),
                const Icon(Icons.calendar_today, size: 18),
              ],
            ),
          ),
        );

      default:
        return const SizedBox.shrink();
    }
  }
}
