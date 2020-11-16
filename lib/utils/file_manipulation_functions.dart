import 'dart:io';

import 'package:blood_pressure_tracker/database/database.dart';
import 'package:path_provider/path_provider.dart';

Future<File> getLocalFile() async {
  var directory = await getApplicationDocumentsDirectory();
  var path = directory.path;
  var file = File('$path/blood_pressure_history.csv');
  return file;
}

Future<void> writeToFile(File file, List<Entry> content) async {
  for (int i = 0; i < content.length; i++) {
    if (i == 0) {
      await file.writeAsString(_entryToCsvFormat(content[i]));
    } else {
      await file.writeAsString('\n${_entryToCsvFormat(content[i])}',
          mode: FileMode.append);
    }
  }
}

String _entryToCsvFormat(Entry entry) {
  return '${entry.systolic},${entry.diastolic},${entry.pulse},${entry.timestamp.toIso8601String()}';
}
