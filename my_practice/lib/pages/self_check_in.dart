import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

var getResult = 'QR Code Result';
var mounted = true;

class My_customized_widget_in extends StatefulWidget {
  const My_customized_widget_in({super.key});

  @override
  State<My_customized_widget_in> createState() =>
      _My_customized_widgetState_in();
}

class _My_customized_widgetState_in extends State<My_customized_widget_in> {
// var getResult = 'QR Code Result';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Self Check in Page"),
          backgroundColor: Color.fromARGB(255, 245, 95, 145),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 50, 0, 45),
                child: Text(
                  '''Instructions''',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 0, 50, 100),
                child: Text(
                  ''' * Scan the qr code. If the book is available, you would be able to slide to the next screen.\n\n * Check the conditions and give your consent to it. \n\n * In case, the book is not availble, you can request for it and receive the notification as soon as the book is available for the same. 
                ''',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  scanQrcode();
                },
                child: Text('Scan QR'),
              ),
              ElevatedButton(
                  onPressed: () {
                    //
                  },
                  child: Text("request book")),
              SizedBox(
                height: 20,
              ),
              Text(getResult)
            ],
          ),
        ),
      ),
    );
  }

  void scanQrcode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'cancel', true, ScanMode.BARCODE);

      if (!mounted) return;

      setState(() {
        getResult = qrCode;
      });

      print("qr code result..........");
      print(qrCode);
    } on PlatformException {
      getResult = "fail to scan";
    }
  }
}
