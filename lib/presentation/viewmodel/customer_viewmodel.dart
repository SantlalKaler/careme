import 'package:flutter_riverpod/legacy.dart';

import '../../core/network/dio_client.dart';
import '../../data/model/customer.dart';
import '../../data/model/field_config.dart';
import '../../data/repositories/customer_repository.dart';
import '../../data/sources/customer_remote.dart';
import '../model/customer_state.dart';

final selectedFieldProvider = StateProvider<String?>((ref) => null);
final searchValuesProvider = StateProvider<Map<String, dynamic>>((ref) => {});

final customerViewModelProvider =
    StateNotifierProvider<AuthViewModel, CustomerState>((ref) {
      final authRepo = AuthRepository(AuthRemote(ref.watch(dioClientProvider)));
      return AuthViewModel(authRepo);
    });

class AuthViewModel extends StateNotifier<CustomerState> {
  final AuthRepository authRepo;

  AuthViewModel(this.authRepo) : super(CustomerState.initial());

  Future<void> getCustomers() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await Future.delayed(const Duration(seconds: 2));
      final customers = await authRepo.getCustomers();
      state = state.copyWith(isLoading: false, customers: customers);
      print("REs is 1: ${state.customers?.length}");
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> getCustomerById(String id) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await Future.delayed(const Duration(seconds: 2));
      final customer = await authRepo.getCustomerById(id);
      state = state.copyWith(isLoading: false, customer: customer);
      print("REs is 1: ${state.customers?.length}");
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void filterCustomers(
    Map<String, dynamic> filters,
    Map<String, FieldConfig> config,
  ) {
    final allCustomers = state.customers ?? [];
    if (allCustomers.isEmpty) return;

    final filtered = allCustomers.where((customer) {
      for (final entry in filters.entries) {
        final key = entry.key;
        final filterValue = entry.value?.toString().toLowerCase() ?? '';
        if (filterValue.isEmpty) continue;

        final customerValue =
            _getFieldValue(customer, key)?.toString().toLowerCase() ?? '';

        final fieldType = config[key]?.type ?? 'text';
        final isMatch = fieldType == 'text'
            ? customerValue.contains(filterValue)
            : customerValue == filterValue;

        if (!isMatch) return false;
      }
      return true;
    }).toList();

    state = state.copyWith(filteredCustomers: filtered);
  }

  dynamic _getFieldValue(Customers customer, String key) {
    final map = customer.toJson();

    if (key.contains('.')) {
      final parts = key.split('.');
      dynamic value = map;
      for (final part in parts) {
        if (value is Map<String, dynamic>) {
          value = value[part];
        } else if (value is List && value.isNotEmpty) {
          value = value.first[part];
        } else {
          return null;
        }
      }
      return value;
    }
    return map[key];
  }
}
