import 'package:Tempo/models/qr.dart';
import 'package:flutter/material.dart';

class ScanQrScreen extends StatefulWidget {
  @override
  _ScanQrScreenState createState() => _ScanQrScreenState();
}

class _ScanQrScreenState extends State<ScanQrScreen> {
  QR qr = QR();
  bool isValid;

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
            Text(qr.data),
            RaisedButton(
              child: Text("Scan QR Code"),
              onPressed: () async {
                if (await qr.scan())
                  setState(() => isValid = true);
                else
                  setState(() => isValid = false);
              }
            ),
          ],
        ),
      ),
    );
  }
}