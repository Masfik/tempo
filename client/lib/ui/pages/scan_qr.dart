import 'package:Tempo/models/qr.dart';
import 'package:Tempo/models/user.dart';
import 'package:Tempo/ui/misc/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ScanQrScreen extends StatefulWidget {
  @override
  _ScanQrScreenState createState() => _ScanQrScreenState();
}

class _ScanQrScreenState extends State<ScanQrScreen> {
  QR qr = QR();
  bool isValid;

  @override
  Widget build(BuildContext context) {
    print(Provider.of<User>(context, listen: false).name);
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        elevation: 0,
        backgroundColor: Theme.of(context).canvasColor,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                'images/qrcode.svg',
                color: Colors.white,
                width: 250,
              ),
              const SizedBox(height: 10),
              const Text(
                'Scan QR Code',
                style: kTextTitle,
              ),
              const Text(
                'Have an invitation from a colleague? 🤝\n'
                'Scan their QR code to quickly add them.\n\n'
                'You can also scan codes of a certain location and\n'
                'mark your presence with no hassle. 📍',
                textAlign: TextAlign.center,
                style: kTextNormal,
              ),
              const SizedBox(height: 50),
              RaisedButton(
                child: const Text("Scan QR Code"),
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
      ),
    );
  }
}