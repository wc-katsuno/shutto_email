import 'package:mailer/smtp_server.dart';
import 'package:mailer/smtp_server/sendgrid.dart';

enum SmtpType {
  sendgrid,
}

class SmtpInstanceUtil {
  final SmtpType type;
  final String username;
  final String password;

  SmtpInstanceUtil(this.type, this.username, this.password);

  SmtpServer? _instance;

  Future<SmtpServer> getInstance() async {
    if (_instance == null) {
      if (type == SmtpType.sendgrid) {
        _instance = sendgrid(username, password);
      }
    }
    if(_instance == null) {
      throw Exception('Cannot create instance. SmtpType is invalid.');
    }
    return _instance!;
  }
}
