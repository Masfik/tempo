import 'dart:typed_data' show Uint8List;
import 'package:qrscan/qrscan.dart' as scanner;

enum QRType { invitation, location }

class QR {
  String _data = '';
  QRType _type;
  Uint8List bytes;

  get data => _data;

  get type => _type;

  Future<bool> scan() async {
    var query = await scanner.scan();

    if (query.length == 7) {
      try {
        int.parse(query);
        _data = query;
        _type = QRType.invitation;

        return true;
      } catch (e) {
        return false;
      }
    } else if (query.length == 9 && query.startsWith('L-')) {
      _data = _data.substring(2);
      _type = QRType.location;

      return true;
    }
    return false;
  }
}
