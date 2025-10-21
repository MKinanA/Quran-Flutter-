import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:quran/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  log('started');
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App(db: await SharedPreferences.getInstance()));
}

class App extends StatelessWidget {
  final SharedPreferences db;
  const App({Key? key, required this.db}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quran',
      theme: ThemeData(
        fontFamily: 'Noto Sans',
        brightness: MediaQuery.of(context).platformBrightness
      ),
      debugShowCheckedModeBanner: false,
      home: MainScreen(db: db)
    );
  }
}