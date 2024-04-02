import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:note_app/core/constants/color_constants.dart';

class NoteScreenController {
  static List noteListKeys = [];

  static List<Color> colorList = [
    ColorConstants.clr1,
    ColorConstants.clr2,
    ColorConstants.clr3,
    ColorConstants.clr4,
  ];

  static var myBox = Hive.box("noteBox");

  static initKeys() {
    noteListKeys = myBox.keys.toList();
  }

  static Future<void> addNote({
    required String title,
    required String desc,
    required String date,
    int clrIndex = 0,
  }) async {
    await myBox.add({
      "title": title,
      "desc": desc,
      "date": date,
      "colorIndex": clrIndex,
    });
    noteListKeys = myBox.keys.toList();
  }

  static Future<void> deleteNote(var key) async {
    await myBox.delete(key);
    noteListKeys = myBox.keys.toList();
  }

  static void editNote({
    required var key,
    required String title,
    required String desc,
    required String date,
    int clrIndex = 0,
  }) {
    // noteListKeys[key] = {
    //   "title": title,
    //   "desc": desc,
    //   "date": date,
    //   "colorIndex": clrIndex,
    // };
    myBox.put(key, {
      "title": title,
      "desc": desc,
      "date": date,
      "colorIndex": clrIndex,
    });
  }
}
