import 'package:Tempo/models/qr.dart';
import 'package:Tempo/ui/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        title: Text(''),
        elevation: 0,
        backgroundColor: kTempoThemeData.canvasColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              'images/qrcode-solid.svg',
              color: Colors.white,
              width: 200,
            ),
            SizedBox(height: 30),
            Text(
              'Scan QR Code',
              style: kTextTitle,
            ),
            Text(
              'Have an invitation from a colleague? 🤝\n'
              'Scan their QR code to quickly add them.\n\n'
              'You can also scan codes of a certain location and\n'
              'mark your presence with no hassle. 📍',
              textAlign: TextAlign.center,
              style: kTextNormal,
            ),
            SizedBox(height: 50),
            RaisedButton(
              child: Text("Scan QR Code"),
              color: kTempoThemeData.accentColor,
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