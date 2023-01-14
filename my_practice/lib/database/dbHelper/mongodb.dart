import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:my_practice/database/MongoDBFineCollectionModel.dart';
import 'package:my_practice/database/MongoDBInAndOutModel.dart';
import 'package:my_practice/database/MongoDBIssueAndReturn.dart';
import 'package:my_practice/database/MongoDBModel.dart';
import 'package:my_practice/database/MongoDBStudentModel.dart';
import 'package:my_practice/database/dbHelper/constants.dart';

class MongoDatabase {
  static var db,
      userCollection,
      studentDetails,
      fineCollection,
      inAndout,
      issuedandreturn;

  // function to connect with database
  static connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    inspect(db);
    userCollection = db.collection(USER_COLLECTION);
    studentDetails = db.collection(STUDENT_DETAILS);
    fineCollection = db.collection(FINE_COLECTION);
    inAndout = db.collection(IN_AND_OUT);
    studentDetails = db.collection(STUDENT_DETAILS);
  }

  static Future<String> insert(MongoDbModel data) async {
    try {
      var result = await userCollection.insertOne(data.toJson());
      if (result.isSuccess) {
        return "Data Inserted";
      } else {
        return "Something went wrong while inserting data";
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  static Future<String> insertStudentDetails(MongoDbStudentModel data) async {
    try {
      var result = await studentDetails.insertOne(data.toJson());
      if (result.isSuccess) {
        return "Data Inserted";
      } else {
        return "Something went wrong while inserting data";
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  static Future<String> insertFineCalculation(
      MongoDbFineCalculationModel data) async {
    try {
      var result = await fineCollection.insertOne(data.toJson());
      if (result.isSuccess) {
        return "Data Inserted";
      } else {
        return "Something went wrong while inserting data";
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  static Future<String> insertInAndOutDetails(MongoDbInandOutModel data) async {
    try {
      var result = await inAndout.insertOne(data.toJson());
      if (result.isSuccess) {
        return "Data Inserted";
      } else {
        return "Something went wrong while inserting data";
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  static Future<String> insertIssueAndReturnDetails(
      MongoDbIssueAndReturnModel data) async {
    try {
      var result = await issuedandreturn.insertOne(data.toJson());
      if (result.isSuccess) {
        return "Data Inserted";
      } else {
        return "Something went wrong while inserting data";
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  // creating a function for fetching data from mongoDb inside our MongoDatabase file
  static Future<List<Map<String, dynamic>>> getData() async {
    final arrData = await userCollection
        .find()
        .toList(); // collection name then .find() it will get all data and .toList will convert data into list(array)
    return arrData;
  }

  static Future<List<Map<String, dynamic>>> getStudentData() async {
    final arrData = await studentDetails
        .find()
        .toList(); // collection name then .find() it will get all data and .toList will convert data into list(array)
    return arrData;
  }

  static Future<List<Map<String, dynamic>>> getFineData() async {
    final arrData = await fineCollection
        .find()
        .toList(); // collection name then .find() it will get all data and .toList will convert data into list(array)
    return arrData;
  }

  static Future<List<Map<String, dynamic>>> getInAndOutData() async {
    final arrData = await inAndout
        .find()
        .toList(); // collection name then .find() it will get all data and .toList will convert data into list(array)
    return arrData;
  }

  static Future<List<Map<String, dynamic>>> getIssuedAndReturnData() async {
    final arrData = await issuedandreturn
        .find()
        .toList(); // collection name then .find() it will get all data and .toList will convert data into list(array)
    return arrData;
  }

//---
  static Future<void> update(MongoDbModel data) async {
    var result = await userCollection.findOne({"_id": data.id});
    result['firstName'] = data.firstName;
    result['lastName'] = data.lastName;
    result['address'] = data.address;

    var response = await userCollection.save(result);
    inspect(response);
  }

  static Future<void> studentupdate(MongoDbStudentModel data) async {
    var result = await studentDetails.findOne({"_id": data.id});
    result['name'] = data.name;
    result['regID'] = data.regId;
    result['fine'] = data.fine;
    result['vjtiEmailId'] = data.vjtiEmailId;
    result['dateofissue'] = data.dateofissue;
    result['dateofreturn'] = data.dateofreturn;

    var response = await studentDetails.save(result);
    inspect(response);
  }

  static Future<void> inAndOutupdate(MongoDbInandOutModel data) async {
    var result = await inAndout.findOne({"regId": data.regId});
    result['outTime'] = data.outTime;

    var response = await inAndout.save(result);
    inspect(response);
  }

  // static Future<void> inAndOutupdate(MongoDbInandOutModel data) async {
  //   var result = await studentDetails.findOne({"_id": data.id});
  //   result['name'] = data.name;
  //   result['regID'] = data.regId;
  //   result['fine'] = data.fine;
  //   result['vjtiEmailId'] = data.vjtiEmailId;
  //   result['dateofissue'] = data.dateofissue;
  //   result['dateofreturn'] = data.dateofreturn;

  //   var response = await studentDetails.save(result);
  //   inspect(response);
  // }

  static Future<void> fineupdate(MongoDbFineCalculationModel data) async {
    var result = await fineCollection.findOne({"regId": data.regId});
    result['name'] = data.name;
    result['regID'] = data.regId;
    result['fine'] = data.fine;

    var response = await fineCollection.save(result);
    inspect(response);
  }

  //---

  static delete(MongoDbModel user) async {
    await userCollection.remove(where.id(user.id));
  }

  // use for query
  static Future<List<Map<String, dynamic>>> getQueryData() async {
    final data =
        await userCollection.find(where.eq('firstName', 'name')).toList();
    return data;
  }

  static Future<List<Map<String, dynamic>>> getFineQueryData(
      String regId) async {
    final data = await fineCollection.find(where.eq('regId', regId)).toList();
    return data;
  }

  static Future<List<Map<String, dynamic>>> getInAndOutQueryData(
      String regId) async {
    final data = await inAndout.find(where.eq('regId', regId)).toList();
    return data;
  }

  static Future<List<Map<String, dynamic>>> getIssueAndReturnQueryData(
      ObjectId id) async {
    final data = await issuedandreturn.find(where.eq('_id', id)).toList();
    return data;
  }
  //where.eq('age','43')  --> first will field name (column) second will be value --- this will return same age as value (matched value)
  //where.gt('age','43')  --> first will field name (column) second will be value --- this will return same age value greater than value
  // where.gt('age','30').lt('age','50') --> details of student between age 30 to 50
  // where.gt().eq()

}
