import 'package:flutter/material.dart';
import 'package:note_app/core/constants/color_constants.dart';

class NoteScreenController {
  static List noteList = [];

  static List<Color> colorList = [
    ColorConstants.clr1,
    ColorConstants.clr2,
    ColorConstants.clr3,
    ColorConstants.clr4,
  ];
  static void addNote({
    required String title,
    required String desc,
    required String date,
    int clrIndex = 0,
  }) {
    noteList.add({
      "title": title,
      "desc": desc,
      "date": date,
      "colorIndex": clrIndex,
    });
  }

  static void deleteNote(int index) {
    noteList.removeAt(index);
  }

  static void editNote({
    required int index,
    required String title,
    required String desc,
    required String date,
    int clrIndex = 0,
  }) {
    noteList[index] = {
      "title": title,
      "desc": desc,
      "date": date,
      "colorIndex": clrIndex,
    };
  }
}
