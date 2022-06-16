import 'dart:convert';

Contact contactFromJson(String str) => Contact.fromJson(json.decode(str));
String contactToJson(Contact data) => jsonEncode(data.toJson());

class Contact {
  late String id;
  late String name;
  late String phoneNumber;

  Contact({
    required this.id,
    required this.name,
    required this.phoneNumber
  });

  Contact.fromJson(Map<String, dynamic> json) :
    id = json['id'],
    name = json['name'],
    phoneNumber = json['phoneNumber'];


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['phoneNumber'] = phoneNumber;
    return map;
  }
}