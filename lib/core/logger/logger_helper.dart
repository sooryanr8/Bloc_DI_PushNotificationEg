import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

class LoggerHelper {
  static Logger? _logger;

  static Future<void> initialize() async {
    if (_logger != null) return;

    final directory = await getApplicationDocumentsDirectory();

    final logsDir = Directory('${directory.path}/logs');

    if (!logsDir.existsSync()) {
      logsDir.createSync(recursive: true);
    }

    final file = File('${logsDir.path}/app_logs.txt');

    _logger = Logger(
      printer: PrettyPrinter(
        methodCount: 0,
        errorMethodCount: 5,
        printEmojis: true,
      ),

      output: MultiOutput([ConsoleOutput(), FileOutput(file: file)]),
    );

    logInfo('Logger initialized');
  }

  static Logger get instance {
    if (_logger == null) {
      throw Exception('Logger not initialized');
    }

    return _logger!;
  }
}

class FileOutput extends LogOutput {
  final File file;

  FileOutput({required this.file});

  @override
  void output(OutputEvent event) {
    for (final line in event.lines) {
      file.writeAsStringSync('$line\n', mode: FileMode.append);
    }
  }
}

void logInfo(String msg) => LoggerHelper.instance.i(msg);

void logDebug(String msg) => LoggerHelper.instance.d(msg);

void logWarning(String msg) => LoggerHelper.instance.w(msg);

void logError(String msg, {dynamic error, StackTrace? stackTrace}) {
  LoggerHelper.instance.e(msg, error: error, stackTrace: stackTrace);
}

void logApi({
  required String method,
  required String url,
  dynamic request,
  dynamic response,
}) {
  logInfo('''[$method]URL:$url REQUEST:$request RESPONSE:$response''');
}
