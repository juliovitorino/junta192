import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class SessionStorageAppleSignIn {

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    print(path);
    return File('$path/session-apple-signin.json');
  }

  Future<String> readSession() async {
    try {
      final file = await _localFile;

      // Read the file
      String contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return "no session" string
      return "no session";
    }
  }
  Future<File> deleteSession() async {
    final file = await _localFile;

    // Delete the file
    return file.delete();
  }

  Future<File> writeSession(String json) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString('$json', flush: true);
  }
}
