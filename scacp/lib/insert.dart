import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:scacp/MongoDBModel.dart';

class MongoDbInsert extends StatefulWidget {
  const MongoDbInsert({super.key});

  @override
  State<MongoDbInsert> createState() => _MongoDbInsertState();
}

class _MongoDbInsertState extends State<MongoDbInsert> {
  var fnameController = new TextEditingController();
  var lnameController = new TextEditingController();
  var addressController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const Text(
              'Insert Data',
              style: TextStyle(fontSize: 22),
            ),
            const SizedBox(
              height: 50,
            ),
            const TextField(
              controller: fnameController,
              decoration: InputDecoration(labelText: "First Name"),
            ),
            const TextField(
              controller: lnameController,
              decoration: InputDecoration(labelText: "Last Name"),
            ),
            const TextField(
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
                    onPressed: () {_insertData(fnameController.text,lnameController.text,addressController.text)}, child: const Text('Insert Data'))
              ],
            )
          ],
        ),
      )),
    );
  }

  Future<void> _insertData(String fName,String lName,String address) async{
    var _id = M.ObjectId();  // this will use for unique id
    final data = MongoDbModel(id: _id, firstName: fName, lastName: lName, address: address);
    
    var result = await MongoDbInsert(data);
    
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Inserted ID" + _id.$oid)));
    _clearAll();
  }

  void _clearAll()
  {
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
