import 'dart:io';

import 'package:logging/logging.dart';
import 'package:mailer/mailer.dart';
import 'package:shutto_email/src/smtp_instance_util.dart';

final _logger = Logger('EmailMessageUtil');

class EmailMessageUtil {
  static Future<bool> sendEMail(
    SmtpInstanceUtil smtpInstance,
    String from,
    List<String> recipients, {
    List<String>? ccRecipients,
    List<String>? bccRecipients,
    String? fromName,
    String? subject,
    String? text,
    String? html,
    List<File>? attachmentFiles,
  }) async {
    try {
      final message = Message()..recipients.addAll(recipients);
      if (fromName != null) {
        message.from = Address(from, fromName);
      } else {
        message.from = Address(from);
      }
      if (ccRecipients != null) {
        message.ccRecipients.addAll(ccRecipients);
      }
      if (bccRecipients != null) {
        message.bccRecipients.addAll(bccRecipients);
      }
      if (subject != null) {
        message.subject = subject;
      }
      if (text != null) {
        message.text = text;
      }
      if (html != null) {
        message.html = html;
      }
      if(attachmentFiles != null) {
        for(final attachmentFile in attachmentFiles) {
          message.attachments.add(FileAttachment(attachmentFile));
        }
      }
      final smtpServer = await smtpInstance.getInstance();
      final sendReports = await send(message, smtpServer);

      // print('Message sent: $sendReports');
      _logger.info('Message sent: $sendReports');
      return true;
    } on MailerException catch (e) {
      // print('Message not sent.');
      _logger.shout('Message not sent.');
      for (var p in e.problems) {
        // print(('Problem: ${p.code}: ${p.msg}'));
        _logger.shout(('Problem: ${p.code}: ${p.msg}'));
      }
    } catch (e) {
      // print('Message not sent. : $e');
      _logger.shout('Message not sent.');
      _logger.shout(e.toString());
    }
    return false;
  }
}
