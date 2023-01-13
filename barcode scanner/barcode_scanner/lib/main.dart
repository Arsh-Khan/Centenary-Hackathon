import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(My_customized_widget());
}

var getResult = 'QR Code Result';
var mounted = true;

class My_customized_widget extends StatefulWidget {
  const My_customized_widget({super.key});

  @override
  State<My_customized_widget> createState() => _My_customized_widgetState();
}

class _My_customized_widgetState extends State<My_customized_widget> {
// var getResult = 'QR Code Result';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Barcode scanner"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  scanQrcode();
                },
                child: Text('Scan QR'),
              ),
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

// ignore: empty_catches

