// To parse this JSON data, do
//
//     final mongoDbFineCalculationModel = mongoDbFineCalculationModelFromJson(jsonString);

import 'dart:convert';

MongoDbFineCalculationModel? mongoDbFineCalculationModelFromJson(String str) =>
    MongoDbFineCalculationModel.fromJson(json.decode(str));

String mongoDbFineCalculationModelToJson(MongoDbFineCalculationModel? data) =>
    json.encode(data!.toJson());

class MongoDbFineCalculationModel {
  MongoDbFineCalculationModel({
    this.name,
    this.regId,
    this.fine,
  });

  String? name;
  String? fine;
  String? regId;

  factory MongoDbFineCalculationModel.fromJson(Map<String, dynamic> json) =>
      MongoDbFineCalculationModel(
        name: json["name"],
        fine: json["fine"],
        regId: json["regId"]
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "fine": fine,
        "regId": regId
      };
}
