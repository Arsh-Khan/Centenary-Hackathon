import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:my_practice/database/MongoDBModel.dart';
import 'package:my_practice/database/MongoDBStudentModel.dart';
import 'dbHelper/mongodb.dart';

class MongoDbInsert extends StatefulWidget {
  const MongoDbInsert({super.key});

  @override
  State<MongoDbInsert> createState() => _MongoDbInsertState();
}

class _MongoDbInsertState extends State<MongoDbInsert> {
  late final TextEditingController fnameController;
  late final TextEditingController lnameController;
  late final TextEditingController addressController;
  var _checkInsertUpdate = "Insert";

  @override
  void initState() {
    fnameController = TextEditingController();
    lnameController = TextEditingController();
    addressController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    fnameController.dispose();
    lnameController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    MongoDbModel data =
        ModalRoute.of(context)!.settings.arguments as MongoDbModel;

    if (data != null) {
      fnameController.text = data.firstName!;
      lnameController.text = data.lastName!;
      addressController.text = data.address!;
      _checkInsertUpdate = "Update";
    }
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          // contextignore: prefer_const_literals_to_create_immutables
          children: [
            Text(
              _checkInsertUpdate,
              style: TextStyle(fontSize: 22),
            ),
            const SizedBox(
              height: 50,
            ),
            TextField(
              controller: fnameController,
              decoration: InputDecoration(labelText: "First Name"),
            ),
            TextField(
              controller: lnameController,
              decoration: InputDecoration(labelText: "Last Name"),
            ),
            TextField(
              controller: addressController,
              minLines: 3,
              maxLines: 5,
              decoration: InputDecoration(labelText: "Address Name"),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                    onPressed: () {
                      _fakeData();
                    },
                    child: const Text('Generate Data')),
                ElevatedButton(
                    onPressed: () {
                      if (_checkInsertUpdate == "Update") {
                        _updateData(data.id, fnameController.text,
                            lnameController.text, addressController.text);
                      } else {
                        _insertData(fnameController.text, lnameController.text,
                            addressController.text);
                      }
                    },
                    child: Text(_checkInsertUpdate))
              ],
            )
          ],
        ),
      )),
    );
  }

  Future<void> _insertData(String fName, String lName, String address) async {
    var _id = M.ObjectId(); // this will use for unique id
    final data = MongoDbModel(
        id: _id, firstName: fName, lastName: lName, address: address);

    var result = await MongoDatabase.insert(data);

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Inserted ID" + _id.$oid)));
    _clearAll();
  }

  Future<void> _updateData(
      var id, String fName, String lName, String address) async {
    final updateData = MongoDbModel(
        id: id, firstName: fName, lastName: lName, address: address);
    await MongoDatabase.update(updateData)
        .whenComplete(() => Navigator.pop(context));
  }

  void _clearAll() {
    fnameController.text = "";
    lnameController.text = "";
    addressController.text = "";
  }

  void _fakeData() {
    setState(() {
      fnameController.text = faker.person.firstName();
      lnameController.text = faker.person.lastName();
      addressController.text =
          faker.address.streetName() + "\n" + faker.address.streetAddress();
    });
  }
}
// class MongoDbInsert extends StatefulWidget {
//   const MongoDbInsert({super.key});

//   @override
//   State<MongoDbInsert> createState() => _MongoDbInsertState();
// }

// class _MongoDbInsertState extends State<MongoDbInsert> {
//   late final TextEditingController fnameController;
//   late final TextEditingController lnameController;
//   late final TextEditingController addressController;
//   var _checkInsertUpdate = "Insert";

//   @override
//   void initState() {
//     fnameController = TextEditingController();
//     lnameController = TextEditingController();
//     addressController = TextEditingController();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     fnameController.dispose();
//     lnameController.dispose();
//     addressController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // ignore: prefer_const_constructors
//     MongoDbModel data =
//         ModalRoute.of(context)!.settings.arguments as MongoDbModel;

//     if (data != null) {
//       fnameController.text = data.firstName!;
//       lnameController.text = data.lastName!;
//       addressController.text = data.address!;
//       _checkInsertUpdate = "Update";
//     }
//     return Scaffold(
//       body: SafeArea(
//           child: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Column(
//           // contextignore: prefer_const_literals_to_create_immutables
//           children: [
//             Text(
//               _checkInsertUpdate,
//               style: TextStyle(fontSize: 22),
//             ),
//             const SizedBox(
//               height: 50,
//             ),
//             TextField(
//               controller: fnameController,
//               decoration: InputDecoration(labelText: "First Name"),
//             ),
//             TextField(
//               controller: lnameController,
//               decoration: InputDecoration(labelText: "Last Name"),
//             ),
//             TextField(
//               controller: addressController,
//               minLines: 3,
//               maxLines: 5,
//               decoration: InputDecoration(labelText: "Address Name"),
//             ),
//             const SizedBox(
//               height: 50,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 OutlinedButton(
//                     onPressed: () {
//                       _fakeData();
//                     },
//                     child: const Text('Generate Data')),
//                 ElevatedButton(
//                     onPressed: () {
//                       if (_checkInsertUpdate == "Update") {
//                         _updateData(data.id, fnameController.text,
//                             lnameController.text, addressController.text);
//                       } else {
//                         _insertData(fnameController.text, lnameController.text,
//                             addressController.text);
//                       }
//                     },
//                     child: Text(_checkInsertUpdate))
//               ],
//             )
//           ],
//         ),
//       )),
//     );
//   }

//   Future<void> _insertData(String fName, String lName, String address) async {
//     var _id = M.ObjectId(); // this will use for unique id
//     final data = MongoDbModel(
//         id: _id, firstName: fName, lastName: lName, address: address);

