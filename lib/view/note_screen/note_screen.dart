// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:note_app/controller/note_screen_controller.dart';
import 'package:note_app/core/constants/color_constants.dart';
import 'package:note_app/view/note_screen/widget/note_card.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  @override
  void initState() {
    NoteScreenController.initKeys();
    super.initState();
  }

  TextEditingController titlecontroller = TextEditingController();
  TextEditingController desccontroller = TextEditingController();
  TextEditingController datecontroller = TextEditingController();
  int selectedclrIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemCount: NoteScreenController.noteListKeys.length,
        itemBuilder: (context, index) {
          final currentKey = NoteScreenController.noteListKeys[index];
          final currentElement = NoteScreenController.myBox.get(currentKey);
          return NoteCard(
            title: currentElement["title"],
            desc: currentElement["desc"],
            date: currentElement["date"],
            clrIndex: currentElement["colorIndex"],
            onDeletePressed: () async {
              await NoteScreenController.deleteNote(currentKey);
              setState(() {});
            },
            onEditPressed: () {
              titlecontroller.text = currentElement["title"];
              desccontroller.text = currentElement["desc"];
              datecontroller.text = currentElement["date"];
              selectedclrIndex = currentElement["colorIndex"];
              customBottomSheet(
                  context: context, isEdit: true, currentKey: currentKey);
            },
          );
        },
        separatorBuilder: (context, index) => SizedBox(height: 7),
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {
          titlecontroller.clear();
          desccontroller.clear();
          datecontroller.clear();
          selectedclrIndex = 0;
          customBottomSheet(context: context);
        },
        child: Icon(
          Icons.add,
          color: ColorConstants.black,
        ),
        backgroundColor: ColorConstants.teal,
      ),
    );
  }

  Future<dynamic> customBottomSheet(
      {required BuildContext context, bool isEdit = false, var currentKey}) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, bottomState) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(isEdit == true ? "Update Note" : "Add Note"),
              SizedBox(height: 10),
              TextFormField(
                controller: titlecontroller,
                cursorColor: ColorConstants.clr1,
                cursorWidth: 2,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    hintText: "Title"),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: desccontroller,
                maxLines: 4,
                cursorColor: ColorConstants.clr1,
                cursorWidth: 2,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  hintText: "Description",
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                readOnly: true,
                controller: datecontroller,
                cursorColor: ColorConstants.clr1,
                cursorWidth: 2,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  hintText: "Date",
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  suffixIcon: InkWell(
                    onTap: () async {
                      final dateTime = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2050),
                      );
                      if (dateTime != null) {
                        String formatDate =
                            DateFormat("dd-MMM-yyyy").format(dateTime);
                        datecontroller.text = formatDate.toString();
                      }

                      bottomState(() {});
                    },
                    child: Icon(
                      Icons.date_range_rounded,
                      color: ColorConstants.black,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                    4,
                    (index) => InkWell(
                          onTap: () {
                            bottomState(() {
                              selectedclrIndex = index;
                            });
                          },
                          child: Container(
                            width: 80,
                            height: 60,
                            decoration: BoxDecoration(
                                border: selectedclrIndex == index
                                    ? Border.all(color: Colors.black, width: 3)
                                    : null,
                                borderRadius: BorderRadius.circular(10),
                                color: NoteScreenController.colorList[index]),
                          ),
                        )),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () async {
                      if (isEdit == true) {
                        NoteScreenController.editNote(
                          key: currentKey,
                          title: titlecontroller.text,
                          desc: desccontroller.text,
                          date: datecontroller.text,
                          clrIndex: selectedclrIndex,
                        );
                      } else {
                        if (titlecontroller.text.isEmpty &&
                            desccontroller.text.isEmpty) {
                          SizedBox();
                        } else {
                          await NoteScreenController.addNote(
                            title: titlecontroller.text,
                            desc: desccontroller.text,
                            date: datecontroller.text,
                            clrIndex: selectedclrIndex,
                          );
                        }
                      }
                      Navigator.pop(context);
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 7),
                      width: 80,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          isEdit == true ? "Edit" : "Add",
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 7),
                      width: 80,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      }),
    );
  }
}
