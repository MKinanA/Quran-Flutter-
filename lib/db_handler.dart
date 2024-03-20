import 'dart:developer';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';

Future<String?> readFile(String filePath) async {
  try {
    File file = await File(filePath).create();
    String contents = await file.readAsString();
    return contents;
  } catch (e) {
    log('Error reading file: $e');
  }
  return null;
}

Future<bool?> writeFile(String filePath, String content) async {
  try {
    File file = await File(filePath).create();
    await file.writeAsString(content);
    return true;
  } catch (e) {
    log('Error writing to file: $e');
  }
  return false;
}

Future<Map?> getBookmarks([String? surat]) async {
  Map bookmarks = {};
  try {
    bookmarks = jsonDecode('${await readFile('${(await getExternalStorageDirectory())?.path}/bookmarks.json')}');
  } catch (e) {
    log('bookmarks.json was empty, initializing it');
    bookmarks = {};
    writeFile('${(await getExternalStorageDirectory())?.path}/bookmarks.json', '{}');
  }
  return bookmarks;
}

Future<void> logExternalStorageDirectorySync() async {
  log('This device\'s accessible storage directory path: ${(await getExternalStorageDirectory())?.path}');
}