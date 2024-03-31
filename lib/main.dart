// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:note_app/view/note_screen/note_screen.dart';
import 'package:note_app/view/splash_screen/splash_screen.dart';

main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NoteScreen(),
    );
  }
}