import 'dart:convert';

import 'package:careme/data/model/phone.dart';

import 'address.dart';
import 'email.dart';

Customer customerFromJson(String str) => Customer.fromJson(json.decode(str));
String customerToJson(Customer data) => json.encode(data.toJson());

class Customer {
  Customer({List<Customers>? customers}) {
    _customers = customers;
  }

  Customer.fromJson(dynamic json) {
    if (json['customers'] != null) {
      _customers = [];
      json['customers'].forEach((v) {
        _customers?.add(Customers.fromJson(v));
      });
    }
  }
  List<Customers>? _customers;
  Customer copyWith({List<Customers>? customers}) =>
      Customer(customers: customers ?? _customers);
  List<Customers>? get customers => _customers;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_customers != null) {
      map['customers'] = _customers?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

Customers customersFromJson(String str) => Customers.fromJson(json.decode(str));
String customersToJson(Customers data) => json.encode(data.toJson());

class Customers {
  Customers({
    String? id,
    String? firstName,
    String? lastName,
    String? dateOfBirth,
    String? maritalStatus,
    String? secureId,
    List<Addresses>? addresses,
    List<Phones>? phones,
    List<Emails>? emails,
  }) {
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _dateOfBirth = dateOfBirth;
    _maritalStatus = maritalStatus;
    _secureId = secureId;
    _addresses = addresses;
    _phones = phones;
    _emails = emails;
  }

  Customers.fromJson(dynamic json) {
    _id = json['id'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _dateOfBirth = json['dateOfBirth'];
    _maritalStatus = json['maritalStatus'];
    _secureId = json['secureId'];
    if (json['addresses'] != null) {
      _addresses = [];
      json['addresses'].forEach((v) {
        _addresses?.add(Addresses.fromJson(v));
      });
    }
    if (json['phones'] != null) {
      _phones = [];
      json['phones'].forEach((v) {
        _phones?.add(Phones.fromJson(v));
      });
    }
    if (json['emails'] != null) {
      _emails = [];
      json['emails'].forEach((v) {
        _emails?.add(Emails.fromJson(v));
      });
    }
  }
  String? _id;
  String? _firstName;
  String? _lastName;
  String? _dateOfBirth;
  String? _maritalStatus;
  String? _secureId;
  List<Addresses>? _addresses;
  List<Phones>? _phones;
  List<Emails>? _emails;
  Customers copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? dateOfBirth,
    String? maritalStatus,
    String? secureId,
    List<Addresses>? addresses,
    List<Phones>? phones,
    List<Emails>? emails,
  }) => Customers(
    id: id ?? _id,
    firstName: firstName ?? _firstName,
    lastName: lastName ?? _lastName,
    dateOfBirth: dateOfBirth ?? _dateOfBirth,
    maritalStatus: maritalStatus ?? _maritalStatus,
    secureId: secureId ?? _secureId,
    addresses: addresses ?? _addresses,
    phones: phones ?? _phones,
    emails: emails ?? _emails,
  );
  String? get id => _id;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get dateOfBirth => _dateOfBirth;
  String? get maritalStatus => _maritalStatus;
  String? get secureId => _secureId;
  List<Addresses>? get addresses => _addresses;
  List<Phones>? get phones => _phones;
  List<Emails>? get emails => _emails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    map['dateOfBirth'] = _dateOfBirth;
    map['maritalStatus'] = _maritalStatus;
    map['secureId'] = _secureId;
    if (_addresses != null) {
      map['addresses'] = _addresses?.map((v) => v.toJson()).toList();
    }
    if (_phones != null) {
      map['phones'] = _phones?.map((v) => v.toJson()).toList();
    }
    if (_emails != null) {
      map['emails'] = _emails?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
