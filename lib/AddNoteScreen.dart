import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AddNoteScreen extends StatefulWidget {

  final Map? note;
  final int? index;

  const AddNoteScreen({
    super.key,
    this.note,
    this.index,
  });

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {

  final titleController = TextEditingController();
  final contentController = TextEditingController();

  final Box notesBox = Hive.box("notes");

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      titleController.text = widget.note!["title"];
      contentController.text = widget.note!["content"];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.note == null
              ? "Add Note"
              : "Edit Note",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Title",
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: contentController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: "Content",
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Map<String, dynamic> note = {
                  "title": titleController.text,
                  "content": contentController.text,
                  "date": DateTime.now().toString(),
                };

                if (widget.note == null) {
                  // CREATE
                  notesBox.add(note);
                } else {

                  // UPDATE
                  notesBox.putAt(
                    widget.index!,
                    note,
                  );
                }
                Navigator.pop(context);
              },
              child: Text(
                widget.note == null
                    ? "Save"
                    : "Update",
              ),
            )
          ],
        ),
      ),
    );
  }
}