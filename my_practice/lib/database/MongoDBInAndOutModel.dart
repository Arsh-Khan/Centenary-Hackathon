// To parse this JSON data, do
//
//     final mongoDbInandOutModel = mongoDbInandOutModelFromJson(jsonString);

import 'dart:convert';

MongoDbInandOutModel? mongoDbInandOutModelFromJson(String str) =>
    MongoDbInandOutModel.fromJson(json.decode(str));

String mongoDbInandOutModelToJson(MongoDbInandOutModel? data) =>
    json.encode(data!.toJson());

class MongoDbInandOutModel {
  MongoDbInandOutModel({
    this.name,
    this.regId,
    this.inTime,
    this.outTime,
  });

  String? name;
  String? regId;
  String? inTime;
  String? outTime;

  factory MongoDbInandOutModel.fromJson(Map<String, dynamic> json) =>
      MongoDbInandOutModel(
        name: json["name"],
        regId: json["regId"],
        inTime: json["inTime"],
        outTime: json["outTime"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "regId": regId,
        "inTime": inTime,
        "outTime": outTime,
      };
}
