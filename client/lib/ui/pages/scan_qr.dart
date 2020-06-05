import 'package:Tempo/models/qr.dart';
import 'package:Tempo/models/user.dart';
import 'package:Tempo/repositories/api/meeting_repository.dart';
import 'package:Tempo/ui/misc/style.dart';
import 'package:Tempo/ui/widgets/misc/simple_error_dialog.dart';
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
                onPressed: () => _scan()
              ),
            ],
          ),
        ),
      ),
    );
  }

  _scan() async {
    if (!await qr.scan()) {
      showDialog(context: context, builder: (context) => SimpleErrorDialog(
        title: 'Invalid Code',
        message: "The QR or barcode scanned doesn't match the correct format."
      ));
      return;
    }

    switch (qr.type) {
      case QRType.invitation:
        // TODO: temporary POC data
        String name = qr.data == "1733861" ? "Masfik H" :
                      qr.data == "1734675" ? "Adalberto Medina" :
                      "User";

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircleAvatar(
                  child: Image.asset('images/user.png'),
                ),
                SizedBox(height: 5),
                Text(name, style: kTextTitle),
                Text('Added successfully 🤝', style: kTextNormal)
              ],
            ),
          )
        );
        break;
      case QRType.location:
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.add_location),
                Text('Presence Marked!', style: kTextTitle),
                SizedBox(height: 10),
                Text(
                  "You've been marked as present in room ${qr.data}! 👍",
                  textAlign: TextAlign.center,
                  style: kTextNormal
                )
              ],
            )
          )
        );

        User user = Provider.of<User>(context, listen: false);

        Provider.of<MeetingRepository>(context, listen: false)
            .checkIn(user.email, 'L-${qr.data}');
        break;
    }
  }
}