//     var result = await MongoDatabase.insert(data);

//     ScaffoldMessenger.of(context)
//         .showSnackBar(SnackBar(content: Text("Inserted ID" + _id.$oid)));
//     _clearAll();
//   }

//   Future<void> _updateData(
//       var id, String fName, String lName, String address) async {
//     final updateData = MongoDbModel(
//         id: id, firstName: fName, lastName: lName, address: address);
//     await MongoDatabase.update(updateData)
//         .whenComplete(() => Navigator.pop(context));
//   }

//   void _clearAll() {
//     fnameController.text = "";
//     lnameController.text = "";
//     addressController.text = "";
//   }

//   void _fakeData() {
//     setState(() {
//       fnameController.text = faker.person.firstName();
//       lnameController.text = faker.person.lastName();
//       addressController.text =
//           faker.address.streetName() + "\n" + faker.address.streetAddress();
//     });
//   }
// }

// class MongoDbStudentInsert extends StatefulWidget {
//   const MongoDbStudentInsert({super.key});

//   @override
//   State<MongoDbStudentInsert> createState() => _MongoDbStudentInsertState();
// }

// class _MongoDbStudentInsertState extends State<MongoDbStudentInsert> {
//   late final TextEditingController nameController;
//   late final TextEditingController regIdController;
//   late final TextEditingController vjtiEmailController;
//   late final TextEditingController fineController;
//   late final TextEditingController dateofissueController;
//   late final TextEditingController dateofreturnController;
//   var _checkInsertUpdate = "Insert";

//   @override
//   void initState() {
//     nameController = TextEditingController();
//     regIdController = TextEditingController();
//     vjtiEmailController = TextEditingController();
//     fineController = TextEditingController();
//     dateofissueController = TextEditingController();
//     dateofreturnController = TextEditingController();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     nameController.dispose();
//     regIdController.dispose();
//     vjtiEmailController.dispose();
//     fineController.dispose();
//     dateofissueController.dispose();
//     dateofreturnController.dispose();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // ignore: prefer_const_constructors
//     MongoDbStudentModel data =
//         ModalRoute.of(context)!.settings.arguments as MongoDbStudentModel;

//     if (data != null) {
//       nameController.text = data.name!;
//       regIdController.text = data.regId!;
//       vjtiEmailController.text = data.vjtiEmailId!;
//       fineController.text = data.fine!;
//       dateofissueController.text = data.dateofissue!;
//       dateofreturnController.text = data.dateofreturn!;

//       _checkInsertUpdate = "Update";
//     }
//     return Scaffold(
//       body: SafeArea(
//           child: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Column(
//           // contextignore: prefer_const_literals_to_create_immutables
//           children: [
//             Text(
//               _checkInsertUpdate,
//               style: TextStyle(fontSize: 22),
//             ),
//             const SizedBox(
//               height: 50,
//             ),
//             TextField(
//               controller: nameController,
//               decoration: InputDecoration(labelText: "Name"),
//             ),
//             TextField(
//               controller: regIdController,
//               decoration: InputDecoration(labelText: "Reg ID"),
//             ),
//             TextField(
//               controller: vjtiEmailController,
//               decoration: InputDecoration(labelText: "VJTI Email ID"),
//             ),
//             TextField(
//               controller: fineController,
//               decoration: InputDecoration(labelText: "Fine"),
//             ),
//             TextField(
//               controller: dateofissueController,
//               decoration: InputDecoration(labelText: "Date of Issue"),
//             ),
//             TextField(
//               controller: dateofreturnController,
//               decoration: InputDecoration(labelText: "Date of Return"),
//             ),
//             const SizedBox(
//               height: 50,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 ElevatedButton(
//                     onPressed: () {
//                       if (_checkInsertUpdate == "Update") {
//                         _updateData(
//                             data.id,
//                             nameController.text,
//                             regIdController.text,
//                             vjtiEmailController.text,
//                             fineController.text,
//                             dateofissueController.text,
//                             dateofreturnController.text);
//                       } else {
//                         _insertData(
//                             data.id,
//                             nameController.text,
//                             regIdController.text,
//                             vjtiEmailController.text,
//                             fineController.text,
//                             dateofissueController.text,
//                             dateofreturnController.text);
//                       }
//                     },
//                     child: Text(_checkInsertUpdate))
//               ],
//             )
//           ],
//         ),
//       )),
//     );
//   }

//   Future<void> _insertData(String name, String regId, String vjtiEmailId,
//       String fine, String dateofissue, String dateofreturn) async {
//     var _id = M.ObjectId(); // this will use for unique id
//     final data = MongoDbStudentModel(
//         id: _id,
//         name: name,
//         regId: regId,
//         vjtiEmailId: vjtiEmailId,
//         fine: fine,
//         dateofissue: dateofissue,
//         dateofreturn: dateofreturn);

//     var result = await MongoDatabase.insertStudentDetails(data);

//     ScaffoldMessenger.of(context)
//         .showSnackBar(SnackBar(content: Text("Inserted ID" + _id.$oid)));
//     // _clearAll();
//   }

//   Future<void> _updateData(String name, String regId, String vjtiEmailId,
//       String fine, String dateofissue, String dateofreturn) async {
//     final updateData = MongoDbStudentModel(
//         id: _id,
//         name: name,
//         regId: regId,
//         vjtiEmailId: vjtiEmailId,
//         fine: fine,
//         dateofissue: dateofissue,
//         dateofreturn: dateofreturn);
//     await MongoDatabase.studentupdate(updateData)
//         .whenComplete(() => Navigator.pop(context));
//   }

//   // void _clearAll() {
//   //   fnameController.text = "";
//   //   lnameController.text = "";
//   //   addressController.text = "";
//   // }

// }
