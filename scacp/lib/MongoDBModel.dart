import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

Welcome? welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome? data) => json.encode(data!.toJson());

class Welcome {
  Welcome({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.address,
  });

  ObjectId id;
  String? firstName;
  String? lastName;
  String? address;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "address": address,
      };
}
