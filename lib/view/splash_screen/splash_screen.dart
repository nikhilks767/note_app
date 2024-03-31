// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/core/constants/color_constants.dart';
import 'package:note_app/view/note_screen/note_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState() {
    Timer(Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => NoteScreen(),
          ),
          (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.clr1,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "assets/noteapp.png",
              scale: 10,
            ),
            SizedBox(height: 10),
            Text(
              "NoteApp",
              style: GoogleFonts.rem(
                color: ColorConstants.black,
                fontWeight: FontWeight.w900,
                fontSize: 25,
              ),
            )
          ],
        ),
      ),
    );
  }
}
