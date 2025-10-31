import 'dart:convert';

Emails emailsFromJson(String str) => Emails.fromJson(json.decode(str));
String emailsToJson(Emails data) => json.encode(data.toJson());

class Emails {
  Emails({String? id, String? type, String? address, bool? isPrimary}) {
    _id = id;
    _type = type;
    _address = address;
    _isPrimary = isPrimary;
  }

  Emails.fromJson(dynamic json) {
    _id = json['id'];
    _type = json['type'];
    _address = json['address'];
    _isPrimary = json['isPrimary'];
  }
  String? _id;
  String? _type;
  String? _address;
  bool? _isPrimary;
  Emails copyWith({
    String? id,
    String? type,
    String? address,
    bool? isPrimary,
  }) => Emails(
    id: id ?? _id,
    type: type ?? _type,
    address: address ?? _address,
    isPrimary: isPrimary ?? _isPrimary,
  );
  String? get id => _id;
  String? get type => _type;
  String? get address => _address;
  bool? get isPrimary => _isPrimary;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['type'] = _type;
    map['address'] = _address;
    map['isPrimary'] = _isPrimary;
    return map;
  }
}
