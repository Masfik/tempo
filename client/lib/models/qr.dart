import 'dart:typed_data' show Uint8List;
import 'package:qrscan/qrscan.dart' as scanner;

enum QRType { invitation, location }

class QR {
  String _data = '';
  QRType _type;
  Uint8List bytes;

  get data => _data;

  QRType get type => _type;

  Future<bool> scan() async {
    String query = await scanner.scan();

    if (query.length >= 3 && query.startsWith('L-')) {
      _data = query.substring(2);
      _type = QRType.location;

      return true;
    } else if (query.length == 7) {
      // Checks if the QR code scanned is an integer
      try {
        int.parse(query);
        _data = query;
        _type = QRType.invitation;

        return true;
      } catch (e) { }
    }
    return false;
  }
}
