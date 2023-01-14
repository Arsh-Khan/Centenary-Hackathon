// To parse this JSON data, do
//
//     final mongoDbStudentModel = mongoDbStudentModelFromJson(jsonString);

import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

MongoDbStudentModel? mongoDbStudentModelFromJson(String str) => MongoDbStudentModel.fromJson(json.decode(str));

String mongoDbStudentModelToJson(MongoDbStudentModel? data) => json.encode(data!.toJson());

class MongoDbStudentModel {
    MongoDbStudentModel({
        required this.id,
        required this.name,
        required this.regId,
        required this.vjtiEmailId,
        required this.fine,
        required this.dateofissue,
        required this.dateofreturn,
    });

    ObjectId id;
    String? name;
    String? regId;
    String? vjtiEmailId;
    String? fine;
    String? dateofissue;
    String? dateofreturn;

    factory MongoDbStudentModel.fromJson(Map<String, dynamic> json) => MongoDbStudentModel(
        id: json["_id"],
        name: json["name"],
        regId: json["regID"],
        vjtiEmailId: json["vjtiEmailId"],
        fine: json["fine"],
        dateofissue: json["dateofissue"],
        dateofreturn: json["dateofreturn"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "regID": regId,
        "vjtiEmailId": vjtiEmailId,
        "fine": fine,
        "dateofissue": dateofissue,
        "dateofreturn": dateofreturn,
    };
}
