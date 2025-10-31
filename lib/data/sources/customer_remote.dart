import 'package:careme/data/model/customer.dart';
import 'package:dio/dio.dart';

import '../../core/constants/api_endpoints.dart';
import '../../core/network/dio_client.dart';

class AuthRemote {
  final DioClient dioClient;
  AuthRemote(this.dioClient);

  Future<List<Customers>> getCustomers() async {
    try {
      final response = await dioClient.dio.get(ApiEndpoints.customer);
      var customers = response.data;
      List<Customers> customerList = [];
      if (customers != null && customers.isNotEmpty) {
        for (var data in customers) {
          customerList.add(Customers.fromJson(data));
        }
      }
      return customerList;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<Customers> getCustomerById(String id) async {
    try {
      final response = await dioClient.dio.get("${ApiEndpoints.customer}/$id");
      var customers = response.data;
      Customers customer = Customers.fromJson(customers);

      return customer;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }
}
