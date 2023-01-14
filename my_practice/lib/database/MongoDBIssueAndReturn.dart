// To parse this JSON data, do
//
//     final mongoDbIssueAndReturnModel = mongoDbIssueAndReturnModelFromJson(jsonString);

import 'dart:convert';

MongoDbIssueAndReturnModel? mongoDbIssueAndReturnModelFromJson(String str) =>
    MongoDbIssueAndReturnModel.fromJson(json.decode(str));

String mongoDbIssueAndReturnModelToJson(MongoDbIssueAndReturnModel? data) =>
    json.encode(data!.toJson());

class MongoDbIssueAndReturnModel {
  MongoDbIssueAndReturnModel({
    this.id,
    this.regId,
    this.bookIssue,
    this.bookReturn,
  });

  String? id;
  String? regId;
  String? bookIssue;
  String? bookReturn;

  factory MongoDbIssueAndReturnModel.fromJson(Map<String, dynamic> json) =>
      MongoDbIssueAndReturnModel(
        id: json["_id"],
        regId: json["regId"],
        bookIssue: json["bookIssue"],
        bookReturn: json["bookReturn"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "regId": regId,
        "bookIssue": bookIssue,
        "bookReturn": bookReturn,
      };
}
