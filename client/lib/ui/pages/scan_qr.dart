import 'dart:typed_data' show Uint8List;
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class ScanQrScreen extends StatefulWidget {
  @override
  _ScanQrScreenState createState() => _ScanQrScreenState();
}

class _ScanQrScreenState extends State<ScanQrScreen> {
  String qrData = '';
  Uint8List bytes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scan QR Code"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(qrData),
            RaisedButton(
              child: Text("Scan QR Code"),
              onPressed: _scan
            ),
          ],
        ),
      ),
    );
  }

  Future _scan() async {
    String code = await scanner.scan();
    setState(() => this.qrData = code);
  }
}