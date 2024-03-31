// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:note_app/controller/note_screen_controller.dart';

class NoteCard extends StatelessWidget {
  const NoteCard(
      {super.key,
      required this.title,
      required this.desc,
      required this.date,
      required this.clrIndex,
      this.onDeletePressed,
      this.onEditPressed});
  final String title;
  final String desc;
  final String date;
  final int clrIndex;
  final void Function()? onDeletePressed;
  final void Function()? onEditPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: NoteScreenController.colorList[clrIndex]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title),
                Row(
                  children: [
                    InkWell(
                      onTap: onEditPressed,
                      child: Icon(Icons.edit),
                    ),
                    SizedBox(width: 12),
                    InkWell(
                      onTap: onDeletePressed,
                      child: Icon(Icons.delete),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(desc),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  date,
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(width: 12),
                Icon(Icons.share),
              ],
            )
          ],
        ),
      ),
    );
  }
}
