import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:scacp/MongoDBModel.dart';
import 'package:scacp/dbHelper/constants.dart';

class MongoDatabase {
  static var db, userCollection;

  // function to connect with database
  static connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    inspect(db);
    userCollection = db.collection(USER_COLLECTION);
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

  // creating a function for fetching data from mongoDb inside our MongoDatabase file
  static Future<List<Map<String, dynamic>>> getData() async {
    final arrData = await userCollection
        .find()
        .toList(); // collection name then .find() it will get all data and .toList will convert data into list(array)
    return arrData;
  }
}
