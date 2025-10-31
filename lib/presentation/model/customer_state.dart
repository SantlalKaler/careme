import 'package:careme/data/model/customer.dart';

class CustomerState {
  final bool isLoading;
  final String? error;
  final List<Customers>? customers;
  final List<Customers>? filteredCustomers;
  final Customers? customer;

  const CustomerState({
    required this.isLoading,
    this.error,
    this.customers,
    this.filteredCustomers,
    this.customer,
  });

  factory CustomerState.initial() => const CustomerState(isLoading: false);

  CustomerState copyWith({
    bool? isLoading,
    String? error,
    List<Customers>? customers,
    List<Customers>? filteredCustomers,
    Customers? customer,
    bool clearError = false,
    bool clearCustomer = false,
    bool clearFilterCustomer = false,
    bool clearCustomers = false,
  }) {
    return CustomerState(
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      customers: clearCustomers ? null : (customers ?? this.customers),
      filteredCustomers: clearFilterCustomer
          ? null
          : (filteredCustomers ?? this.filteredCustomers),
      customer: clearCustomer ? null : (customer ?? this.customer),
    );
  }
}
