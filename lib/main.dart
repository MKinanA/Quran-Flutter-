import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:quran/main_screen.dart';
import 'package:quran/db_handler.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    logExternalStorageDirectorySync();
    () async {
      log('Bookmarks data: ${await getBookmarks()}');
    }();
    return MaterialApp(
      title: 'Quran',
      theme: ThemeData(
        fontFamily: 'Noto Sans',
        brightness: MediaQuery.of(context).platformBrightness
      ),
      home: const MainScreen()
    );
  }
}