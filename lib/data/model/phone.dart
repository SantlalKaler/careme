import 'dart:convert';

Phones phonesFromJson(String str) => Phones.fromJson(json.decode(str));
String phonesToJson(Phones data) => json.encode(data.toJson());

class Phones {
  Phones({String? id, String? type, String? number, bool? isPrimary}) {
    _id = id;
    _type = type;
    _number = number;
    _isPrimary = isPrimary;
  }

  Phones.fromJson(dynamic json) {
    _id = json['id'];
    _type = json['type'];
    _number = json['number'];
    _isPrimary = json['isPrimary'];
  }
  String? _id;
  String? _type;
  String? _number;
  bool? _isPrimary;
  Phones copyWith({
    String? id,
    String? type,
    String? number,
    bool? isPrimary,
  }) => Phones(
    id: id ?? _id,
    type: type ?? _type,
    number: number ?? _number,
    isPrimary: isPrimary ?? _isPrimary,
  );
  String? get id => _id;
  String? get type => _type;
  String? get number => _number;
  bool? get isPrimary => _isPrimary;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['type'] = _type;
    map['number'] = _number;
    map['isPrimary'] = _isPrimary;
    return map;
  }
}
