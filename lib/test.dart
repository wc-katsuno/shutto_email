import 'dart:io';

import 'package:shutto_email/shutto_email.dart';

main() async {
  final smtpInstanceUtil = SmtpInstanceUtil(
    SmtpType.sendgrid,
    'apikey',
    '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',
  );

  final file = File('/Users/hiromitsu.katsuno/Documents/oneOpeデータ設計.rtf');

  await EmailMessageUtil.sendEMail(
    smtpInstanceUtil,
    'no-reply@harenchu.com',
    ['hiromitsu.katsuno@webcrew.co.jp'],
    fromName: 'テスター',
    subject: 'mailer test',
    text: 'TEXT TEST',
    attachmentFiles: [file],
  );
}
