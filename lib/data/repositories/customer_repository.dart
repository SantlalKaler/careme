import '../model/customer.dart';
import '../sources/customer_remote.dart';

class AuthRepository {
  final AuthRemote remote;
  AuthRepository(this.remote);

  Future<List<Customers>> getCustomers() => remote.getCustomers();
  Future<Customers> getCustomerById(String id) => remote.getCustomerById(id);
}
