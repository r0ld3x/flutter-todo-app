import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:untitled/pages/home_page.dart';

void main() async {
  await Hive.initFlutter();

  await Hive.openBox('myBox');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
