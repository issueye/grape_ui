

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';

void initLogging(String name) {
  Logger.root.level = Level.ALL;

  Logger.root.onRecord.listen((record) {
    debugPrint('${record.level.name}: ${record.time}: ${record.message}');
    _writeLogToFile(record, name);
  });
}

void _writeLogToFile(LogRecord record, String name) async {
  var path = '';
  if (Platform.isWindows) {
    path = './$name.txt';
  } else {
    final directory = await getApplicationSupportDirectory();
    path = '${directory.path}/$name.txt';
  }
  final file = File(path);
  debugPrint(file.path);
  final logMessage = '${record.level.name}: ${record.time}: ${record.message}\n';

  await file.writeAsString(logMessage, mode: FileMode.append);
}