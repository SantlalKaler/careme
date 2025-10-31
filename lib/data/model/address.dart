import 'dart:convert';

Addresses addressesFromJson(String str) => Addresses.fromJson(json.decode(str));
String addressesToJson(Addresses data) => json.encode(data.toJson());

class Addresses {
  Addresses({
    String? id,
    String? type,
    String? street,
    String? city,
    String? state,
    String? zipCode,
  }) {
    _id = id;
    _type = type;
    _street = street;
    _city = city;
    _state = state;
    _zipCode = zipCode;
  }

  Addresses.fromJson(dynamic json) {
    _id = json['id'];
    _type = json['type'];
    _street = json['street'];
    _city = json['city'];
    _state = json['state'];
    _zipCode = json['zipCode'];
  }
  String? _id;
  String? _type;
  String? _street;
  String? _city;
  String? _state;
  String? _zipCode;
  Addresses copyWith({
    String? id,
    String? type,
    String? street,
    String? city,
    String? state,
    String? zipCode,
  }) => Addresses(
    id: id ?? _id,
    type: type ?? _type,
    street: street ?? _street,
    city: city ?? _city,
    state: state ?? _state,
    zipCode: zipCode ?? _zipCode,
  );
  String? get id => _id;
  String? get type => _type;
  String? get street => _street;
  String? get city => _city;
  String? get state => _state;
  String? get zipCode => _zipCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['type'] = _type;
    map['street'] = _street;
    map['city'] = _city;
    map['state'] = _state;
    map['zipCode'] = _zipCode;
    return map;
  }
}
